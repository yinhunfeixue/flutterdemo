import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/locals/ProjectLocalization.dart';

class ProjectLocalizationsDelegate
    extends LocalizationsDelegate<ProjectLocalization> {
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<ProjectLocalization> load(Locale locale) {
    var result = SynchronousFuture<ProjectLocalization>(
        ProjectLocalization(locale.languageCode == 'zh'));
    return result;
  }

  @override
  bool shouldReload(LocalizationsDelegate<ProjectLocalization> old) {
    return false;
  }

   static ProjectLocalizationsDelegate delegate = ProjectLocalizationsDelegate();
}
