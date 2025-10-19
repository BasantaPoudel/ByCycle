# by_cycle

A scientific cycle synching app to help female tackle the sleep issues.

## Installation


### Backend

- Java

  - Java 17 (From Vscode Command Palette on Windows)
  - Set Environment Variable and restart windows
- Android Studio
- VSCode
- Firebase
- - Create a firebase project and initialise android and ios projects
  - download google-services.json and place it to android\app
  - Turn on Authentication and Database in Firebase

    Use Firebase CLI

    - firebase logout/login

### FrontEnd

- Flutter
- Verify the installations with (flutter doctor)

## Running Instructions

- start a virtual device (android or ios)
- click Run with Debugging (from top right corner) when the main.dart is open

- 

## Bugs and errors

#### Bug-1

E/flutter ( 9083): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: [core/duplicate-app] A Firebase App named "[DEFAULT]" already exists
E/flutter ( 9083): #0      MethodChannelFirebase.initializeApp (package:firebase_core_platform_interface/src/method_channel/method_channel_firebase.dart:136:11)
method_channel_firebase.dart:136
E/flutter ( 9083): `<asynchronous suspension>`
E/flutter ( 9083): #1      Firebase.initializeApp (package:firebase_core/src/firebase.dart:43:31)
firebase.dart:43
E/flutter ( 9083): `<asynchronous suspension>`
E/flutter ( 9083): #2      main (package:by_cycle/main.dart:23:3)
main.dart:23
E/flutter ( 9083): `<asynchronous suspension>`
E/flutter ( 9083):

##### Resolution

Login to the correct account and project

#### Bug-2

After login you get toDate null error

##### Temporary Resolution

Use breakpoints in line 104 and 106 in user_repository.dart to analyse if the logged in user is being fetched correctly.
