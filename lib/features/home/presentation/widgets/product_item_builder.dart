import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../favourite/presentation/bloc/favourite_bloc.dart';
import '../../domain/entities/home_entity.dart';
import '../../../product_details/presentation/pages/product_details/product_details_page.dart';
import 'custom_dialog_builder.dart';

class ProductItemBuilder extends StatelessWidget {
  const ProductItemBuilder({
    Key? key,
    required this.discount,
    required this.image,
    required this.name,
    required this.oldPrice,
    required this.price,
    this.product,
    this.id,
    this.description,
    required this.index,
    this.showRemoveFromLikesButton = false,
    this.onPressed,
  }) : super(key: key);

  final String image;
  final String name;
  final dynamic price;
  final int? id;
  final int index;
  final String? description;
  final dynamic oldPrice;
  final dynamic discount;
  final ProductsEntity? product;
  final bool showRemoveFromLikesButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: product != null
          ? () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(productsEntity: product!),
                ),
              );
            }
          : null,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s5),
          border: Border.all(
            color: ColorManager.light,
            width: AppSize.s1,
          ),
        ),
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s5),
                child: Image(
                  height: AppSize.s133,
                  width: AppSize.s133,
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              SizedBox(
                height: AppSize.s36,
                width: AppSize.s109,
                child: Text(
                  name,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                '\$$price',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$$oldPrice',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  const SizedBox(width: AppSize.s8),
                  Text(
                    '$discount% Off',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: ColorManager.red,
                        ),
                  ),
                  if (showRemoveFromLikesButton) ...[
                    const SizedBox(width: AppSize.s8),
                    BlocConsumer<FavouriteBloc, FavouriteState>(
                      listener: (context, state) {
                        if (state is AddOrRemoveFavLoading) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => const CustomDialogBuilder(),
                          );
                        } else if (state is AddOrRemoveFavSuccess) {
                          dismissDialog(context);
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            BlocProvider.of<FavouriteBloc>(context).add(
                              AddOrRemoveFavsEvent(FavouriteProductEntity(
                                description: description!,
                                discount: discount,
                                id: id!,
                                image: image,
                                name: name,
                                oldPrice: oldPrice,
                                price: price,
                              )),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outlined,
                            size: AppSize.s25,
                            color: ColorManager.grey,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  void dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}

