class Visit < Sequel::Model
  plugin :validation_helpers

  # this method returns data in the following format
  # [
  #   {:url=>"https://example.com/", :visits=>1},
  #   {:url=>"https://example.com/2", :visits=>2}
  # ]
  def self.counts_on_date(date)
    Visit.db["SELECT `url`, count(*) as visits FROM `visits` WHERE (`created_at` = ?) GROUP BY `url` ORDER BY `visits` DESC", date].all
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

  private

  def create_hash
    self.hash = Digest::MD5.hexdigest(columns_to_digest)
    save
  end

  def columns_to_digest
    {id: id, url: url, referrer: referrer, created_at: created_at }.to_s
  end
end
