
require 'webrick'
require 'webrick/https'
include WEBrick

root = File.expand_path './public'
# puts root
# https://localhost:4430
# C:\Users\jack2\RubymineProjects\Ruby-Cube\public\index.html

cert_name = [
    %w[CN localhost],
]

server = HTTPServer.new(
    :BindAddress => '127.0.0.1',
    :Port => '4430',
    :DocumentRoot => root,
    :SSLEnable => true,
    :SSLCertName => cert_name # LOOK! SSLCertName IS SET!
)

# Shutdown gracefully on signal interrupt CTRL-C
# http://www.ruby-doc.org/core-2.1.1/Kernel.html#method-i-trap
trap('INT') { server.shutdown }

server.start