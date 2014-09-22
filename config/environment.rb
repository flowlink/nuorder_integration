require 'rubygems'
require 'bundler'
require_relative 'app'
Bundler.require(:default, App.env)

require App.root.join('config/environments', App.env)
$: << App.root.join('lib')
