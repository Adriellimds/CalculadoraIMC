import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/tela_cadastro.dart';
import 'views/tela_calculadora.dart';

void main() {
  runApp(const CalcImcApp());
}

class CalcImcApp extends StatelessWidget {
  const CalcImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
      '/': (context) => const HomeScreen(),
      '/calculadora': (context) => CalculadoraIMC(nomeUsuario: 'Usuário'),
      '/cadastro': (context) => const TelaCadastro(),
          },
    );
  }
}
