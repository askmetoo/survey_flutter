import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class PageLoaded extends PageEvent {}

class PageTurned extends PageEvent {
  final PageTurnedType type;
  final int targetPage;

  const PageTurned(this.type, {this.targetPage});

  @override
  List<Object> get props => [type, targetPage];

  @override
  String toString() => 'PageTurned { type: $type, targetPage: $targetPage }';
}
