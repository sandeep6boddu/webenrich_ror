# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( mobile.css mobile.js )
Rails.application.config.assets.precompile += %w( blog.css blog.js )
Rails.application.config.assets.precompile += %w( lp.css lp.js )
Rails.application.config.assets.precompile += %w( admin.css backend.css backend.js admin.js)
Rails.application.config.assets.precompile += %w( fontawesome/fonts/fontawesome-webfont.eot )
Rails.application.config.assets.precompile += %w( fontawesome/fonts/fontawesome-webfont.woff )
Rails.application.config.assets.precompile += %w( fontawesome/fonts/fontawesome-webfont.ttf )
Rails.application.config.assets.precompile += %w( fontawesome/fonts/fontawesome-webfont.svg )
Rails.application.config.assets.precompile += %w( simple-line-icons/fonts/Simple-Line-Icons.eot )
Rails.application.config.assets.precompile += %w( simple-line-icons/fonts/Simple-Line-Icons.eot )
Rails.application.config.assets.precompile += %w( simple-line-icons/fonts/Simple-Line-Icons.woff )
Rails.application.config.assets.precompile += %w( simple-line-icons/fonts/Simple-Line-Icons.ttf )
Rails.application.config.assets.precompile += %w( simple-line-icons/fonts/Simple-Line-Icons.svg )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
