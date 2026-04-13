#/bin/sh

vendor_root="$(pwd)/vendor"
mkdir -p $vendor_root

debugjs(){
  version="v1.112.0"
  curl -LSs https://github.com/microsoft/vscode-js-debug/releases/download/$version/js-debug-dap-$version.tar.gz | tar -xz -C $vendor_root
  echo "succes js_debug"
}

debugjs
