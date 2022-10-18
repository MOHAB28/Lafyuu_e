import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../home/presentation/widgets/custom_dialog_builder.dart';
import '../../domain/entities/cart_entity.dart';
import '../bloc/cart_bloc.dart';

class CartItemBuillder extends StatelessWidget {
  const CartItemBuillder({
    Key? key,
    required this.data,
  }) : super(key: key);
  final CartItemDataEntity data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s5),
        border: Border.all(color: ColorManager.light),
      ),
      child: Row(
        children: [
          Image(
            height: AppSize.s72,
            width: AppSize.s72,
            image: NetworkImage(data.products.image),
            fit: BoxFit.cover,
          ),
          const SizedBox(width: AppSize.s12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        data.products.name,
                        maxLines: 4,
                        softWrap: true,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: data.products.inFav
                                ? const Icon(
                                    Icons.favorite,
                                    color: ColorManager.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline_sharp,
                                    color: ColorManager.grey,
                                  ),
                          ),
                          const SizedBox(width: AppSize.s8),
                          BlocListener<CartBloc, CartState>(
                            listener: (context, state) {
                              if (state is AddOrRemoveCartLoading) {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const CustomDialogBuilder(),
                                );
                              } else if (state is AddOrRemoveCartLoaded) {
                                dismissDialog(context);
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                CartBloc.get(context)
                                    .add(AddOrRemoveCartEvent(data.products));
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: ColorManager.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${data.products.price}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManager.blue),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s5),
                        border: Border.all(color: ColorManager.light),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              CartBloc.get(context)
                                  .add(DecreaseQuantityItemEvent(data));
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p18,
                              vertical: AppPadding.p3,
                            ),
                            color: ColorManager.light,
                            child: Center(
                              child: Text('${data.quantity}'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              CartBloc.get(context)
                                  .add(IncreaseQuantityItemEvent(data));
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
