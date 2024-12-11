import 'package:flutter/material.dart';

import 'package:mceleb/presentation/screens/home/home_screen.dart';
import 'package:mceleb/presentation/screens/splash/spalsh_screen.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
