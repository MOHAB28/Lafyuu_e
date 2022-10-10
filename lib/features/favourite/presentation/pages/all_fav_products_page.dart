import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/product_item_builder.dart';
import '../bloc/favourite_bloc.dart';
import '../../../../core/resources/strings_manager.dart';

class AllFavProductPage extends StatefulWidget {
  const AllFavProductPage({super.key});

  @override
  State<AllFavProductPage> createState() => _AllFavProductPageState();
}

class _AllFavProductPageState extends State<AllFavProductPage> {
  @override
  void initState() {
    BlocProvider.of<FavouriteBloc>(context).add(GetAllFavoureitesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favoriteProduct),
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          if (state is AddOrRemoveFavSuccess) {
            BlocProvider.of<FavouriteBloc>(context)
                .add(GetAllFavoureitesEvent());
          }
        },
        builder: (context, state) {
          var bloc = FavouriteBloc.get(context);
          if (state is GetAllFavLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllFavSuccess) {
            if (bloc.favouriteEntity != null) {
              if (bloc.favouriteEntity!.favProductsEntity.products.isNotEmpty) {
                return GridView.builder(
                  itemCount:
                      bloc.favouriteEntity!.favProductsEntity.products.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(AppPadding.p16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSize.s12,
                    crossAxisSpacing: AppSize.s12,
                    childAspectRatio: 3 / 4.8,
                  ),
                  itemBuilder: (ctx, i) {
                    return ProductItemBuilder(
                      name: bloc
                          .favouriteEntity!.favProductsEntity.products[i].name,
                      price: bloc
                          .favouriteEntity!.favProductsEntity.products[i].price,
                      oldPrice: bloc.favouriteEntity!.favProductsEntity
                          .products[i].oldPrice,
                      discount: bloc.favouriteEntity!.favProductsEntity
                          .products[i].discount,
                      image: bloc
                          .favouriteEntity!.favProductsEntity.products[i].image,
                      showRemoveFromLikesButton: true,
                      onPressed: () {
                        BlocProvider.of<FavouriteBloc>(context).add(
                          AddOrRemoveFavsEvent(
                            bloc.favouriteEntity!.favProductsEntity.products[i]
                                .id,
                          ),
                        );
                        FlushbarHelper.createLoading(
                          message: AppStrings.loading,
                          linearProgressIndicator:
                              const LinearProgressIndicator(),
                        ).show(context);
                      },
                    );
                  },
                );
              } else if (bloc
                  .favouriteEntity!.favProductsEntity.products.isEmpty) {
                Center(
                  child: Text(
                    AppStrings.noItems,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                );
              }
            }
          }
          return Center(
            child: Text(
              AppStrings.noItems,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          );
        },
      ),
    );
  }
}
