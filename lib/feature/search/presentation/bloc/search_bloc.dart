import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sweetella/feature/search/data/repos/search_repo.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_event.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repo;

  SearchBloc(this.repo) : super(SearchInitial()) {
    on<SearchProductsEvent>(
      _onSearch,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onSearch(
    SearchProductsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    final result = await repo.searchProducts(query: event.query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (products) => emit(SearchSuccess(products)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}
