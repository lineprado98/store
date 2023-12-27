import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/app/commons/utils/enums/filter_type_enum.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';

class ChipButtonWidget extends StatelessWidget {
  final String title;
  final FilterTypeEnum type;
  final ValueNotifier<bool> chipController;
  final Function() onTap;
  const ChipButtonWidget({super.key, required this.chipController, required this.title, required this.type, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    return ValueListenableBuilder(
        valueListenable: chipController,
        builder: (context, state, _) {
          final textColor = state ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onBackground;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
                elevation: 0,
                side: BorderSide.none,
                onSelected: (value) async {
                  onTap();
                  chipController.value = value;
                  if (value) {
                    await cubit.getProducts(orderBy: type);
                  }
                },
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                showCheckmark: true,
                checkmarkColor: textColor,
                selectedColor: Theme.of(context).colorScheme.primary,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                labelPadding: const EdgeInsets.all(8),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 4),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textColor,
                          ),
                    ),
                  ],
                ),
                selected: state),
          );
        });
  }
}
