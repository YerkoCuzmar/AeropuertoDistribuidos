this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
$stdout.sync = true

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
  puts "Bienvenido a la Torre de Control"
  puts "[Torre de Control] Ingrese nombre del Aeropuerto:"
  nombreTorre = gets.chomp
  puts "[Torre de Control - #{nombreTorre}] Cantidad de Pistas de Aterrizaje:"
  cantidadPistasAterrizaje = gets.chomp
  puts "[Torre de Control - #{nombreTorre}] Cantidad de Pistas de Aterrizaje:"
  cantidadPistasDespegue = gets.chomp
  s.run_till_terminated
  destinos = Hash.new
  puts "[Torre de Control - #{nombreTorre}] Para agregar destino presione ENTER"
  puts "[Torre de Control - #{nombreTorre}] Ingrese nombre del destino:"
  destino = gets.chomp
  puts "[Torre de Control - #{nombreTorre}] Ingrese direccion IP del destino:"
  ipDestino = gets.chomp
  destinos[destino] = ipDestino
end

main
