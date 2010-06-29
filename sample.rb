#!/usr/bin/env ruby -wKU

require 'report'

user_hashes = [
  {:email => 'brian@example.com', :login => 'brian', :occupation => 'Coder', :secret_hash => '8cdb8869386295de1404cbd550999182f985f8a2'},
  {:email => 'steve@example.com', :login => 'steve', :occupation => 'Designer', :secret_hash => '30471e09c19de7103968699736846c5896eeb102'},
  {:email => 'melinda@example.com', :login => 'melinda', :occupation => 'Product Guru', :secret_hash => 'e99ecbbec4c871f3fb63c3cc85796e177d017614'},
]

puts ""
puts "Raw output:"
puts ""
puts Report.new(user_hashes)
puts ""
puts "Formatted output:"
puts ""
puts Report.new(user_hashes, :fields => [:login, :email, :occupation])
puts ""
