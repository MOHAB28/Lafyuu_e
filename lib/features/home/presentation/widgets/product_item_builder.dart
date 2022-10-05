import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../domain/entities/home_entity.dart';
import '../pages/product_details/product_details_page.dart';

class ProductItemBuilder extends StatelessWidget {
  const ProductItemBuilder({
    Key? key,
    required ProductsEntity product,
  })  : _product = product,
        super(key: key);

  final ProductsEntity _product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ProductDetailsPage(productsEntity: _product),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s5),
          border: Border.all(
            color: ColorManager.light,
            width: AppSize.s1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s5),
              child: Image(
                height: AppSize.s133,
                width: AppSize.s133,
                image: NetworkImage(_product.image),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            SizedBox(
              height: AppSize.s36,
              width: AppSize.s109,
              child: Text(
                _product.name,
                maxLines: 2,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              '\$${_product.price}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSize.s8),
            Row(
              children: [
                Text(
                  '\$${_product.oldPrice}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
                const SizedBox(width: AppSize.s8),
                Text(
                  '${_product.discount}% Off',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.red,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
