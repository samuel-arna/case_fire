import 'package:case_fire/core/utils/app_theme.dart';
import 'package:case_fire/dependency_injection.dart';
import 'package:case_fire/modules/auth/ui/pages/auth_page.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context) => di<PostBloc>()),
        BlocProvider<AuthBloc>(create: (context) => di<AuthBloc>()),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        title: 'Case Fire',
        home: AuthPage(),
      ),
    );
  }
}
