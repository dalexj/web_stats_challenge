Rails.application.routes.draw do
  get '/top_urls', to: 'stats#top_urls'
end
