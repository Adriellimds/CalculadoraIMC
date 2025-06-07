import 'package:flutter/material.dart';
import '../controllers/navigation_controller.dart';
import '../styles/styles.dart';
import '../database/database.dart';
import 'tela_cadastro.dart';
import 'tela_calculadora.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final dbHelper = DatabaseHelper();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final usuario = await dbHelper.getUser(_emailController.text.trim());
      if (usuario != null && usuario.senha == _senhaController.text.trim()) {
        final nomeCompleto = "${usuario.nome} ${usuario.sobrenome}";
        NavigationController.replaceWith(
          context,
          CalculadoraIMC(nomeUsuario: nomeCompleto),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail ou senha inválidos')),
        );
      }
    }
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) return 'Informe o e-mail';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'E-mail inválido';
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Informe a senha';
    if (value.length < 8) return 'Mínimo de 8 caracteres';
    final senhaRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!senhaRegex.hasMatch(value)) return 'Use letras e números';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Image.asset('assets/imagens/logo.png', height: 180),
                const SizedBox(height: 20),
                Text('Calculadora IMC', style: AppTextStyles.tituloText, textAlign: TextAlign.center),
                const SizedBox(height: 60),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: _validarEmail,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: _validarSenha,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  style: AppButtonStyles.roundedButton(AppColors.darkGreen),
                  onPressed: _login,
                  child: const Text('Entrar', style: AppTextStyles.buttonText),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    NavigationController.goTo(context, const TelaCadastro());
                  },
                  child: const Text(
                    'Não tem conta? Cadastre-se aqui.',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
