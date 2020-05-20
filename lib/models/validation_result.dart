import 'package:equatable/equatable.dart';

class ValidationResult extends Equatable {
  final bool pass;
  final String warning;

  ValidationResult({this.pass, this.warning});

  @override
  List<Object> get props => [pass, warning];

  @override
  String toString() {
    return 'ValidationResult { pass: $pass, warning: $warning} \n';
  }

  ValidationResult copyWith({bool pass, String warning}) {
    return ValidationResult(
      pass: pass ?? this.pass,
      warning: warning ?? this.warning,
    );
  }
}
