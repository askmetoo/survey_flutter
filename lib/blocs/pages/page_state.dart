import 'package:equatable/equatable.dart';
import 'package:surveystructure/models/models.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class InitialPageState extends PageState {
  final Page page = Page(currentPage: 1, scrollPosition: 0);

  InitialPageState();

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'InitialPageState { page: $page }';
}

class PageLoadInProgress extends PageState {}

class PageLoadSuccess extends PageState {
  final Page page;

  const PageLoadSuccess(this.page);

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'PageLoadSuccess { page: $page }';
}

class PageLoadFailure extends PageState {}
