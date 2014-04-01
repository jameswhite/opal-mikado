# config.ru
require 'bundler'
Bundler.require

run Opal::Server.new { |s|
  s.append_path 'opal'

  s.main = 'opal-mikado.rb'

  s.index_path = 'opal/index.html'
}
