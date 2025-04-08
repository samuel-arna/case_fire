import 'package:case_fire/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class InfoAuthorFunctions {
  buildAge(int? idade) {
    return Row(
      spacing: 9,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Idade:',
          style: TextStyle(
            fontSize: 21,
            color: AppColors.textHighlightColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          idade != null ? '$idade anos' : 'Não informada',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  buildNumPosts(int? numPost) {
    return Row(
      spacing: 9,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Número de Posts:',
          style: TextStyle(
            fontSize: 21,
            color: AppColors.textHighlightColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '${numPost ?? 'Não informado'}',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  Widget buildHobbies(List<String>? gostos) {
    return Row(
      spacing: 9,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gostos:',
          style: TextStyle(
            fontSize: 21,
            color: AppColors.textHighlightColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 300,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 6,
            runSpacing: 6,
            children:
                gostos != null && gostos.isNotEmpty
                    ? gostos
                        .map(
                          (gosto) => IntrinsicWidth(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 9,
                                ),
                                child: Center(
                                  child: Text(
                                    gosto,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList()
                    : [
                      Text(
                        'Não informados',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
          ),
        ),
      ],
    );
  }
}
