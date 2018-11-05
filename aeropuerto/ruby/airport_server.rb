this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'torre_control_services_pb'

# AirportServer is simple server that implements the Helloworld Greeter server.
# Extiende de torre_control_services_pb.rb
class AirportServer < TorreDeControl::Control::Service
  # say_hello implements the SayHello rpc method.
  def say_hello(hello_req, _unused_call)
    TorreDeControl::HelloReply.new(message: "Hello #{hello_req.name}") #sale de torre_control_pb.rb
  end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AirportServer)
  s.run_till_terminated
end

main
