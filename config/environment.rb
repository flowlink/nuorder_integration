require 'rubygems'
require 'bundler'
require_relative 'app'
Bundler.require(:default, App.env)
require 'active_support'
require 'active_support/core_ext/hash'
require 'active_support/core_ext/object/try'

require App.root.join('config/environments', App.env)
$: << App.root.join('lib')
