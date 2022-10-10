import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../bloc/search_bloc.dart';
import '../widgets/cutsom_sized_box_builder.dart';
import '../widgets/search_item_builder.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {},
          builder: (context, state) {
            var searchEntity = SearchBloc.get(context).searchEntity;
            return Column(
              children: [
                TextFormField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: AppStrings.searchProduct,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onFieldSubmitted: (value) {
                    SearchBloc.get(context)
                        .add(UserWantsToSearch(_searchController.text.trim()));
                  },
                ),
                const SizedBox(height: AppSize.s16),
                if (state is SearchLoading) ...[
                  const CustomSizedBoxBuilder(
                    child: CircularProgressIndicator(),
                  ),
                ] else if (state is SearchLoaded) ...[
                  if (searchEntity != null) ...[
                    if (searchEntity.searchData.products.isNotEmpty) ...[
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: searchEntity.searchData.products.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (ctx, i) {
                          return SearchItemBuilder(
                            data: searchEntity.searchData.products[i],
                          );
                        },
                        separatorBuilder: (_, __) {
                          return const SizedBox(height: AppSize.s16);
                        },
                      ),
                    ] else if (searchEntity.searchData.products.isEmpty) ...[
                      CustomSizedBoxBuilder(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundColor: ColorManager.blue,
                              radius: AppSize.s30,
                              child: Center(
                                child: Icon(
                                  Icons.close_rounded,
                                  color: ColorManager.white,
                                  size: AppSize.s25,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSize.s16),
                            Text(
                              AppStrings.productNotFound,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            const SizedBox(height: AppSize.s8),
                            Text(
                              AppStrings.thankYouForShopping,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ]
                ],
                if (_searchController.text.isEmpty) ...[
                  CustomSizedBoxBuilder(
                    child: Text(
                      AppStrings.pleaseStartSearch,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ]
              ],
            );
          }),
    );
  }
}
