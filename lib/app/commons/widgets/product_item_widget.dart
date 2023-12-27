import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/widgets/app_dialogs.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    inspect(product);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            //  color: Theme.of(context).colorScheme.onPrimary,
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            product.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          subtitle: Text(product.price.toString(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
          minLeadingWidth: 100,
          leading: product.images != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.images?.first ?? '',
                    fit: BoxFit.contain,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SvgPicture.asset(
                    AppAssets.svgDefaultImage,
                    height: 60,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryContainer, BlendMode.srcIn),
                  ),
                ),
          trailing: IconButton(
              onPressed: () => AppDialogs.showAlertDelete(
                    context,
                    title: 'Atenção!',
                    content: 'Deseja realmente deletar este produto?',
                    onConfirm: () {
                      cubit.remove(productId: product.id ?? '');
                      Navigator.pop(context);
                    },
                  ),
              icon: SvgPicture.asset(
                AppAssets.delete,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.error, BlendMode.srcIn),
              )),
          onTap: () => context.pushNamed('product_details', extra: product),
        ),
      ),
    );
  }
}
