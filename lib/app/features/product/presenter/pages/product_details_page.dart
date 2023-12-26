import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/widgets/app_bar_image_item_widget.dart';
import 'package:store/app/commons/widgets/app_dialogs.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/features/product/domain/entities/product_entity.dart';
import 'package:store/app/features/product/presenter/cubit/products_cubit.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final titleTextController = TextEditingController();
  final idTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleTextController.text = widget.product.name;
    idTextController.text = widget.product.code.toString();
    priceTextController.text = widget.product.price.toString();
    quantityTextController.text = widget.product.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProductsCubit>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400),
        child: AppBarImageItemWidget(
          imagePath: widget.product.images?.first,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Flexible(
                flex: 3,
                child: item(
                  controller: titleTextController,
                  value: titleTextController.text,
                  title: 'Produto',
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: item(
                  controller: idTextController,
                  value: idTextController.text,
                  readOnly: true,
                  title: 'ID',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: item(
                  controller: priceTextController,
                  value: priceTextController.text,
                  title: 'Preço',
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: item(
                  controller: quantityTextController,
                  value: quantityTextController.text,
                  title: 'Quantidade',
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 60))), onPressed: () {}, child: const Text("Salvar alterações")),
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
                    onConfirm: () {
                      cubit.remove(productId: widget.product.id ?? '');
                      Navigator.pop(context);
                      context.go('/home_page');
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
