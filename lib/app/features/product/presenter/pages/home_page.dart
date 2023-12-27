import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/commons/widgets/app_dialogs.dart';
import 'package:store/app/commons/widgets/product_empty_state_widget.dart';
import 'package:store/app/commons/widgets/product_item_widget.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit_state.dart';
import 'package:store/app/features/product/presenter/widgets/chip_button_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ValueNotifier<bool> priceMoreValue = ValueNotifier<bool>(false);
  final ValueNotifier<bool> priceLessValue = ValueNotifier<bool>(false);
  final ValueNotifier<bool> orderValue = ValueNotifier<bool>(false);
  final ValueNotifier<bool> dateValue = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductsCubit>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Olá user!",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: [
          IconButton(
              onPressed: () => cubit.signout(),
              icon: SvgPicture.asset(
                AppAssets.logout,
                height: 32,
              )),
          const SizedBox(width: 16),
        ],
      ),
      body: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            if (state is ProductsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsErrorState) {
              return const Center(
                child: Text('error'),
              );
            } else if (state is ProductsSuccessState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 60,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          ChipButtonWidget(
                            chipController: dateValue,
                            title: 'Mais recente',
                            type: FilterTypeEnum.date,
                            onTap: () => clearOtherFilters(FilterTypeEnum.date),
                          ),

                          ChipButtonWidget(
                            chipController: priceLessValue,
                            title: 'Menor preço',
                            type: FilterTypeEnum.priceLess,
                            onTap: () => clearOtherFilters(FilterTypeEnum.priceLess),
                          ),

                          ChipButtonWidget(
                            chipController: priceMoreValue,
                            title: 'Maior preço',
                            type: FilterTypeEnum.priceMore,
                            onTap: () => clearOtherFilters(FilterTypeEnum.priceMore),
                          ),

                          ChipButtonWidget(
                            chipController: orderValue,
                            title: 'A - Z',
                            type: FilterTypeEnum.alphabetic,
                            onTap: () => clearOtherFilters(FilterTypeEnum.alphabetic),
                          ),

                          // Flexible(
                          //   child: TextFieldWidget(hintText: 'Buscar produto', suffixIcon: SvgPicture.asset(AppAssets.search)),
                          // ),
                          // const SizedBox(width: 12),
                          // ElevatedButton(
                          //     onPressed: () => AppDialogs.showModalFilters(
                          //           context,
                          //           cubit,
                          //           createdAtTextController,
                          //           priceTextController,
                          //           chip,
                          //         ),
                          //     child: SvgPicture.asset(
                          //       AppAssets.filter,
                          //       colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                          //     )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: state.products.isEmpty
                          ? const ProductEmptyStateWidget()
                          : RefreshIndicator(
                              onRefresh: () => cubit.getProducts(),
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                itemCount: state.products.length,
                                itemBuilder: (context, index) {
                                  return ProductItemWidget(
                                    product: state.products[index],
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () => context.pushNamed('create_product'),
        icon: const Icon(Icons.add),
        label: const Text("Adicionar um produto"),
      ),
    );
  }

  void clearOtherFilters(FilterTypeEnum type) {
    switch (type) {
      case FilterTypeEnum.date:
        priceMoreValue.value = false;
        priceLessValue.value = false;
        orderValue.value = false;
        break;

      case FilterTypeEnum.priceLess:
        dateValue.value = false;
        priceMoreValue.value = false;
        orderValue.value = false;
        break;

      case FilterTypeEnum.priceMore:
        dateValue.value = false;
        priceLessValue.value = false;
        orderValue.value = false;
        break;

      default:
        dateValue.value = false;
        priceLessValue.value = false;
        priceMoreValue.value = false;
    }
  }
}
