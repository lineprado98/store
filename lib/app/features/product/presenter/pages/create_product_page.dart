import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final titleTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Adicionar produto",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4), // Deslocamento da sombra
                      ),
                    ],
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryContainer, BlendMode.srcATop),
                      image: const AssetImage(AppAssets.defaultImage),
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Positioned(bottom: 16, right: 16, child: ElevatedButton.icon(style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 4, horizontal: 10))), onPressed: () {}, icon: const Icon(Icons.add_a_photo), label: const Text("Adicionar")))
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextFieldWidget(
                    controller: titleTextController,
                    hintText: "Nome do produto",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextFieldWidget(
                    controller: priceTextController,
                    hintText: "Preço",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  flex: 3,
                  child: TextFieldWidget(
                    controller: quantityTextController,
                    hintText: "Quantidade",
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
      floatingActionButton: ElevatedButton(onPressed: () {}, child: const Text("Adicionar produto")),
    );
  }
}
