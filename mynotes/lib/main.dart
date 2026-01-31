import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Firebase ilovasini ishga tushirish uchun kerak

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.lightBlue),
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Tepadagi barni o'z ichiga oladi (va oq fonni xam)
      appBar: AppBar(title: const Text('Home'), 
      ),
      
      body: FutureBuilder( // Firebase ilovasini ishga tushirishni kutadi
        future: Firebase.initializeApp( // Firebase ilovasini ishga tushiradi
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot){

          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user == null){
              return const Text('User is not logged in');
            }
            if(user.emailVerified == false){
              return const Text('Email not verified');
            }
              return Text('Done');
            default : 
              return const Text("Loading...");
          }
        },
      ),
    );
  }
}