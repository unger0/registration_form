
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

// Tela principal de cadastro.
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Chave utilizada para validar o formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  // NOVO: controlador da confirmação da senha.
  final _confirmarSenhaController = TextEditingController();

  // NOVO: estados que controlam a visibilidade das senhas.
  bool _mostrarSenha = false;
  bool _mostrarConfirmacao = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  // Valida todos os campos do formulário.
  void _cadastrar() {
    FocusScope.of(context).unfocus();

    final formularioValido = _formKey.currentState!.validate();

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    if (formularioValido) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      messenger.showSnackBar(
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

                // NOVO: validação com expressão regular.
                validator: (valor) {
                  final email = valor?.trim() ?? '';

                  if (email.isEmpty) {
                    return 'O e-mail é obrigatório';
                  }

                  final regexEmail = RegExp(
                    r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)+$',
                  );

                  if (!regexEmail.hasMatch(email)) {
                    return 'Informe um e-mail válido';
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
                textInputAction: TextInputAction.next,
                obscureText: !_mostrarSenha,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Mínimo de 6 caracteres',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),

                  // NOVO: botão de visibilidade da senha.
                  suffixIcon: IconButton(
                    tooltip: _mostrarSenha
                        ? 'Ocultar senha'
                        : 'Mostrar senha',
                    icon: Icon(
                      _mostrarSenha
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _mostrarSenha = !_mostrarSenha;
                      });
                    },
                  ),
                ),
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

              const SizedBox(height: 16),

              // CAMPO 6 - CONFIRMAR SENHA
              // NOVO: campo adicional do desafio extra.
              TextFormField(
                controller: _confirmarSenhaController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: !_mostrarConfirmacao,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Confirmar senha',
                  hintText: 'Digite sua senha novamente',
                  prefixIcon: const Icon(Icons.lock_reset),
                  border: const OutlineInputBorder(),

                  // NOVO: botão de visibilidade da confirmação.
                  suffixIcon: IconButton(
                    tooltip: _mostrarConfirmacao
                        ? 'Ocultar confirmação'
                        : 'Mostrar confirmação',
                    icon: Icon(
                      _mostrarConfirmacao
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _mostrarConfirmacao = !_mostrarConfirmacao;
                      });
                    },
                  ),
                ),

                // NOVO: compara a confirmação com a senha.
                validator: (valor) {
                  if (valor == null || valor.isEmpty) {
                    return 'Confirme sua senha';
                  }

                  if (valor != _senhaController.text) {
                    return 'As senhas não coincidem';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // BOTÃO CADASTRAR
              ElevatedButton(
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
