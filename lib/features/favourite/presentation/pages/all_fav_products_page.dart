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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.favoriteProduct),
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        listener: (context, state) {},
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final favs = FavouriteBloc.get(context).urFavs.values.toList();
          debugPrint('Favourite Bloc Tracker');
          if (favs.isNotEmpty) {
            debugPrint(
                'Favourite Bloc Tracker --> GetAllFavSuccess --> products.isNotEmpty');
            return GridView.builder(
              itemCount: favs.length,
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
                  key: ValueKey(favs[i].id),
                  name: favs[i].name,
                  price: favs[i].price,
                  id: favs[i].id,
                  index: i,
                  description: favs[i].description,
                  oldPrice: favs[i].oldPrice,
                  discount: favs[i].discount,
                  image: favs[i].image,
                  showRemoveFromLikesButton: true,
                );
              },
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
