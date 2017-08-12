# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( vendor.js app.js )

Rails.application.configure do
  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '/assets/*', headers: :any, methods: [:get, :head]
    end
  end
end