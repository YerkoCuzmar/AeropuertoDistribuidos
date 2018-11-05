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
"""The Python implementation of the GRPC helloworld.Greeter server."""

from concurrent import futures
import time

import grpc

import torre_control_pb2        # {nombre_del_proto}_pb2
import torre_control_pb2_grpc   # {nombre_del_proto}_pb2_grpc

_ONE_DAY_IN_SECONDS = 60 * 60 * 24


class Greeter(torre_control_pb2_grpc.ControlServicer):  #argumento desde {nombre_del_proto}_pb2_grpc ({nombre_del_Service_del_proto}Servicer)

    def SayHello(self, request, context):
        return torre_control_pb2.HelloReply(message='Hello, %s!' % request.name)


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))           #supongo que esto es para conexiones simultaneas, asi que tal vez haya que dejarlo en 1
    torre_control_pb2_grpc.add_ControlServicer_to_server(Greeter(), server)    # idem linea 27
    server.add_insecure_port('[::]:50051')
    server.start()
    try:
        while True:
            time.sleep(_ONE_DAY_IN_SECONDS)
    except KeyboardInterrupt:
        server.stop(0)


if __name__ == '__main__':
    serve()
