import 'package:flutter/material.dart';

class ProjectLocalization {
  bool isZh = false;
  ProjectLocalization(this.isZh);

  static ProjectLocalization of(BuildContext context) {
    var result =
        Localizations.of<ProjectLocalization>(context, ProjectLocalization);
    return result;
  }

  String get title {
    return isZh ? '应用标题' : 'APP_TITLE';
  }

  String get validate {
    return isZh ? '验证身份' : 'validate';
  }
}
