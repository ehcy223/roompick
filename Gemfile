source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'rails', '~> 6.1.7', '>= 6.1.7.10'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false

#日本語化
gem 'rails-i18n'

#デザイン
#gem 'sass-rails', '>= 6'
gem 'bootstrap', '~> 5.3.0'
gem 'sassc-rails'

#ページネーション
gem 'kaminari'
#認証・権限
gem 'devise'
gem 'pundit'

#画像アップロード・加工
gem 'image_processing', '~> 1.2'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails' #モデル・コントローラ・ビューなどの単体テスト
  gem 'factory_bot_rails' # テストデータ作成
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'shoulda-matchers' #バリデーション・アソシエーションの簡易テスト
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
