import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/resources/values_manager.dart';
import '../../../../domain/entities/home_entity.dart';
import '../../../bloc/home_bloc.dart';
import '../../../widgets/failure_handler_item_builder.dart';
import '../../../widgets/product_item_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var bloc = HomeBloc.get(context);
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              if (bloc.homeData != null) {
                return _getContentWidget(bloc.homeData!);
              }
            } else if (state is HomeFailure) {
              return FailureHandlerItemBuilder(
                message: state.exception.message,
                title: state.exception.error,
                onTap: () {
                  HomeBloc.get(context).add(GetHomeDataEvent());
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _getContentWidget(HomeEntity homeData) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CarouselSliderCustomBuilder(
          banners: homeData.homeData.banners,
        ),
        const SizedBox(height: AppSize.s20),
        HomeGridViewBuilder(
          products: homeData.homeData.products,
        ),
      ],
    );
  }
}

class HomeGridViewBuilder extends StatelessWidget {
  const HomeGridViewBuilder({
    Key? key,
    this.products,
  }) : super(key: key);
  final List<ProductsEntity>? products;
  @override
  Widget build(BuildContext context) {
    if (products != null) {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: products!.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSize.s12,
          crossAxisSpacing: AppSize.s12,
          childAspectRatio: 3 / 4.8,
        ),
        itemBuilder: (ctx, i) {
          return ProductItemBuilder(
            product: products![i],
            name: products![i].name,
            price: products![i].price,
            oldPrice: products![i].oldPrice,
            discount: products![i].discount,
            image: products![i].image,
          );
        },
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class CarouselSliderCustomBuilder extends StatelessWidget {
  const CarouselSliderCustomBuilder({
    Key? key,
    this.banners,
  }) : super(key: key);

  final List<BannerEntity>? banners;

  @override
  Widget build(BuildContext context) {
    if (banners != null) {
      return CarouselSlider(
        items: banners!
            .map(
              (banner) => ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s5),
                child: Image(
                  height: AppSize.s206,
                  image: NetworkImage(banner.image),
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          viewportFraction: AppSize.s1,
          autoPlay: true,
          enableInfiniteScroll: true,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
