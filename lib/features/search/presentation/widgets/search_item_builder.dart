import 'package:flutter/material.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';

class SearchItemBuilder extends StatelessWidget {
  const SearchItemBuilder({super.key, required this.data});
  final ProductsEntity data;

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
            image: NetworkImage(data.image),
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
                      flex: 7,
                      child: Text(
                        data.name,
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
                            child: data.inFav
                                ? const Icon(
                                    Icons.favorite,
                                    color: ColorManager.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline_sharp,
                                    color: ColorManager.grey,
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
                      '\$${data.price}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: ColorManager.blue),
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
}
