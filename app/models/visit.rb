class Visit < Sequel::Model
  plugin :validation_helpers
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
