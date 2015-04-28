db = Sequel.mysql2(user: "root", password: ENV["MYSQL_PASSWORD"], database: Rails.env)

def random_date
  rand(100).days.ago
end

def random_referrer
  [
    "http://apple.com",
    "https://apple.com",
    "https://www.apple.com",
    "http://developer.apple.com",
    nil,
  ].sample
end

def random_url
  [
    "http://apple.com",
    "https://apple.com",
    "https://www.apple.com",
    "http://developer.apple.com",
    "http://en.wikipedia.org",
    "http://opensource.org",
  ].sample
end

def referrer_to_sql(referrer)
  referrer ? "'#{referrer}'" : "NULL"
end

def create_random_visit(id)
  visit = { id: id, url: random_url, referrer: random_referrer, created_at: random_date }
  visit[:hash] = Digest::MD5.hexdigest(visit.to_s)
  "(#{visit[:id]}, '#{visit[:url]}', '#{visit[:created_at].to_date.to_s}', #{referrer_to_sql(visit[:referrer])}, '#{visit[:hash]}')"
end

db[:visits].delete

batch_size = 10_000

(1_000_000 / batch_size).times do |i|
  visits = (1..batch_size).map { |j| create_random_visit(batch_size * i + j) }.join(", ")
  db.run "INSERT INTO visits (id, url, created_at, referrer, hash) VALUES #{visits}"
  puts "#{i.next * batch_size} visits created"
end
