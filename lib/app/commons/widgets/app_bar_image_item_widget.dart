import 'package:flutter/material.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';

class AppBarImageItemWidget extends StatelessWidget {
  final String? imagePath;
  const AppBarImageItemWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surfaceVariant,
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4), // Deslocamento da sombra
            ),
          ],
          image: imagePath != null
              ? DecorationImage(
                  image: NetworkImage(imagePath ?? ''),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryContainer, BlendMode.srcATop),
                  image: const AssetImage(AppAssets.defaultImage),
                  fit: BoxFit.none,
                ),
        ),
      ),
    );
  }
}
