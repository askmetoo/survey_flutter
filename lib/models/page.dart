import 'package:equatable/equatable.dart';

class Page extends Equatable {
  final int currentPage;
  final int scrollPosition;

  Page({
    this.currentPage,
    this.scrollPosition,
  });

  @override
  List<Object> get props => [
        currentPage,
        scrollPosition,
      ];

  @override
  String toString() {
    return 'Page { currentPage: $currentPage, '
        'scrollPosition: $scrollPosition} \n';
  }

  Page copyWith({currentPage, scrollPosition}) {
    return Page(
      currentPage: currentPage ?? this.currentPage,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }
}

class PageData {
  Page page = Page(currentPage: 0, scrollPosition: 0);
}
