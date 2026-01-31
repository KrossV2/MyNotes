// Bu yerda barcha narsa register uchun boladi
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
      appBar: AppBar(title: const Text('Register'), 
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
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword( // yangi foydalanuvchi yaratadi
                    email: email, 
                    password: password
                  );

                  print(userCredential);
                } on FirebaseAuthException catch(e){
                  if(e.code == 'weak-password'){ // parolni zaifligini tekshiradi
                    print('weak password');
                  }
                  if(e.code == 'email-already-in-use'){ // email allaqachon foydalanilganligini tekshiradi
                    print('email already in use');
                  }
                  if(e.code == 'invalid-email'){ // email formatini tekshiradi
                    print('invalid email');
                  }
                }        
              }, 
              child: const Text("Register"),
              ), // TextButton
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
// Shu yergacha
