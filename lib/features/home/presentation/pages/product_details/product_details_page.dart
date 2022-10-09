import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:lafyuu/features/favourite/presentation/bloc/favourite_bloc.dart';
import 'package:lafyuu/features/home/presentation/bloc/home_bloc.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../login/presentation/widgets/custom_button.dart';
import '../../../domain/entities/home_entity.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductsEntity productsEntity;
  const ProductDetailsPage({super.key, required this.productsEntity});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productsEntity.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: widget.productsEntity.images
                  .map(
                    (image) => Image(
                      height: (MediaQuery.of(context).size.height / 2) - 50,
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
                          widget.productsEntity.name,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Flexible(
                        child: BlocConsumer<FavouriteBloc, FavouriteState>(
                          listener: (context, state) {
                            if (state is AddOrRemoveFavFailure) {
                              BlocProvider.of<HomeBloc>(context).add(
                                  ChangeFavEvent(widget.productsEntity.id));
                            } else if (state is AddOrRemoveFavSuccess) {
                              FlushbarHelper.createSuccess(
                                      message: state.data.message)
                                  .show(context);
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                BlocProvider.of<HomeBloc>(context).add(
                                    ChangeFavEvent(widget.productsEntity.id));
                                BlocProvider.of<FavouriteBloc>(context).add(
                                    AddOrRemoveFavsEvent(
                                        widget.productsEntity.id));
                              },
                              icon: HomeBloc.get(context).favorties[
                                          widget.productsEntity.id] ==
                                      true
                                  ? const Icon(
                                      Icons.favorite,
                                      size: AppSize.s35,
                                      color: ColorManager.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline,
                                      size: AppSize.s35,
                                      color: ColorManager.grey,
                                    ),
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
                        '\$${widget.productsEntity.price}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s16),
                  Text(
                    widget.productsEntity.description,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: AppSize.s16),
                  BlocConsumer<CartBloc, CartState>(
                    listener: (context, state) {
                      if (state is AddOrRemoveCartFailure) {
                        BlocProvider.of<HomeBloc>(context)
                            .add(ChangeFavEvent(widget.productsEntity.id));
                      } else if (state is AddOrRemoveCartLoaded) {
                        FlushbarHelper.createSuccess(
                                message: state.statusEntity.message)
                            .show(context);
                      }
                    },
                    builder: (context, state) {
                      return CustomButtonBuilder(
                        onTap: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(ChangeCartEvent(widget.productsEntity.id));
                          BlocProvider.of<CartBloc>(context).add(
                              AddOrRemoveCartEvent(widget.productsEntity.id));
                        },
                        title: HomeBloc.get(context)
                                    .carts[widget.productsEntity.id] ==
                                true
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
  }
}
