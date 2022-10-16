import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/failure_handler_item_builder.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favoriteProduct),
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        listener: (context, state) {},
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          debugPrint('Favourite Bloc Tracker');
          if (state is GetAllFavLoading) {
            debugPrint('Favourite Bloc Tracker --> GetAllFavLoading');
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllFavSuccess) {
            debugPrint('Favourite Bloc Tracker --> GetAllFavSuccess');
            if (state.products.isNotEmpty) {
              debugPrint(
                  'Favourite Bloc Tracker --> GetAllFavSuccess --> products.isNotEmpty');
              return GridView.builder(
                itemCount: state.products.length,
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
                    name: state.products[i].name,
                    price: state.products[i].price,
                    oldPrice: state.products[i].oldPrice,
                    discount: state.products[i].discount,
                    image: state.products[i].image,
                    showRemoveFromLikesButton: true,
                    onPressed: () {
                      BlocProvider.of<FavouriteBloc>(context).add(
                        AddOrRemoveFavsEvent(
                          state.products[i],
                        ),
                      );
                      FlushbarHelper.createLoading(
                        message: AppStrings.loading,
                        linearProgressIndicator:
                            const LinearProgressIndicator(),
                        duration: const Duration(seconds: 1),
                      ).show(context);
                    },
                  );
                },
              );
            } else if (state.products.isEmpty) {
              debugPrint(
                  'Favourite Bloc Tracker --> GetAllFavSuccess --> products.isEmpty');
              Center(
                child: Text(
                  AppStrings.noItems,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              );
            }
          } else if (state is GetAllFavFailure) {
            debugPrint('Favourite Bloc Tracker --> GetAllFavFAilure');

            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: FailureHandlerItemBuilder(
                message: state.exception.message,
                title: state.exception.error,
                onTap: () {
                  FavouriteBloc.get(context).add(GetAllFavoureitesEvent());
                },
              ),
            );
          }
          debugPrint('Favourite Bloc Tracker --> BLoc');
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
