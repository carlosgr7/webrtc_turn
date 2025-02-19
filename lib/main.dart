import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Apps/MyApp.dart'; // Cambia el path según la estructura de tu proyecto

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase usando las opciones obtenidas de tu archivo JavaScript
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDDet4RQYvv8520zth2hxlzsGXaaEjHCGU",
      appId: "1:426072357487:web:9d211aaf06b6a02137eb9a",
      messagingSenderId: "426072357487",
      projectId: "webrtc-1b940",
      authDomain: "webrtc-1b940.firebaseapp.com",
      storageBucket: "webrtc-1b940.firebasestorage.app",
    ),
  );

  runApp(MyApp());
}
