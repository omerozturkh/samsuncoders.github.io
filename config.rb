require 'digest/md5'

activate :directory_indexes

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

page '/topluluk'

helpers do
  def gravatar_for(email)
    hash = Digest::MD5.hexdigest(email.chomp.downcase)
    "//www.gravatar.com/avatar/#{hash}?s=200"
  end

  def icon_for(icon)
    "<i class=\"fa fa-#{icon}\"></i>"
  end
end

activate :relative_assets
set :relative_links, true

activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.remote   = 'origin'
  deploy.branch   = 'master'
  # deploy.strategy = :submodule
  deploy.build_before = true
end
