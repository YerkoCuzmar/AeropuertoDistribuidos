# Copyright 2015 gRPC authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""The Python implementation of the GRPC helloworld.Greeter client."""

from __future__ import print_function

import grpc

import torre_control_pb2        # {nombre_del_proto}_pb2
import torre_control_pb2_grpc   # {nombre_del_proto}_pb2_grpc


def run():
    # NOTE(gRPC Python Team): .close() is possible on a channel and should be
    # used in circumstances in which the with statement does not fit the needs
    # of the code.
    print "Bienvenido al Vuelo"
    aerolinea = raw_input("[Avion] Nombre de la Aerolinea:\n")
    numeroAvion = raw_input("[Avion] Numero de Avion:\n")
    maxCarga = int(raw_input("[Avion - ", numeroAvion, "] Peso maximo de carga [Kg]:\n"))
    maxCombustible = int(raw_input("[Avion - ", numeroAvion, "] Capacidad maxima de combustible [L]:\n"))
    ipTorreControl = raw_input("[Avion - ", numeroAvion, "] Torre de Control inicial:\n")
    puerto = 50051
    canal = ipTorreControl + ':' + puerto
    with grpc.insecure_channel(canal) as channel:
        stub = torre_control_pb2_grpc.ControlStub(channel)                      #sale desde el import linea 21
        response = stub.SayHello(torre_control_pb2.HelloRequest(name='you'))    #import linea 20
    print("Greeter client received: " + response.message)


if __name__ == '__main__':
    run()
