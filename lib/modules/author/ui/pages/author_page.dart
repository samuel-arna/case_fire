import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/author/ui/functions/info_author_functions.dart';
import 'package:flutter/material.dart';
import 'package:case_fire/modules/author/domain/entities/author_entity.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorPage extends StatelessWidget {
  final AuthorEntity author;

  const AuthorPage({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    InfoAuthorFunctions infoAuthor = InfoAuthorFunctions();
    return Scaffold(
      appBar: AppBar(title: Text('Informações do Autor')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  author.userName ?? 'Nome não disponível',
                  style: GoogleFonts.montserrat(
                    fontSize: 27,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                const SizedBox(height: 30),
                author.userPhotoUrl != null
                    ? ClipOval(
                      child: Image.network(
                        author.userPhotoUrl!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 100);
                        },
                      ),
                    )
                    : const Icon(Icons.person, size: 100),
                const SizedBox(height: 60),
                Column(
                  spacing: 9,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoAuthor.buildAge(author.userAge),
                    infoAuthor.buildHobbies(author.userGostos),
                    infoAuthor.buildNumPosts(author.numPost),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
