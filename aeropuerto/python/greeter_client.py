
import grpc
import time

import torre_control_pb2        # {nombre_del_proto}_pb2
import torre_control_pb2_grpc   # {nombre_del_proto}_pb2_grpc


def run():
    vuelo = {}
    print "Bienvenido al Vuelo"
    vuelo = raw_input("[Avion] Nombre de la Aerolinea y Numero de avion:\n")
    numeroVuelo = vuelo.split(" ")[1]
    print "[Avion - " + numeroVuelo + "] Peso maximo de carga [Kg]:"
    maxCarga = int(raw_input())
    print "[Avion - " + numeroVuelo + "] Capacidad maxima de combustible [L]:"
    maxCombustible = int(raw_input())
    print "[Avion - " + numeroVuelo + "] Torre de Control inicial:"
    ipTorreControl = raw_input()
    puerto = 50051
    canal = ipTorreControl + ':' + str(puerto)
    with grpc.insecure_channel(canal) as channel:
        stub = torre_control_pb2_grpc.ControlStub(channel)                              #sale desde el import linea 21
        response = stub.NuevoAvion(torre_control_pb2.AterrizajeRequest(avion=vuelo))    #import linea 20
    print "Aterrizando en la pista " + response.pista "..."
    time.sleep(2)
    print "Aterrizaje exitoso ..."
    time.sleep(2)
    while (True)
        if v = raw_input(int("Realizar vuelo? (y/n): ")) == "y":
            despegue = False
            destino = raw_input("Ingrese Destino:")
            with grpc.insecure_channel(canal) as channel:
                stub = torre_control_pb2_grpc.ControlStub(channel)                              #sale desde el import linea 21
                response = stub.ConusltarDestino(torre_control_pb2.AterrizajeRequest(destino=destino))    #import linea 20
            if response.ip =! "":
                print "Pasando por el Gate..."
                time.sleep(2)
                print "Todos los pasajeros a bordo y combustible cargado"
                print "Pidiendo instrucciones para despegar"
                while(!despegue)
                with grpc.insecure_channel(canal) as channel:
                    stub = torre_control_pb2_grpc.ControlStub(channel)                              #sale desde el import linea 21
                    response = stub.InstruccionesDespegue(torre_control_pb2.AterrizajeRequest(avion=destino))    #import linea 20
                if response.predecesor == "":
                    print "Pista " + response.pista + "asignada y altura de " + response.altura "km."
                    time.sleep(1)
                    print "Despegando..."
                    time.sleep(1)
                    print "Despegue exitoso!"
                    despegue = True
                    with grpc.insecure_channel(canal) as channel:
                        stub = torre_control_pb2_grpc.ControlStub(channel)                              #sale desde el import linea 21
                        response = stub.DespegueExitoso(torre_control_pb2.ExitoRequest(exito=1))    #import linea 20
                else:
                    print "Todas las pistas ocupadas, el avion predecesor es " + response.predecesor.split(" ")[0]



        else if v == "n"
            break


if __name__ == '__main__':
    run()
