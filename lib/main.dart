
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CadastroApp());
}

// Aplicativo principal.
class CadastroApp extends StatelessWidget {
  const CadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Usuário',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6355D9),
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F5FB),
      ),
      home: const CadastroPage(),
    );
  }
}

// Tela de cadastro.
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Cores principais da interface.
  static const Color _roxo = Color(0xFF6355D9);
  static const Color _azul = Color(0xFF397BD8);
  static const Color _texto = Color(0xFF25304A);
  static const Color _cinza = Color(0xFF69758D);

  // Chave do formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  // Estados de visibilidade das senhas.
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

  // Padroniza a aparência dos campos do formulário.
  InputDecoration _decoracaoCampo({
    required String rotulo,
    required String dica,
    required IconData icone,
    Widget? suffixIcon,
  }) {
    final bordaNormal = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFE2E7F1),
      ),
    );

    final bordaFocada = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: _roxo,
        width: 2,
      ),
    );

    final bordaErro = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFD94F65),
        width: 1.5,
      ),
    );

    return InputDecoration(
      labelText: rotulo,
      hintText: dica,
      labelStyle: const TextStyle(color: _cinza),
      hintStyle: const TextStyle(
        color: Color(0xFF9AA5B8),
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icone,
        color: _roxo,
        size: 22,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFF),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: bordaNormal,
      enabledBorder: bordaNormal,
      focusedBorder: bordaFocada,
      errorBorder: bordaErro,
      focusedErrorBorder: bordaErro,
      errorMaxLines: 2,
      errorStyle: const TextStyle(
        color: Color(0xFFD94F65),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Exibe uma mensagem flutuante.
  void _mostrarMensagem({
    required String mensagem,
    required bool sucesso,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: sucesso
            ? const Color(0xFF16845F)
            : const Color(0xFFC64259),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(
              sucesso
                  ? Icons.check_circle_outline
                  : Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                mensagem,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Valida todos os campos do cadastro.
  void _cadastrar() {
    FocusScope.of(context).unfocus();

    final formularioValido =
        _formKey.currentState!.validate();

    if (formularioValido) {
      _mostrarMensagem(
        mensagem: 'Cadastro validado com sucesso!',
        sucesso: true,
      );
    } else {
      _mostrarMensagem(
        mensagem: 'Confira os campos destacados.',
        sucesso: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final topoSeguro = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F5FB),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              // CABEÇALHO COM GRADIENTE
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  24,
                  topoSeguro + 24,
                  24,
                  76,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _roxo,
                      _azul,
                    ],
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 520,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0x30FFFFFF),
                                borderRadius:
                                    BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0x40FFFFFF),
                                ),
                              ),
                              child: const Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'NOVA CONTA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        const Text(
                          'Seu próximo passo\ncomeça aqui.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Text(
                          'Preencha seus dados e crie sua conta '
                          'de maneira simples e rápida.',
                          style: TextStyle(
                            color: Color(0xFFE6E7FF),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // CARTÃO DO FORMULÁRIO
              Transform.translate(
                offset: const Offset(0, -30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 520,
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(
                          22, 26, 22, 28,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(26),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x180D2250),
                              blurRadius: 30,
                              offset: Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [
                            // TÍTULO DO CARTÃO
                            const Text(
                              'Seus dados',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                                color: _texto,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              'Complete as informações abaixo.',
                              style: TextStyle(
                                fontSize: 14,
                                color: _cinza,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              '* Todos os campos são obrigatórios',
                              style: TextStyle(
                                color: _roxo,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            const SizedBox(height: 26),

                            // CAMPO 1 - NOME
                            TextFormField(
                              controller: _nomeController,
                              keyboardType: TextInputType.name,
                              textCapitalization:
                                  TextCapitalization.words,
                              textInputAction:
                                  TextInputAction.next,
                              decoration: _decoracaoCampo(
                                rotulo: 'Nome completo',
                                dica: 'Como devemos chamar você?',
                                icone: Icons.person_outline,
                              ),
                              validator: (valor) {
                                if (valor == null ||
                                    valor.trim().isEmpty) {
                                  return 'Informe seu nome completo';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // CAMPO 2 - E-MAIL
                            TextFormField(
                              controller: _emailController,
                              keyboardType:
                                  TextInputType.emailAddress,
                              textInputAction:
                                  TextInputAction.next,
                              autocorrect: false,
                              decoration: _decoracaoCampo(
                                rotulo: 'E-mail',
                                dica: 'exemplo@email.com',
                                icone: Icons.mail_outline,
                              ),
                              validator: (valor) {
                                final email =
                                    valor?.trim() ?? '';

                                if (email.isEmpty) {
                                  return 'Informe seu e-mail';
                                }

                                final regex = RegExp(
                                  r'^[^\s@]+@[^\s@.]+(?:\.[^\s@.]+)+$',
                                );

                                if (!regex.hasMatch(email)) {
                                  return 'Digite um e-mail válido';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // CAMPO 3 - CPF
                            TextFormField(
                              controller: _cpfController,
                              keyboardType:
                                  TextInputType.number,
                              textInputAction:
                                  TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly,
                              ],
                              decoration: _decoracaoCampo(
                                rotulo: 'CPF',
                                dica: 'Somente números',
                                icone: Icons.badge_outlined,
                              ),
                              validator: (valor) {
                                if (valor == null ||
                                    valor.isEmpty) {
                                  return 'Informe seu CPF';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // CAMPO 4 - TELEFONE
                            TextFormField(
                              controller: _telefoneController,
                              keyboardType:
                                  TextInputType.phone,
                              textInputAction:
                                  TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly,
                              ],
                              decoration: _decoracaoCampo(
                                rotulo: 'Telefone',
                                dica: 'DDD + número',
                                icone: Icons.phone_outlined,
                              ),
                              validator: (valor) {
                                if (valor == null ||
                                    valor.isEmpty) {
                                  return 'Informe seu telefone';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // CAMPO 5 - SENHA
                            TextFormField(
                              controller: _senhaController,
                              keyboardType:
                                  TextInputType.visiblePassword,
                              textInputAction:
                                  TextInputAction.next,
                              obscureText: !_mostrarSenha,
                              autocorrect: false,
                              enableSuggestions: false,
                              decoration: _decoracaoCampo(
                                rotulo: 'Senha',
                                dica: 'Mínimo de 6 caracteres',
                                icone: Icons.lock_outline,
                                suffixIcon: IconButton(
                                  tooltip: _mostrarSenha
                                      ? 'Ocultar senha'
                                      : 'Mostrar senha',
                                  icon: Icon(
                                    _mostrarSenha
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: _cinza,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _mostrarSenha =
                                          !_mostrarSenha;
                                    });
                                  },
                                ),
                              ),
                              validator: (valor) {
                                if (valor == null ||
                                    valor.isEmpty) {
                                  return 'Informe sua senha';
                                }

                                if (valor.length < 6) {
                                  return 'A senha deve ter no mínimo 6 caracteres';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // CAMPO 6 - CONFIRMAR SENHA
                            TextFormField(
                              controller:
                                  _confirmarSenhaController,
                              keyboardType:
                                  TextInputType.visiblePassword,
                              textInputAction:
                                  TextInputAction.done,
                              obscureText:
                                  !_mostrarConfirmacao,
                              autocorrect: false,
                              enableSuggestions: false,
                              decoration: _decoracaoCampo(
                                rotulo: 'Confirmar senha',
                                dica: 'Repita sua senha',
                                icone: Icons.verified_user_outlined,
                                suffixIcon: IconButton(
                                  tooltip: _mostrarConfirmacao
                                      ? 'Ocultar confirmação'
                                      : 'Mostrar confirmação',
                                  icon: Icon(
                                    _mostrarConfirmacao
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: _cinza,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _mostrarConfirmacao =
                                          !_mostrarConfirmacao;
                                    });
                                  },
                                ),
                              ),
                              validator: (valor) {
                                if (valor == null ||
                                    valor.isEmpty) {
                                  return 'Confirme sua senha';
                                }

                                if (valor !=
                                    _senhaController.text) {
                                  return 'As senhas não coincidem';
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 28),

                            // BOTÃO COM GRADIENTE
                            Container(
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [_roxo, _azul],
                                ),
                                borderRadius:
                                    BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x406355D9),
                                    blurRadius: 16,
                                    offset: Offset(0, 7),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _cadastrar,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.transparent,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CRIAR MINHA CONTA',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 21,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // AVISO INFORMATIVO
                            const Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 18,
                                  color: _cinza,
                                ),
                                SizedBox(width: 9),
                                Expanded(
                                  child: Text(
                                    'Demonstração: os dados não são '
                                    'enviados a um servidor.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _cinza,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
