#!/bin/bash

. ./config.sh

cd $MOBILE_LIB_ROOT
cmake . && make -j4

sed -i '' "s/<dict>/<dict>\n\t<key>MinimumOSVersion<\/key>\n\t<string>10.14<\/string>/g" ./mobileliblelantus.framework/Resources/Info.plist