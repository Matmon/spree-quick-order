# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_quick_order'
  s.version     = '0.1.0'
  s.summary     = 'Adds a new controller form to add a list of skus and quantity to add to products to cart'
  s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Jason Miller'
  s.email             = 'jason@matmon.com'
  s.homepage          = 'http://github.com/Matmon/spree-quick-order'
  # s.rubyforge_project = 'actionmailer'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 0.70.3'
  s.add_development_dependency 'rspec-rails'
end

