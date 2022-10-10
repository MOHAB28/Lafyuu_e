part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class UserWantsToSearch extends SearchEvent {
  final String text;
  const UserWantsToSearch(this.text);
}