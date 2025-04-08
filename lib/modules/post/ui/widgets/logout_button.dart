import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(Logout());
        },
        child: Row(
          spacing: 9,

          children: [
            Text('Sair', style: TextStyle(color: Colors.white, fontSize: 21)),

            const FaIcon(FontAwesomeIcons.rightToBracket),
          ],
        ),
      ),
    );
  }
}
