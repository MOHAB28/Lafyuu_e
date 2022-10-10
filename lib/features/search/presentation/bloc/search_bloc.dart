import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/usecases/search_usecase.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUsecase _usecase;
  static SearchBloc get(BuildContext context) => BlocProvider.of(context);
  SearchEntity? searchEntity;
  SearchBloc(this._usecase) : super(SearchInitial()) {
    on<UserWantsToSearch>((event, emit) async {
      emit(SearchLoading());
      final successOrFailure = await _usecase(event.text);
      successOrFailure.fold(
        (failure) => emit(SearchFailure()),
        (data) {
          searchEntity = data;
          emit(SearchLoaded());
        },
      );
    });
  }
}
