import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(state.posts[index].title));
              },
            );
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
