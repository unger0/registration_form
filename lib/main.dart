
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

// Widget principal da aplicação.
class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CadastroPage(),
    );
  }
}

// Tela principal do cadastro.
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Chave responsável por identificar e validar o formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  // Libera os controladores quando a tela é descartada.
  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  // NOVO: valida o formulário ao pressionar CADASTRAR.
  void _cadastrar() {
    // Fecha o teclado virtual.
    FocusScope.of(context).unfocus();

    // Executa todos os validadores dos campos.
    final formularioValido = _formKey.currentState!.validate();

    // Remove mensagens anteriores.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (formularioValido) {
      // Todos os campos foram validados.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      // Um ou mais campos estão inválidos.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Verifique os campos destacados em vermelho.',
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),

              const Icon(
                Icons.person_add_alt_1,
                size: 72,
                color: Colors.indigo,
              ),

              const SizedBox(height: 24),

              const Text(
                'Crie sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Preencha seus dados para começar.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 32),

              // CAMPO 1 - NOME COMPLETO
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  hintText: 'Digite seu nome',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),

                // NOVO: valida o nome.
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'O nome completo é obrigatório';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CAMPO 2 - E-MAIL
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'exemplo@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),

                // NOVO: valida o e-mail.
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'O e-mail é obrigatório';
                  }

                  if (!valor.trim().contains('@')) {
                    return 'O e-mail deve conter @';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CAMPO 3 - CPF
              TextFormField(
                controller: _cpfController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'Digite somente números',
                  prefixIcon: Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(),
                ),

                // NOVO: verifica se o CPF foi informado.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'O CPF é obrigatório';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CAMPO 4 - TELEFONE
              TextFormField(
                controller: _telefoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  hintText: 'Digite seu telefone',
                  prefixIcon: Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(),
                ),

                // NOVO: verifica se o telefone foi informado.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'O telefone é obrigatório';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // CAMPO 5 - SENHA
              TextFormField(
                controller: _senhaController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),

                // NOVO: valida o tamanho da senha.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'A senha é obrigatória';
                  }

                  if (valor.length < 6) {
                    return 'A senha deve ter no mínimo 6 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // BOTÃO CADASTRAR
              ElevatedButton(
                // NOVO: executa a validação do formulário.
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                ),
                child: const Text('CADASTRAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
