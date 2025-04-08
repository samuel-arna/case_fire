import 'package:case_fire/core/utils/app_theme.dart';
import 'package:case_fire/dependency_injection.dart';
import 'package:case_fire/modules/auth/ui/pages/auth_page.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_bloc.dart';
import 'package:case_fire/modules/post/ui/pages/post_page.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        BlocProvider<AuthorBloc>(create: (context) => di<AuthorBloc>()),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        title: 'Case Fire',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold();
            }
            if (snapshot.hasData) {
              return const PostPage();
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
