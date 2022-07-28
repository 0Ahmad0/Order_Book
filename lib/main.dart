import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  FirebaseAuth auth = FirebaseAuth.instance;
  String varfication = "";
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
           _verfiyNumber();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.sms),
      ),
    );
  }
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
}
