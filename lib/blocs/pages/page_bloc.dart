import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:surveystructure/models/models.dart';
import 'page.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  @override
  PageState get initialState => InitialPageState();

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is PageLoaded) {
      yield* _mapPageLoadedToState(event);
    } else if (event is PageTurned) {
      yield* _mapPageTurnedToState(event);
    }
  }

  Stream<PageState> _mapPageLoadedToState(PageEvent event) async* {
    try {
      final PageData pageData = PageData();
      final page = pageData.page;
      yield PageLoadSuccess(page);
    } catch (_) {
      yield PageLoadFailure();
    }
  }

  Stream<PageState> _mapPageTurnedToState(PageEvent event) async* {
    try {
      final PageTurnedType pageTurnedType = (event as PageTurned).type;
      final int targetPage = (event as PageTurned).targetPage;
      Page page = (state as PageLoadSuccess).page;
      if (pageTurnedType == PageTurnedType.previous) {
        yield PageLoadSuccess(
          page.copyWith(currentPage: page.currentPage - 1),
        );
      } else if (pageTurnedType == PageTurnedType.next) {
        yield PageLoadSuccess(
          page.copyWith(currentPage: page.currentPage + 1),
        );
      } else if (pageTurnedType == PageTurnedType.specific) {
        yield PageLoadSuccess(
          page.copyWith(currentPage: targetPage),
        );
      }
    } catch (_) {
      yield PageLoadFailure();
    }
  }
}
