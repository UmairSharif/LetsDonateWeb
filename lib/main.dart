import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_donate_web/pages/account_deletion_form.dart';
import 'package:lets_donate_web/constants/app_colors.dart';
import 'package:lets_donate_web/firebase_options.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Error initlising firebase $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetsDonate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary.value)
              .copyWith(primary: AppColors.primary.value),
          fontFamily: 'Poppins',
          useMaterial3: true),
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary.value)
              .copyWith(primary: AppColors.primary.value)),
      themeMode: ThemeMode.system,
      home: const AccountDeletionForm(),
    );
  }
}
