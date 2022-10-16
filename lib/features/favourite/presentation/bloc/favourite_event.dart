part of 'favourite_bloc.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class GetAllFavoureitesEvent extends FavouriteEvent {}

class AddOrRemoveFavsEvent extends FavouriteEvent {
  final FavouriteProductEntity item;
  const AddOrRemoveFavsEvent(this.item);
  @override
  List<Object> get props => [item];  
}
