import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:servidor_webrtc/Networks/WebRTCExample.dart'; // Importa el archivo de tu clase WebRTCExample

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase si es necesario
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebRTC Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebRTCExample(), // Aquí pones la clase WebRTCExample como home
    );
  }
}
