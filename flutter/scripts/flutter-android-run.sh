#!/bin/bash

deviceIsAlreadyConnected=$(flutter devices | grep "connected devices:" | wc -l)

# Si aucun device n'est branché alors lance l'emulateur
if [ $deviceIsAlreadyConnected -eq 0 ]
then
  echo 'Run with emulator'  

  # add user for use kvm (emulator)
  sudo groupadd -r kvm
  sudo gpasswd -a $USER kvm && grep -i --color 'kvm' /etc/group
  sudo chown $USER /dev/kvm && ls -l /dev/kvm

  # use directly "emulator" command instead of "flutter emulators --launch $FLUTTER_EMULATOR_NAME" to add camera options 
  # replace "&" with "> /dev/null 2>&1 &" to disable emulator outputs
  emulator -avd $FLUTTER_EMULATOR_NAME -camera-back emulated -camera-front emulated &

  # waiting for emulator "emulator-5554" connected
  started=0
  while [ $started -eq 0 ] 
  do 
    sleep 1
    # started=$(flutter devices | grep "emulator-5554" | wc -l)
    started=$(flutter devices | grep "connected devices:" | wc -l)
  done
else
  echo 'Run with usb'
fi  

flutter doctor -v

flutter pub get

flutter run -v --dart-define BASE_URL_API=$BASE_URL_API --observatory-port $FLUTTER_DEBUG_PORT --no-sound-null-safety
# flutter run -v -d emulator-5554 --dart-define BASE_URL_API=$BASE_URL_API --observatory-port $FLUTTER_DEBUG_PORT --no-sound-null-safety

/bin/bash /usr/local/bin/chown.sh

exit