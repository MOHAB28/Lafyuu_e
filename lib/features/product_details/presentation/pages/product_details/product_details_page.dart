import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../../favourite/domain/entities/favourite_entity.dart';
import '../../../../favourite/presentation/bloc/favourite_bloc.dart';
import '../../../../home/domain/entities/home_entity.dart';
import '../../../../home/presentation/widgets/failure_handler_item_builder.dart';
import '../../../../login/presentation/widgets/custom_button.dart';
import '../../bloc/product_details_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductsEntity productsEntity;
  const ProductDetailsPage({super.key, required this.productsEntity});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    BlocProvider.of<ProductDetailsBloc>(context)
        .add(GetProductsDetailsEvent(widget.productsEntity.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is ProductDetailsStateLoading) {
          debugPrint('ProductDetailsBlocTracker --> RequestState.loading');
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProductDetailsStateSuccess) {
          debugPrint('ProductDetailsBlocTracker --> RequestState.success');
          FavouriteProductEntity favProduct = FavouriteProductEntity(
            description: state.product.description,
            discount: state.product.discount,
            id: state.product.id,
            image: state.product.image,
            name: state.product.name,
            oldPrice: state.product.oldPrice,
            price: state.product.price,
          );
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state.product.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    items: state.product.images
                        .map(
                          (image) => Image(
                            height:
                                (MediaQuery.of(context).size.height / 2) - 50,
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: (MediaQuery.of(context).size.height / 2) - 50,
                      viewportFraction: AppSize.s1,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Text(
                                state.product.name,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Flexible(
                              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                                builder: (context, favState) {
                                  if (favState is AddOrRemoveFavLoading) {
                                    return const CircularProgressIndicator();
                                  }
                                  return IconButton(
                                    onPressed: () {
                                      BlocProvider.of<FavouriteBloc>(context)
                                          .add(
                                        AddOrRemoveFavsEvent(favProduct),
                                      );
                                    },
                                    icon: FavouriteBloc.get(context)
                                            .urFavs
                                            .containsKey(state.product.id)
                                        ? const Favourite()
                                        : const UnFavourite(),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                        Row(
                          children: [
                            Text(
                              '\$${state.product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: ColorManager.blue),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                        Text(
                          state.product.description,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: AppSize.s16),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, favState) {
                            if (favState is AddOrRemoveCartLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return CustomButtonBuilder(
                              onTap: () {
                                BlocProvider.of<CartBloc>(context).add(
                                  AddOrRemoveCartEvent(state.product),
                                );
                              },
                              title: CartBloc.get(context)
                                      .urCart
                                      .containsKey(state.product.id)
                                  ? AppStrings.removeToCart
                                  : AppStrings.addToCart,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ProductDetailsStateFailure) {
          debugPrint('ProductDetailsBlocTracker --> RequestState.error');
          return FailureHandlerItemBuilder(
            message: state.exception.message,
            title: state.exception.error,
            onTap: () {
              BlocProvider.of<ProductDetailsBloc>(context)
                  .add(GetProductsDetailsEvent(widget.productsEntity.id));
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class UnFavourite extends StatelessWidget {
  const UnFavourite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite_outline,
      size: AppSize.s35,
      color: ColorManager.grey,
    );
  }
}

class Favourite extends StatelessWidget {
  const Favourite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.favorite,
      size: AppSize.s35,
      color: ColorManager.red,
    );
  }
}
