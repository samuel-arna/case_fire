import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailsPage extends StatefulWidget {
  final PostEntity post;
  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    String title = widget.post.title;
    String body = widget.post.body;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textHighlightColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                body,
                style: TextStyle(fontSize: 18, color: AppColors.textColor),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
