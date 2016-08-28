require 'webrick'

WEBrick::HTTPServer.new(:DocumentRoot=>'lesson4', :Port=>8080).start
