import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

// TODO 使用時，先照 groupID 排序，再照 value 排序
class Choice extends Equatable {
  final int value;
  final ChoiceType type;
  final String label;
  final int groupID;
  final String groupName;

  Choice({
    this.value,
    this.type,
    this.label,
    this.groupID,
    this.groupName,
  });

  @override
  List<Object> get props => [value, type, label, groupID, groupName];

  @override
  String toString() {
    return 'Choice { value: $value, type: $type, label: $label, '
        'groupID: $groupID, groupName: $groupName } \n';
  }
}

class ChoiceData {
  static final List<Choice> choices = [
    Choice(
      value: 1,
      type: ChoiceType.choice,
      label: '選項1',
      groupID: 0,
      groupName: '組別1',
    ),
    Choice(
      value: 2,
      type: ChoiceType.choice,
      label: '選項2',
      groupID: 0,
      groupName: '組別1',
    ),
    Choice(
      value: 3,
      type: ChoiceType.choice,
      label: '選項3',
      groupID: 1,
      groupName: '組別2',
    ),
    Choice(
      value: 4,
      type: ChoiceType.note,
      label: '選項4',
      groupID: 1,
      groupName: '組別2',
    ),
  ];

  static final List<Choice> specialChoices = [
    Choice(
      value: 97,
      type: ChoiceType.choice,
      label: '選項97',
    ),
    Choice(
      value: 98,
      type: ChoiceType.choice,
      label: '選項98',
    ),
    Choice(
      value: 99,
      type: ChoiceType.choice,
      label: '選項99',
    ),
  ];
}
