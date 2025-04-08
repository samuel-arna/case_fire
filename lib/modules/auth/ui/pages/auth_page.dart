import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/auth/ui/functions/auth_validators.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_event.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_state.dart';
import 'package:case_fire/modules/auth/ui/widgets/input_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro de autenticação: ${state.errorMessage}'),
            ),
          );
        }
      },
      child: Scaffold(
        body: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Case Fire',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.textHighlightColor,
              ),
            ),
            InputAuth(
              icon: FontAwesomeIcons.solidUser,
              hint: 'Digite seu usuário',
              controller: user,
            ),
            InputAuth(
              icon: FontAwesomeIcons.key,
              pass: true,
              hint: 'Digite sua senha',
              controller: pass,
            ),
            GestureDetector(
              onTap: () {
                bool emailValidator = AuthValidators().emailValidator(
                  user.text,
                );
                bool passValidator = AuthValidators().passValidator(pass.text);
                if (emailValidator && passValidator) {
                  BlocProvider.of<AuthBloc>(
                    context,
                  ).add(Login(email: user.text, password: pass.text));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha o usuário e senha.'),
                    ),
                  );
                }
              },
              child: Container(
                height: 45,
                width: 210,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
