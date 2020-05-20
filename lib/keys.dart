import 'package:flutter/widgets.dart';

class SurveyStructureKeys {
  static final choice = (String id, int value) => Key('Choice__${id}__$value');
  static final note = (String id, int value) => Key('Note__${id}__$value');
}
