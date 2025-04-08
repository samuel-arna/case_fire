import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/author/ui/widgets/author_photo.dart';
import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/ui/functions/build_body_post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostItem extends StatefulWidget {
  final PostEntity post;

  const PostItem({super.key, required this.post});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    String title = widget.post.title;
    String body = widget.post.body;
    BuildBodyPost functions = BuildBodyPost();
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 100),

        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            boxShadow: [
              BoxShadow(
                offset: Offset(3, 3),
                color: Colors.black12,
                blurRadius: 15,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 30,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AuthorPhoto(userId: widget.post.userId),
                ),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textHighlightColor,
                  ),
                ),
                ...functions.buildBody(body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
