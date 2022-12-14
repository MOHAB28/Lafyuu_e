import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../login/presentation/widgets/custom_button.dart';
import '../../bloc/cart_bloc.dart';
import '../../widgets/cart_item_builder.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cartItemData = CartBloc.get(context).urCart.values.toList();
        var total = CartBloc.get(context).total;
        if (cartItemData.isNotEmpty) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                ListView.separated(
                  itemCount: cartItemData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return CartItemBuillder(
                      data: cartItemData[i],
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(height: AppSize.s16);
                  },
                ),
                const SizedBox(height: AppSize.s32),
                Container(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s5),
                    border: Border.all(color: ColorManager.light),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          AppStrings.subTotal,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        trailing: Text(
                          '\$${total.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: ColorManager.dark),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          AppStrings.total,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        trailing: Text(
                          '\$${total.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: ColorManager.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                CustomButtonBuilder(
                  title: AppStrings.checkOut,
                  onTap: () {},
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
