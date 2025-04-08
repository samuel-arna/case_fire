import 'package:case_fire/core/utils/app_colors.dart';
import 'package:case_fire/modules/post/ui/widgets/post_body.dart';
import 'package:flutter/material.dart';

class BuildBodyPost {
  List<Widget> buildBody(String body) {
    if (body.length < 100) {
      return [
        Text(body, style: TextStyle(fontSize: 18, color: AppColors.textColor)),
      ];
    } else {
      return [PostBody(body: body)];
    }
  }
}
