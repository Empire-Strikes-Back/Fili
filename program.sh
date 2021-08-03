#!/bin/bash

repl(){
  clj \
    -X:repl deps-repl.core/process \
    :main-ns dgraph-explorer.main \
    :port 7788 \
    :host '"0.0.0.0"' \
    :repl? true \
    :nrepl? false
}

main(){
  clojure \
    -J-Dclojure.core.async.pool-size=1 \
    -J-Dclojure.compiler.direct-linking=false \
    -M -m dgraph-explorer.main
}

uberjar(){
  clj \
    -X:uberjar genie.core/process \
    :uberjar-name out/dgraph-explorer.standalone.jar \
    :main-ns dgraph-explorer.main
  mkdir -p out/jpackage-input
  mv out/dgraph-explorer.standalone.jar out/jpackage-input/
}


"$@"