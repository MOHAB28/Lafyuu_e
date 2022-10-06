part of 'favourite_bloc.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class GetAllFavLoading extends FavouriteState {}

class GetAllFavFailure extends FavouriteState {
  final PrimaryServerException exception;
  const GetAllFavFailure(this.exception);
}

class GetAllFavSuccess extends FavouriteState {}

class AddOrRemoveFavLoading extends FavouriteState {}

class AddOrRemoveFavFailure extends FavouriteState {}

class AddOrRemoveFavSuccess extends FavouriteState {
  final StatusEntity data;
  const AddOrRemoveFavSuccess(this.data);
}
