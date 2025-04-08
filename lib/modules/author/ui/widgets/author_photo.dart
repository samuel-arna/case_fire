import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:case_fire/modules/author/ui/pages/author_page.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_bloc.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_event.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthorPhoto extends StatelessWidget {
  final int userId;

  const AuthorPhoto({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetIt.I<AuthorBloc>()
                ..add(GetAuthorEvent(userId: userId.toString())),
      child: BlocBuilder<AuthorBloc, AuthorState>(
        builder: (context, state) {
          if (state is AuthorLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is AuthorLoaded) {
            return _buildAuthorPhoto(state.author, context);
          } else if (state is AuthorError) {
            return Center(
              child: Text('Erro ao carregar autor: ${state.failure}'),
            );
          } else if (state is AuthorInitial) {
            return const SizedBox();
          }
          return const Center(child: Text('Estado desconhecido'));
        },
      ),
    );
  }
}

Widget _buildAuthorPhoto(AuthorEntity? author, BuildContext context) {
  if (author == null) {
    return const Center(child: Text('Autor não encontrado.'));
  }
  return GestureDetector(
    onTap: () {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => AuthorPage(author: author)));
    },
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child:
          author.userPhotoUrl != null
              ? ClipOval(
                child: Image.network(
                  author.userPhotoUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100);
                  },
                ),
              )
              : const Icon(Icons.person, size: 100),
    ),
  );
}
