import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';

class AppDialogs {
  // static void showModalFilters(BuildContext context, ProductsCubit cubit, TextEditingController createdAt, TextEditingController price, ValueNotifier<bool> chip) {
  //   _showFiltersModal(context, cubit, createdAt, price, chip);
  // }

  static void showAlertDelete(BuildContext context, {required String title, required String content, void Function()? onConfirm}) {
    _showAlertDelete(context, title, content, onConfirm);
  }
}

// void _showFiltersModal(BuildContext context, ProductsCubit cubit, TextEditingController createdAt, TextEditingController price, ValueNotifier<bool> chip) {
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       useRootNavigator: true,
//       showDragHandle: true,
//       builder: (context) {
//         return Material(
//           child: Padding(
//             padding: MediaQuery.of(context).viewInsets,
//             child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(16),
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFieldWidget(
//                         controller: price,
//                         keyboardType: TextInputType.number,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           CentavosInputFormatter(),
//                         ],
//                         prefixIcon: SvgPicture.asset(
//                           AppAssets.price,
//                           height: 24,
//                           colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: TextFieldWidget(
//                         controller: createdAt,
//                         readonly: true,
//                         onTap: () => _datePicker(context, createdAt),
//                         prefixIcon: SvgPicture.asset(
//                           AppAssets.calendar,
//                           height: 24,
//                           colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     ValueListenableBuilder(
//                         valueListenable: chip,
//                         builder: (context, state, _) {
//                           final textColor = state ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onBackground;
//                           return ChoiceChip(
//                               elevation: 0,
//                               side: BorderSide.none,
//                               onSelected: (value) => chip.value = value,
//                               backgroundColor: Theme.of(context).colorScheme.onPrimary,
//                               showCheckmark: true,
//                               checkmarkColor: textColor,
//                               selectedColor: Theme.of(context).colorScheme.primary,
//                               shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//                               labelPadding: const EdgeInsets.all(8),
//                               label: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     "A - Z",
//                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                           color: textColor,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                               selected: state);
//                         }),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 ElevatedButton(
//                   onPressed: () {
//                     cubit.getProducts(createdAt: createdAt.text.isNotEmpty ? DateTime.parse(createdAt.text) : null, price: price.text, orderBy: chip.value);
//                     // createdAt.clear();
//                     // price.clear();
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Aplicar filtros'),
//                 ),
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//           //     ),
//         );
//       });
// }

void _showAlertDelete(BuildContext context, String title, String content, void Function()? onConfirm) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 4, horizontal: 12))), onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
            ElevatedButton(style: ButtonStyle(foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surface), backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.error), padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 4, horizontal: 12))), onPressed: onConfirm, child: const Text("Confirmar")),
          ],
        );
      });
}

// void _datePicker(context, TextEditingController controller) async {
//   DateTime? selectedDate = await showDatePicker(
//     context: context,
//     firstDate: DateTime(2000),
//     lastDate: DateTime.now(),
//     initialDate: DateTime.now(),
//   );
//   if (selectedDate != null) {
//     // Atualize o valor do controlador com a data selecionada
//     controller.text = selectedDate.toLocal().toString();
//   }
// }
