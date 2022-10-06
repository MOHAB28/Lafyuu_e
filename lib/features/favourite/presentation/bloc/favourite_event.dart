part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavoureitesEvent extends FavouriteEvent {}

class AddOrRemoveFavsEvent extends FavouriteEvent {
  final int id;
  const AddOrRemoveFavsEvent(this.id);
}
