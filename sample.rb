#!/usr/bin/env ruby -wKU

require 'report'

user_hashes = [
  {:login => 'brian', :email => 'brian@example.com', :occupation => 'Coder'},
  {:login => 'steve', :email => 'steve@example.com', :occupation => 'Designer'},
  {:login => 'melinda', :email => 'melinda@example.com', :occupation => 'Product Guru'},
]
puts Report.new(user_hashes)