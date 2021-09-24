Pod::Spec.new do |s|
  s.name     = 'gRPC-OC'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.authors  = { 'jh' => 'hao.xiang@easi.com.au' }
  s.homepage = 'https://grpc.io'
  s.summary = 'Apache License, Version 2.0'
  s.source = { :git => 'https://github.com/grpc/grpc.git' }
  s.ios.deployment_target = '11.0'
  src = 'Protos'

  s.dependency '!ProtoCompiler-gRPCPlugin'
  pods_root = 'Pods'
  protoc_dir = "#{pods_root}/!ProtoCompiler"
  protoc = "#{protoc_dir}/protoc"
  plugin = "#{pods_root}/!ProtoCompiler-gRPCPlugin/grpc_objective_c_plugin"
  dir = "#{pods_root}/#{s.name}"

  s.prepare_command = <<-CMD
    mkdir -p #{dir}
    #{protoc} \
        --plugin=protoc-gen-grpc=#{plugin} \
        --objc_out=#{dir} \
        --grpc_out=#{dir} \
        -I #{src} \
        -I #{protoc_dir} \
        #{src}/*.proto
  CMD

  s.subspec 'Messages' do |ms|
    ms.source_files = "#{dir}/*.pbobjc.{h,m}"
    ms.header_mappings_dir = dir
    ms.requires_arc = false
    ms.dependency 'Protobuf'
  end

  s.subspec 'Services' do |ss|
    ss.source_files = "#{dir}/*.pbrpc.{h,m}"
    ss.header_mappings_dir = dir
    ss.requires_arc = true
    ss.dependency 'gRPC-ProtoRPC'
    ss.dependency "#{s.name}/Messages"
  end

  s.pod_target_xcconfig = {
    # This is needed by all pods that depend on Protobuf:
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1',
    # This is needed by all pods that depend on gRPC-RxLibrary:
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
  }
end