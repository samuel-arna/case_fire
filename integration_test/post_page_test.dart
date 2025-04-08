import 'package:bloc_test/bloc_test.dart';
import 'package:case_fire/dependency_injection.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_bloc.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_event.dart';
import 'package:case_fire/modules/auth/ui/stores/bloc/auth_state.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_bloc.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_event.dart';
import 'package:case_fire/modules/author/ui/stores/bloc/author_state.dart';
import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/ui/pages/post_page.dart';
import 'package:case_fire/modules/post/ui/widgets/list_posts.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_bloc.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_event.dart';
import 'package:case_fire/modules/post/ui/stores/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_it/get_it.dart';

final di = GetIt.instance;

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthorBloc extends MockBloc<AuthorEvent, AuthorState>
    implements AuthorBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await configureDependencies();
  });

  group('Testes de Integração da PostPage', () {
    late MockPostBloc mockPostBloc;
    late MockAuthBloc mockAuthBloc;
    late MockAuthorBloc mockAuthorBloc;

    setUp(() {
      mockPostBloc = MockPostBloc();
      mockAuthBloc = MockAuthBloc();
      mockAuthorBloc = MockAuthorBloc();
    });

    testWidgets(
      'PostPage deve exibir indicador de carregamento quando o estado for PostLoading',
      (WidgetTester tester) async {
        when(() => mockPostBloc.state).thenReturn(PostLoading());

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<PostBloc>(create: (context) => mockPostBloc),
              BlocProvider<AuthBloc>(create: (context) => mockAuthBloc),
            ],
            child: const MaterialApp(home: PostPage()),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      'PostPage deve exibir a lista de posts quando o estado for PostLoaded',
      (WidgetTester tester) async {
        final testPosts = [
          PostEntity(id: 1, title: 'Post 1', body: 'Corpo 1', userId: 1),
          PostEntity(id: 2, title: 'Post 2', body: 'Corpo 2', userId: 2),
          PostEntity(id: 3, title: 'Post 3', body: 'Corpo 3', userId: 3),
          PostEntity(id: 4, title: 'Post 4', body: 'Corpo 4', userId: 4),
          PostEntity(id: 5, title: 'Post 5', body: 'Corpo 5', userId: 5),
          PostEntity(id: 6, title: 'Post 6', body: 'Corpo 6', userId: 6),
          PostEntity(id: 7, title: 'Post 7', body: 'Corpo 7', userId: 7),
          PostEntity(id: 8, title: 'Post 8', body: 'Corpo 8', userId: 8),
          PostEntity(id: 9, title: 'Post 9', body: 'Corpo 9', userId: 9),
          PostEntity(id: 10, title: 'Post 10', body: 'Corpo 10', userId: 10),
          PostEntity(id: 11, title: 'Post 11', body: 'Corpo 11', userId: 11),
          PostEntity(id: 12, title: 'Post 12', body: 'Corpo 12', userId: 12),
        ];

        final authors = [
          AuthorEntity(
            userPhotoUrl: 'semfoto',
            userName: 'Samuel Arná',
            userAge: 31,
            userGostos: ['a', 'b', 'c'],
            numPost: 10,
          ),
        ];
        when(() => mockPostBloc.state).thenReturn(PostLoaded(testPosts));
        when(
          () => mockAuthorBloc.state,
        ).thenReturn(AuthorLoaded(author: authors.first));

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<PostBloc>(create: (context) => mockPostBloc),
              BlocProvider<AuthBloc>(create: (context) => mockAuthBloc),
              BlocProvider<AuthorBloc>(create: (context) => mockAuthorBloc),
            ],
            child: const MaterialApp(home: PostPage()),
          ),
        );

        expect(find.byType(ListPosts), findsOneWidget);
      },
    );

    testWidgets(
      'PostPage deve exibir mensagem de erro quando o estado for PostError',
      (WidgetTester tester) async {
        const mensagemErro = 'Falha ao carregar os posts';
        when(() => mockPostBloc.state).thenReturn(PostError(mensagemErro));

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<PostBloc>(create: (context) => mockPostBloc),
              BlocProvider<AuthBloc>(create: (context) => mockAuthBloc),
            ],
            child: const MaterialApp(home: PostPage()),
          ),
        );

        expect(find.text('Erro: $mensagemErro'), findsOneWidget);
      },
    );
  });
}
