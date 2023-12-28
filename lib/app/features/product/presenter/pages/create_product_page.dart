import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/theme/resources/app_validators.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit.dart';
import 'package:store/app/features/product/presenter/cubit/create_product/create_cubit_state.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> with AppValidatorsMixin {
  final titleTextController = TextEditingController();
  final codeTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final quantityTextController = TextEditingController();
  final ValueNotifier<XFile?> image = ValueNotifier(null);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateProductCubit>(context);

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
      body: BlocBuilder<CreateProductCubit, CreateProductCubitState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is CreateProductLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  Stack(
                    fit: StackFit.passthrough,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: image,
                          builder: (context, state, _) {
                            return Container(
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
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: state != null
                                    ? DecorationImage(
                                        image: FileImage(File(state.path)),
                                        fit: BoxFit.fitWidth,
                                      )
                                    : DecorationImage(
                                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryContainer, BlendMode.srcATop),
                                        image: const AssetImage(AppAssets.defaultImage),
                                        fit: BoxFit.none,
                                      ),
                              ),
                            );
                          }),
                      Positioned(
                          bottom: 16,
                          right: 16,
                          child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                              )),
                              onPressed: () async {
                                image.value = await cubit.selectImages();
                              },
                              icon: const Icon(Icons.add_a_photo),
                              label: const Text("Adicionar")))
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
                          textErrorColor: Theme.of(context).colorScheme.error,
                          onValidator: (value) => isNotEmpty(value),
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
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    controller: codeTextController,
                    hintText: "Código do produto",
                    keyboardType: TextInputType.number,
                    onValidator: (value) => isNotEmpty(value),
                    textErrorColor: Theme.of(context).colorScheme.error,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            final isValid = _formKey.currentState?.validate() ?? false;
            if (isValid) {
              _formKey.currentState?.reset();
              cubit.create(
                imagePath: image.value?.path,
                name: titleTextController.text,
                code: int.parse(codeTextController.text),
                quantity: int.parse(quantityTextController.text),
                price: priceTextController.text,
              );
            }
          },
          child: const Text("Adicionar produto")),
    );
  }
}
