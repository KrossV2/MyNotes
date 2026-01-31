
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
 late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  } // bolishi kerak

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  } // bolishi kerak 


   @override
  Widget build(BuildContext context) {
    return Scaffold( // Tepadagi barni o'z ichiga oladi (va oq fonni xam)
      appBar: AppBar(title: const Text('Login'), 
      ),
      
      body: FutureBuilder( // Firebase ilovasini ishga tushirishni kutadi
        future: Firebase.initializeApp( // Firebase ilovasini ishga tushiradi
                  options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
          children: [
            TextField(
              controller: _email,
              autocorrect: false,  
              enableSuggestions: false,
              keyboardType: TextInputType.emailAddress, // email uchun klaviatura
              decoration: const InputDecoration(
                hintText: "Enter your email address" // foydalanuvchiga ko'rsatiladi
              ),
            ),
        
            TextField(
              controller:_password,
              obscureText: true, // parolni yashirish uchun
              enableSuggestions: false, // parolni taklif qilmaslik uchun
              autocorrect: false, // avtomatik to'g'rilashni o'chirish uchun
              decoration: const InputDecoration(
                hintText: "Enter your password" // foydalanuvchiga ko'rsatiladi
              ),
            ),
        
            TextButton(
              onPressed: () async {        
                final email = _email.text; // foydalanuvchi kiritgan emailni oladi
                final password = _password.text; // foydalanuvchi kiritgan parolni oladi
            try{
                final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword( // foydalanuvchi kirishini amalga oshiradi
                  email: email, 
                  password: password
                );
                print(userCredential);
            } on FirebaseAuthException catch(e){
              if(e.code == 'user-not-found'){
                print("No user found for that email.");
              }
            }
            // catch(x){
            //       print("Error: $x");
            //       print(x.runtimeType);
            //     }
              }, 
              child: const Text("Login"),
              ),
          ],
        );
        default : 
        return const Text("Loading...");
          }
        },
      ),
    );
  }
}

 