import 'package:calcimc/controllers/navigation_controller.dart';
import 'package:calcimc/models/user.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
import '../styles/styles.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final dbHelper = DatabaseHelper();

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final existe = await dbHelper.emailExists(_emailController.text.trim());
      if (existe) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail já cadastrado')),
        );
        return;
      }

      final novoUsuario = Usuario(
        nome: _nomeController.text.trim(),
        sobrenome: _sobrenomeController.text.trim(),
        email: _emailController.text.trim(),
        senha: _senhaController.text.trim(),
      );

      await dbHelper.insertUser(novoUsuario);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário cadastrado com sucesso')),
      );

      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.darkGreen),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: const Text("Cadastro", style: AppTextStyles.tituloText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkGreen),
          onPressed: () {
            NavigationController.goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                style: AppTextStyles.imputText,
                decoration: _inputDecoration("Nome"),
                validator: (value) => value!.isEmpty ? "Digite o nome" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sobrenomeController,
                style: AppTextStyles.imputText,
                decoration: _inputDecoration("Sobrenome"),
                validator: (value) => value!.isEmpty ? "Digite o sobrenome" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                style: AppTextStyles.imputText,
                decoration: _inputDecoration("E-mail"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Digite o e-mail";
                  final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!regex.hasMatch(value)) return "E-mail inválido";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                style: AppTextStyles.imputText,
                obscureText: true,
                decoration: _inputDecoration("Senha"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Digite a senha";
                  if (value.length < 8) return "Mínimo 8 caracteres";
                  if (!RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'\d').hasMatch(value)) {
                    return "Use letras e números";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _cadastrar,
                style: AppButtonStyles.roundedButton(AppColors.darkGreen),
                child: const Text("Cadastrar", style: AppTextStyles.buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
