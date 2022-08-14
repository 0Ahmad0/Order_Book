import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'dart:async';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   await GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp( MyApp());
}








/*
  _verfiyNumber(){

    auth.verifyPhoneNumber(
      phoneNumber: "+963993811331",
        verificationCompleted: (PhoneAuthCredential credential)async{
        await auth.signInWithCredential(credential).then((value) => print("Sucess"));
        },
        verificationFailed:(FirebaseAuthException exception){
        print(exception.message);
        },
        codeSent: (String verficationId, int? reSend){
          varfication = verficationId;

        },
        codeAutoRetrievalTimeout: (String verficationId){

        }
    );
  }

 */