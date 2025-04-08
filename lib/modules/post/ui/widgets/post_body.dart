import 'package:case_fire/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostBody extends StatefulWidget {
  final String body;
  const PostBody({super.key, required this.body});

  @override
  State<PostBody> createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  bool seeMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          seeMore ? widget.body : '${widget.body.substring(0, 100)}...',
          style: TextStyle(fontSize: 18, color: AppColors.textColor),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  seeMore = !seeMore;
                });
              },
              child: Text(
                seeMore ? 'Ver Menos' : 'Ver Mais',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textHighlightColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
