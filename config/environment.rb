require_relative 'app'
require App.root.join('config/environments', App.env)
$LOAD_PATH << App.root.join('lib')
