#!/bin/bash

repl(){
  clj \
    -J-Dclojure.core.async.pool-size=8 \
    -X:Ripley Ripley.core/process \
    :main-ns Fili.main
}


main(){
  clojure \
    -J-Dclojure.core.async.pool-size=8 \
    -M -m Fili.main
}

tag(){
  COMMIT_HASH=$(git rev-parse --short HEAD)
  COMMIT_COUNT=$(git rev-list --count HEAD)
  TAG="$COMMIT_COUNT-$COMMIT_HASH"
  git tag $TAG $COMMIT_HASH
  echo $COMMIT_HASH
  echo $TAG
}

jar(){

  rm -rf out/*.jar out/classes
  COMMIT_HASH=$(git rev-parse --short HEAD)
  COMMIT_COUNT=$(git rev-list --count HEAD)
  clojure \
    -X:Genie Genie.core/process \
    :main-ns Fili.main \
    :filename "\"out/Fili-$COMMIT_COUNT-$COMMIT_HASH.jar\"" \
    :paths '["src"]'
}

release(){
  jar
}

"$@"