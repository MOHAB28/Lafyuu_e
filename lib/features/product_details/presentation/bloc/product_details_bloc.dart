import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exception.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../../domain/usecases/get_product_details_usecase.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final GetProductDetailsUsecase _usecase;
  ProductDetailsBloc(this._usecase)
      : super(const ProductDetailsStateInitial()) {
    on<GetProductsDetailsEvent>(_getProductDetails);
  }

  FutureOr<void> _getProductDetails(
      GetProductsDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(const ProductDetailsStateLoading());
    final successOrFailure = await _usecase(event.id);
    successOrFailure.fold(
      (failure) => emit(ProductDetailsStateFailure(failure)),
      (data) => emit(ProductDetailsStateSuccess(data)),
    );
  }
}
