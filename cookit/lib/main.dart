import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:cookit/screens/login.dart';
import 'package:cookit/screens/register.dart';
import 'package:cookit/screens/recipe_form.dart';
import 'package:cookit/screens/recipe_detail.dart';
import 'package:cookit/screens/recipe_list.dart';

 // For kIsWeb


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC296IONcO2sc54MxMvL50FSxu4zUtwPDk",
        authDomain: "hama-app-8c1f5.firebaseapp.com",
        projectId: "hama-app-8c1f5",
        storageBucket: "hama-app-8c1f5.firebasestorage.app",
        messagingSenderId: "336824896024",
        appId: "1:336824896024:web:f964a4facccfae44b6116d",
        measurementId: "G-DN1212NPGW"
      )    
    );    
  }else{
    await Firebase.initializeApp();
  }
    
  runApp(CookIt());
}

class CookIt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookIt',
      theme: ThemeData(
        primaryColor: Colors.yellow,
        colorScheme: ColorScheme.light(),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/recipeDetail': (context) => RecipeDetail(recipeId: ''), 
        '/recipe_form': (context) => RecipeForm(),
        '/recipe_list': (context) => RecipeList(),
      },
    );
  }
}