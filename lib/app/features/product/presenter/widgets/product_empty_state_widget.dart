import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';

class ProductEmptyStateWidget extends StatelessWidget {
  const ProductEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SvgPicture.asset(
            AppAssets.emptyState,
            height: 200,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Você não possui\nprodutos cadastrados',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
