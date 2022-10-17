part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial();

  @override
  List<Object> get props => [];
}

class GetAllFavLoading extends FavouriteState {
  const GetAllFavLoading();

  @override
  List<Object> get props => [];
}

class GetAllFavFailure extends FavouriteState {
  final PrimaryServerException exception;
  const GetAllFavFailure(this.exception);
  @override
  List<Object> get props => [exception];
}

class GetAllFavSuccess extends FavouriteState {
  final List<FavouriteProductEntity> products;
  const GetAllFavSuccess(this.products);
  @override
  List<Object> get props => [products];
}

class AddOrRemoveFavLoading extends FavouriteState {
  const AddOrRemoveFavLoading();

  @override
  List<Object> get props => [];
}

class AddOrRemoveFavSuccess extends FavouriteState {
  const AddOrRemoveFavSuccess(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

class AddOrRemoveFavFailure extends FavouriteState {
  const AddOrRemoveFavFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
