import 'package:WeCare/authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:WeCare/authentication/view/widgets/login_class.dart';
import 'package:WeCare/authentication/view/widgets/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  runApp(const MyApp());
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('userDetailsBox');
  await Hive.openBox('mailBox');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SpalshScreen(),
    );
  }
}
