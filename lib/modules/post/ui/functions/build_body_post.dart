import 'package:case_fire/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildBodyPost {
  List<Widget> buildBody(String body) {
    if (body.length < 100) {
      return [
        Text(body, style: TextStyle(fontSize: 18, color: AppColors.textColor)),
      ];
    } else {
      return [
        Text(
          '${body.substring(0, 100)}...',
          style: TextStyle(fontSize: 18, color: AppColors.textColor),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              'Ver Mais',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textHighlightColor,
              ),
            ),
          ),
        ),
      ];
    }
  }
}
