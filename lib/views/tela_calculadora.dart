import 'package:calcimc/controllers/navigation_controller.dart';
import 'package:flutter/material.dart';
import '../styles/styles.dart';
import 'home_screen.dart';

class CalculadoraIMC extends StatefulWidget {
  final String nomeUsuario;
  const CalculadoraIMC({super.key, required this.nomeUsuario});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final FocusNode _pesoFocus = FocusNode();

  String _mensagem = "Informe seus dados!";
  String _imagemPath = '';
  Color _mensagemCor = AppColors.darkGreen;

  String _saudacao() {
    final hora = DateTime.now().hour;
    if (hora < 12) return "Bom dia";
    if (hora < 18) return "Boa tarde";
    return "Boa noite";
  }

  void _calcularIMC() {
    final double? peso = double.tryParse(_pesoController.text);
    final double? alturaCm = double.tryParse(_alturaController.text);

    if (peso == null || alturaCm == null) {
      setState(() {
        _mensagem = "Preencha os dados corretamente!";
        _mensagemCor = Colors.red;
        _imagemPath = '';
      });
      return;
    }

    final double altura = alturaCm / 100;
    final double imc = peso / (altura * altura);

    String classificacao;
    Color cor;

    if (imc < 16) {
      classificacao = "Magreza grave";
      cor = Colors.red;
      _imagemPath = 'assets/imagens/Vermelho.png';
    } else if (imc < 17) {
      classificacao = "Magreza moderada";
      cor = Colors.deepOrange;
      _imagemPath = 'assets/imagens/Laranja.png';
    } else if (imc < 18.6) {
      classificacao = "Magreza leve";
      cor = Colors.orange;
      _imagemPath = 'assets/imagens/Amarelo.png';
    } else if (imc < 25) {
      classificacao = "Peso ideal";
      cor = Colors.green;
      _imagemPath = 'assets/imagens/Verde.png';
    } else if (imc < 30) {
      classificacao = "Sobrepeso";
      cor = Colors.orange;
      _imagemPath = 'assets/imagens/Amarelo.png';
    } else if (imc < 35) {
      classificacao = "Obesidade grau I";
      cor = Colors.deepOrange;
      _imagemPath = 'assets/imagens/Laranja.png';
    } else if (imc < 40) {
      classificacao = "Obesidade grau II (severa)";
      cor = Colors.red;
      _imagemPath = 'assets/imagens/Vermelho.png';
    } else {
      classificacao = "Obesidade grau III (mórbida)";
      cor = Colors.red;
      _imagemPath = 'assets/imagens/Vermelho.png';
    }

    setState(() {
      _mensagem = "Seu IMC é ${imc.toStringAsFixed(2)}\n$classificacao";
      _mensagemCor = cor;
      _pesoController.clear();
      _alturaController.clear();
      FocusScope.of(context).requestFocus(_pesoFocus);
    });
  }

  void _limparCampos() {
    setState(() {
      _pesoController.clear();
      _alturaController.clear();
      _mensagem = "Informe seus dados!";
      _imagemPath = '';
      _mensagemCor = AppColors.darkGreen;
      FocusScope.of(context).requestFocus(_pesoFocus);
    });
  }

  void _logout() {
    NavigationController.replaceWith(context, const HomeScreen());
  }

  @override
  void dispose() {
    _pesoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Calculadora IMC', style: AppTextStyles.tituloText),
            Image.asset('assets/imagens/logo.png', height: 60),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.darkGreen),
            onPressed: _logout,
            tooltip: 'Sair',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${_saudacao()}, ${widget.nomeUsuario}!",
              style: AppTextStyles.tituloText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              focusNode: _pesoFocus,
              controller: _pesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.darkGreen),
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _alturaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.darkGreen),
                labelText: 'Altura (cm)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularIMC,
              style: AppButtonStyles.roundedButton(AppColors.darkGreen),
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _limparCampos,
              style: AppButtonStyles.roundedButton(Colors.grey),
              child: const Text('Limpar'),
            ),
            const SizedBox(height: 20),
            Text(
              _mensagem,
              style: AppTextStyles.infoText.copyWith(color: _mensagemCor),
              textAlign: TextAlign.center,
            ),
            if (_imagemPath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(_imagemPath, height: 150),
              ),
          ],
        ),
      ),
    );
  }
}
