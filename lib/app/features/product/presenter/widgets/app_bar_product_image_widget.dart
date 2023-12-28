import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';

class AppBarProductImageWidget extends StatelessWidget {
  final String? imagePath;
  final ValueNotifier<XFile?> image;
  final void Function()? onEdit;
  const AppBarProductImageWidget({super.key, required this.imagePath, required this.image, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: image,
        builder: (context, state, _) {
          return AppBar(
            foregroundColor: Theme.of(context).colorScheme.primary,
            flexibleSpace: Stack(
              children: [
                Container(
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
                      image: getCurrentImage(context, state)),
                ),
                Positioned(
                    bottom: 16,
                    right: 32,
                    child: IconButton.filled(
                        onPressed: onEdit,
                        icon: const Icon(
                          Icons.edit_square,
                          size: 40,
                        ))),
              ],
            ),
          );
        });
  }

  DecorationImage getCurrentImage(context, XFile? state) {
    if (state != null) {
      return DecorationImage(
        image: FileImage(File(state.path)),
        fit: BoxFit.cover,
      );
    } else if (imagePath != null) {
      return DecorationImage(
        image: NetworkImage(imagePath ?? ''),
        fit: BoxFit.cover,
      );
    } else {
      return DecorationImage(
        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryContainer, BlendMode.srcATop),
        image: const AssetImage(AppAssets.defaultImage),
        fit: BoxFit.none,
      );
    }
  }
}
