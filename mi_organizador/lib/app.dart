import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'presentation/screens/home_screen.dart';

class MiOrganizadorApp extends StatelessWidget {
  const MiOrganizadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Organizador',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
