Rails.application.routes.draw do

	devise_for :users, path: 'admin', path_names: { sign_up: 'signup', sign_in: 'login', sign_out: 'logout'}, :controllers => { :sessions=> "sessions", :registrations => "registrations", :passwords=>"passwords", :invitations => "invitations" }
	# devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "signup" }, :controllers => { :sessions=> "sessions" }
	# The priority is based upon order of creation: first created -> highest priority.
	# See how all your routes lay out with "rake routes".

	# admin routes
	get '/admin'	=> 'admin#dashboard'
	post '/careers/applicant' => 'home#applicant', as: 'careers_applicant'
	scope module: 'admin', path: 'admin' do
		resources :careers
		resources :users
		resources :portfolios do
			collection { post :sort }
		end
		resources :testimonials
		resources :clients do
			collection { post :sort }
		end
		resources :teams do
			collection { post :sort }
		end
		resources :blogs
		# constraints subdomain: 'blogs' do
		# 	resources :blogs
		# end
		resources :categories do
			collection { post :sub }
			collection { post :sort }
		end
	end
	# You can have the root of your site routed with "root"
	root 'home#index'
	get 'clear-cache'						=> 'admin#clear_cache',	as: :clear_cache
	get '/partial/our-clients' => 'home#clients_partial'
	get '/who-we-are' => 'home#about_us', as: 'about_us'
	get '/our-process' => 'home#about_us_process', as: 'about_us_process'
	get '/our-team' => 'home#about_our_team', as: 'about_our_team'
	get '/clients' => 'home#clients', as: 'clients_home'
	#post '/clients' => 'home#quick_contact_form'
	post '/quick-contact-form' => 'home#quick_contact_form'
	get '/contact' => 'home#contact', as: 'contact_us'
	post '/contact-us' => 'home#contact_details', as: 'contacts'
	post '/lp-contact-us' => 'home#lp_contact_details', as: 'lp_contact_us'
	post '/quick-enquiry-form'	=>	'home#quick_enquiry_form'
	get '/partner-with-us' => 'home#partner_with_us'
	get '/work-with-us' => 'home#careers', as: 'career_home'
	get '/testimonials' => 'home#testimonials', as: 'testimonials_home'
	get '/careers/:title' => 'home#careers_details', as: 'careers_details'
	get '/portfolio' => 'home#portfolio', as: 'portfolio_home'
	get '/portfolio/:category/:title' => 'home#portfolio_details', as: 'portfolio_category_details'
	get '/portfolio/:title' => 'home#portfolio_single', as: 'portfolio_details'
	get '/request-a-quote' => 'home#request_quote'
	post '/request-a-quote' => 'home#quote', as: 'quotes'
	post '/mobile-quote'	=> 'home#m_quote'
	get '/mail' => 'home#mail'
	get '/privacy-policy' => 'home#privacy_policy'
	get '/google-adwords-certified-partner' => 'home#google_partner'
	get '/microsoft-bing-certified-partner' => 'home#bing_partner'
	get '/thankyou' => 'home#thankyou'
	get '/lp-thankyou' => 'home#lp_thankyou'
	get '/sitemap.xml', :to => 'home#sitemap', :defaults => { :format => 'xml' }
	get '/lp/ror' => 'lp/ror#index'
	get '/lp/mobile-apps' => 'lp/mobile_apps#index'
	get '/lp/ecommerce' => 'lp/ecommerce#index'



	get '/what-we-do' => 'services#index', as: 'services'
	scope module: "services" do
		# Web Design module
		scope controller: 'web_design' do
			get '/web-design' => :index
			get '/corporate-branding' => :corporate_branding
			get '/mobile-website-design' => :mobile_website_design
			get '/responsive-website-designing' => :responsive_website_design, as: 'responsive_website_design'
			get '/website-maintenance' => :website_maintenance
		end
		# Web Development module
		scope controller: 'web_development' do 
			get '/web-development' => :index
			get '/ruby-on-rails-development' =>  :ruby_on_rails, as: 'ruby_on_rails'
			get '/php-web-development' =>  :core_php, as: 'core_php'
			get '/magento-ecommerce' =>  :ecommerce_development, as: 'ecommerce_development'
			get '/open-source-cms' =>  :cms_development, as: 'cms_development'
		end
		# Online Marketing module
		scope controller: 'online_marketing' do 
			get '/online-marketing' => :index
			get '/seo-services-india' =>  :seo, as: 'search_engine_optimization'
			get '/social-media-marketing' =>  :smm
			get '/pay-per-click' =>  :ppc
			get '/email-marketing' =>  :email_marketing
			
		end
		# Mobile app dev module
		scope controller: 'mobile_app' do 
			get '/mobile-app-development' => :index
			get '/iphone' =>  :iphone
			get '/android' =>  :android
			get '/hybrid' =>  :hybrid
			get '/fire' =>  :fire
		end
		# UI Development module
		scope controller: 'ui_development' do 
			get '/ui-development' => :index
			get '/psd-to-html' =>  :psd_to_xhtml, as: 'psd_to_xhtml'
			get '/psd-to-html5' =>  :psd_to_html5
			get '/ajax' =>  :ajax
			get '/jquery' =>  :jquery
		end
		# Other Services module
		scope controller: 'other_services' do 
			get '/other-services' => :index
			get '/web-hosting' =>  :web_hosting
			get '/domain-registration' =>  :domain_registration
			get '/content-development' =>  :content_development
			get '/corporate-video-presentation' =>  :corporate_video_presentation
			get '/ebay-store-management' =>  :ebay_store_management
			get '/amazon-store-management' =>  :amazon_store_management
			get '/reputation-management' =>  :reputation_management
			get '/landing-page-optimization' =>  :landing_page_optimization
			get '/convertion-optimization' =>  :convertion_optimization
			get '/affiliate-marketing' =>  :affiliate_marketing
			get '/facebook-app-development' =>  :facebook_app_development
			get '/linkedin-marketing' =>  :linkedin_marketing
			get '/facebook-marketing' =>  :facebook_marketing
			get '/web-analytics' =>  :web_analytics
			get '/link-building' =>  :link_building
			get '/wordpress-implementation' =>  :wordpress_implementation
		end
	end

	scope  controller: 'blogs' do 
		get '/blog/categories/:category' => :category, as: 'blog_category'
		get '/blog' => :index, as: 'blog_list'
		get '/blog/search' => :search, as: 'blog_search'
		post '/blog/search' => :search
		get '/blog/:slug' => :show, as: 'blog_show'
	end


	# Example of regular route:
	#   get 'products/:id' => 'catalog#view'

	# Example of named route that can be invoked with purchase_url(id: product.id)
	#   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

	# Example resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products

	# Example resource route with options:
	#   resources :products do
	#     member do
	#       get 'short'
	#       post 'toggle'
	#     end
	#
	#     collection do
	#       get 'sold'
	#     end
	#   end

	# Example resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end

	# Example resource route with more complex sub-resources:
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', on: :collection
	#     end
	#   end

	# Example resource route with concerns:
	#   concern :toggleable do
	#     post 'toggle'
	#   end
	#   resources :posts, concerns: :toggleable
	#   resources :photos, concerns: :toggleable

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end
