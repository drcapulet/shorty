require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'fakeweb'
FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'shorty'