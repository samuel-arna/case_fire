import 'package:case_fire/core/utils/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:case_fire/firebase_options.dart';
import 'package:case_fire/modules/post/data/datasources/post_placeholder_datasource.dart';
import 'package:case_fire/modules/post/domain/repositories/post_repository.dart';
import 'package:case_fire/modules/post/ui/pages/post_page.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

PostRepository _buildPostRepository() {
  final datasource = PostPlaceholderDatasource();
  return PostRepositoryImpl(datasource);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _postRepository = _buildPostRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostBloc>(create: (context) => PostBloc(_postRepository)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.cardBackground,
            surfaceTintColor: AppColors.background,
            iconTheme: IconThemeData(color: AppColors.textColor),
            titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 21),
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Case Fire',
        home: const PostPage(),
      ),
    );
  }
}
