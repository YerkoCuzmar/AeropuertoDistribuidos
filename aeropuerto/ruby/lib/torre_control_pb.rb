# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: torre_control.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "torreDeControl.AterrizajeRequest" do
    optional :avion, :string, 1
  end
  add_message "torreDeControl.AterrizajeReply" do
    optional :pista, :int32, 1
  end
  add_message "torreDeControl.HelloRequest" do
    optional :name, :string, 1
  end
  add_message "torreDeControl.HelloReply" do
    optional :message, :string, 1
  end
end

module TorreDeControl
  AterrizajeRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("torreDeControl.AterrizajeRequest").msgclass
  AterrizajeReply = Google::Protobuf::DescriptorPool.generated_pool.lookup("torreDeControl.AterrizajeReply").msgclass
  HelloRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("torreDeControl.HelloRequest").msgclass
  HelloReply = Google::Protobuf::DescriptorPool.generated_pool.lookup("torreDeControl.HelloReply").msgclass
end
