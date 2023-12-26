import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/widgets/app_dialogs.dart';
import 'package:store/app/commons/widgets/product_empty_state_widget.dart';
import 'package:store/app/commons/widgets/product_item_widget.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/features/product/presenter/cubit/products_cubit.dart';
import 'package:store/app/features/product/presenter/cubit/products_cubit_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //SchedulerBinding.instance.addPersistentFrameCallback((_) async {
    BlocProvider.of<ProductsCubit>(context).getProducts();
    // });
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
              return Center(
                child: Text('error'),
              );
            } else if (state is ProductsSuccessState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Flexible(
                          child: TextFieldWidget(hintText: 'Buscar produto', suffixIcon: SvgPicture.asset(AppAssets.search)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                            onPressed: () => AppDialogs.showModalFilters(context),
                            child: SvgPicture.asset(
                              AppAssets.filter,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                            )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: state.products.isEmpty
                          ? const ProductEmptyStateWidget()
                          : ListView.builder(
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
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton.icon(onPressed: () => context.go('create_account'), icon: const Icon(Icons.add), label: const Text("Adicionar um produto")),
    );
  }
}
