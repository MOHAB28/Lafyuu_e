import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/values_manager.dart';
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
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            size: AppSize.s35,
                            color: ColorManager.grey,
                          ),
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
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall,
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