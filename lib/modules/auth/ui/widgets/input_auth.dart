import 'package:case_fire/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class InputAuth extends StatelessWidget {
  final IconData icon;
  final bool? pass;
  final String hint;
  final TextEditingController controller;
  const InputAuth({
    super.key,
    required this.icon,
    this.pass,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          // border: Border.all(color: AppColors.textHighlightColor, width: 2),
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(60),
                ),
              ),
              child: Center(child: FaIcon(icon, size: 21)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: controller,
                  obscureText: pass ?? false,
                  style: GoogleFonts.montserrat(
                    color: AppColors.textHighlightColor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: GoogleFonts.montserrat(
                      color: AppColors.textHighlightColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
