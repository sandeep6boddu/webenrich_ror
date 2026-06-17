service apache2 stop
RAILS_ENV=production bundle exec rake assets:precompile
service apache2 start
