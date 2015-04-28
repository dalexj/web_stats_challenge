Rails.application.routes.draw do
  get '/top_urls', to: 'stats#top_urls'
  get '/top_referrers', to: 'stats#top_referrers'
end
