import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/theme/resources/app_validators.dart';
import 'package:store/app/commons/widgets/app_bar_image_item_widget.dart';
import 'package:store/app/commons/widgets/app_dialogs.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit.dart';
import 'package:store/app/features/product/presenter/cubit/product_list/products_cubit.dart';
import 'package:store/app/features/product/presenter/widgets/text_field_edit_product_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with AppValidatorsMixin {
  final ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);
  final titleTextController = TextEditingController();
  final idTextController = TextEditingController();
  final codeTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleTextController.text = widget.product.name;
    codeTextController.text = widget.product.code.toString();
    idTextController.text = widget.product.id.toString();
    priceTextController.text = widget.product.price.toString();
    quantityTextController.text = widget.product.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);
    final updateCubit = BlocProvider.of<CreateProductCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400),
        child: AppBarImageItemWidget(
          imagePath: widget.product.images?.first,
        ),
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          if (titleTextController.text.isNotEmpty && codeTextController.text.isNotEmpty) {
            enabledButton.value = true;
          } else {
            enabledButton.value = false;
          }
        },
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: TextFieldEditProductWidget(
                    controller: titleTextController,
                    value: titleTextController.text,
                    title: 'Produto',
                    onValidator: (value) => isNotEmpty(value),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 2,
                  child: TextFieldEditProductWidget(
                    controller: codeTextController,
                    value: codeTextController.text,
                    title: 'Code',
                    onValidator: (value) => isNotEmpty(value, 'Obrigatório'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 4,
                  child: TextFieldEditProductWidget(
                    controller: priceTextController,
                    value: priceTextController.text,
                    title: 'Preço',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 2,
                  child: TextFieldEditProductWidget(
                    controller: quantityTextController,
                    value: quantityTextController.text,
                    title: 'Quantidade',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder<bool>(
              valueListenable: enabledButton,
              builder: (context, state, _) {
                return ElevatedButton(
                  style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 60))),
                  onPressed: !state
                      ? null
                      : () {
                          final isValid = _formKey.currentState?.validate() ?? false;
                          if (isValid) {
                            _formKey.currentState?.reset();
                            updateCubit.update(
                              id: widget.product.id ?? '',
                              name: titleTextController.text,
                              code: int.parse(codeTextController.text),
                              quantity: int.parse(quantityTextController.text),
                              price: priceTextController.text,
                            );
                          }
                        },
                  child: const Text("Salvar alterações"),
                );
              }),
          const SizedBox(width: 16),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Theme.of(context).colorScheme.error,
              )),
              onPressed: () => AppDialogs.showAlertDelete(
                    context,
                    title: 'Atenção!',
                    content: 'Deseja realmente deletar este produto?',
                    onConfirm: () async {
                      await cubit.remove(productId: widget.product.id ?? '').then((_) {
                        Navigator.pop(context);
                        context.go('/home_page');
                      });
                    },
                  ),
              child: SvgPicture.asset(
                AppAssets.delete,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.errorContainer, BlendMode.srcIn),
              )),
        ],
      ),
    );
  }
}

Widget item({required TextEditingController controller, bool readOnly = false, required String value, required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Text(title),
      ),
      const SizedBox(height: 8),
      TextFieldWidget(
        readonly: readOnly,
        controller: controller,
        initialValue: value,
      ),
    ],
  );
}
