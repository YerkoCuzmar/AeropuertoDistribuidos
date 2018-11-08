this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
$stdout.sync = true

$nombreTorre
$cantidadPistasAterrizaje = 0
$cantidadPistasDespegue = 0
$pistasAterrizaje
$pistasDespegue
$destinos = Hash.new
$colaAterrizaje = Array.new  #push, shift, index
$colaDespegue = Array.new

require 'grpc'
require 'torre_control_services_pb'
require 'thread'

# AirportServer is simple server that implements the Helloworld Greeter server.
# Extiende de torre_control_services_pb.rb
class AirportServer < TorreDeControl::Control::Service
  # say_hello implements the SayHello rpc method.
  def say_hello(hello_req, _unused_call)
    TorreDeControl::HelloReply.new(message: "Hello #{hello_req.name}") #sale de torre_control_pb.rb
  end

  def nuevo_avion(aterrizaje_req, _unused_call)
    puts "Avion #{aterrizaje_req.avion} llegando al aeropuerto"
    puts "Asignando pista de aterrizaje"
    msg = asignarPistaAterrizaje(aterrizaje_req.avion)
    TorreDeControl::AterrizajeReply.new(pista: msg)
  end

  def consultar_destino(destino_req, _unused_call)
    ip = ""
    ip = $destinos[destino_req.destino] if $destinos[destino_req.destino].present?
    TorreDeControl::DestinoReply.new(ip: ip)
  end

  def instrucciones_despegue(despegue_req, _unused_call)
    if $pistasDespegue.length < $cantidadPistasDespegue
      # km = alturaSegura(avion)
      km = 10
      $pistasDespegue.push(despegue_req.avion)
      TorreDeControl::DespegueReply.new(altura: km, pista: $pistasDespegue.index(avion))
    else
      TorreDeControl::DespegueReply.new(predecesor: $colaDespegue[$colaDespegue.length-1])
      $colaDespegue.push(despegue_req.avion) if !$colaDespegue.include(despegue_req.avion)?
    end
  end

  def despegue_exitoso(exito_req, _unused_call)

  end


end

def asignarPistaAterrizaje(avion)
  if $pistasAterrizaje.length < $cantidadPistasAterrizaje
    $pistasAterrizaje.push(avion)
    return $pistasAterrizaje.index(avion) + 1
  else
    $colaAterrizaje.push(avion)
    return -1
  end
end

def alturaSegura(avion)

end

def main
  puts "Bienvenido a la Torre de Control"
  puts "[Torre de Control] Ingrese nombre del Aeropuerto:"
  nombreTorre = gets.chomp
  puts "[Torre de Control - #{nombreTorre}] Cantidad de Pistas de Aterrizaje:"
  $cantidadPistasAterrizaje = gets.chomp.to_i
  $pistasAterrizaje = Array.new($cantidadPistasAterrizaje, "vacia")
  puts "[Torre de Control - #{nombreTorre}] Cantidad de Pistas de Aterrizaje:"
  $cantidadPistasDespegue = gets.chomp.to_i
  $pistasDespegue = Array.new($cantidadPistasDespegue, "vacia")
  tDestinos = Thread.new{
    while true
      puts "[Torre de Control - #{nombreTorre}] Para agregar destino presione ENTER"
      input = gets
      if input[0].ord == 10
        puts "[Torre de Control - #{nombreTorre}] Ingrese nombre del destino:"
        destino = gets.chomp
        puts "[Torre de Control - #{nombreTorre}] Ingrese direccion IP del destino:"
        ipDestino = gets.chomp
        $destinos[destino] = ipDestino
      end
    end
  }
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(AirportServer)
  s.run
end

main
