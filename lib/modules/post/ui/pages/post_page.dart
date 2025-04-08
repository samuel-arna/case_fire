import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_state.dart';
import 'package:case_fire/modules/post/ui/widgets/list_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context).add(GetPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(Logout());
              },
              child: FaIcon(FontAwesomeIcons.rightToBracket),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.textColor),
            );
          } else if (state is PostLoaded) {
            return ListPosts(posts: state.posts);
          } else if (state is PostError) {
            return Center(child: Text('Erro: ${state.error}'));
          } else {
            return const Center(child: Text('Estado inicial'));
          }
        },
      ),
    );
  }
}
