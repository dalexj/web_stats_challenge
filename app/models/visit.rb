class Visit < Sequel::Model
  plugin :validation_helpers

  # this method returns urls + counts on a day in the following format
  # [
  #   {:url=>"https://example.com/", :visits=>1},
  #   {:url=>"https://example.com/2", :visits=>2}
  # ]
  def self.counts_on_date(date, limit = nil)
    limit = " LIMIT #{limit}" if limit
    Visit.db["SELECT `url`, count(*) as visits FROM `visits` WHERE (`created_at` = ?) GROUP BY `url` ORDER BY `visits` DESC#{limit}", date].all
  end

  # this method returns referrers from a url on a date
  # in the same format as counts_on_date
  def self.referrers_for_url_on_date(url, date)
    db["SELECT `referrer` as url, count(*) as visits FROM `visits` WHERE (`created_at` = ?) && (`url` = ?) GROUP BY `referrer` ORDER BY `visits` DESC LIMIT 5", date, url].all
  end

  def validate
    super
    validates_presence [:url, :created_at]
  end

  def after_create
    create_hash
    super
  end

  def digested_hash
    @values[:hash]
  end

  def before_save
    self.created_at = self.created_at.to_date
    super
  end

  private

  def create_hash
    self.hash = Digest::MD5.hexdigest(columns_to_digest)
    save
  end

  def columns_to_digest
    {id: id, url: url, referrer: referrer, created_at: created_at }.to_s
  end
end
