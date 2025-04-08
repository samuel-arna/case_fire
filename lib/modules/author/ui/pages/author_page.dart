import 'package:case_fire/modules/author/ui/stores/bloc/author_event.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_bloc.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:get_it/get_it.dart';

class AuthorPage extends StatelessWidget {
  final int userId;

  const AuthorPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              GetIt.I<AuthorBloc>()
                ..add(GetAuthorEvent(userId: userId.toString())),
      child: Scaffold(
        appBar: AppBar(title: const Text('Informações do Autor')),
        body: BlocBuilder<AuthorBloc, AuthorState>(
          builder: (context, state) {
            if (state is AuthorLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AuthorLoaded) {
              return _buildAuthorInfo(state.author);
            } else if (state is AuthorError) {
              return Center(
                child: Text('Erro ao carregar autor: ${state.failure}'),
              );
            } else if (state is AuthorInitial) {
              return const Center(child: Text('Tela inicial do autor.'));
            }
            return const Center(child: Text('Estado desconhecido'));
          },
        ),
      ),
    );
  }

  Widget _buildAuthorInfo(AuthorEntity? author) {
    if (author == null) {
      return const Center(child: Text('Autor não encontrado.'));
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            author.userName ?? 'Nome não disponível',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (author.userPhotoUrl != null)
            Image.network(
              author.userPhotoUrl!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 100);
              },
            )
          else
            const Icon(Icons.person, size: 100),
          const SizedBox(height: 16),
          Text('Idade: ${author.userAge ?? 'Não informada'} anos'),
          const SizedBox(height: 8),
          if (author.userGostos != null && author.userGostos!.isNotEmpty)
            Text('Gostos: ${author.userGostos!.join(', ')}'),
          if (author.userGostos == null || author.userGostos!.isEmpty)
            const Text('Gostos: Não informados'),
          const SizedBox(height: 8),
          Text('Número de Posts: ${author.numPost ?? 'Não informado'}'),
        ],
      ),
    );
  }
}
