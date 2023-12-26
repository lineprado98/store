import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit_state.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final ValueNotifier<bool> confirmPasswordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthCubit, AuthCubitState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.goNamed('home_page');
          }
        },
        child: BlocBuilder<AuthCubit, AuthCubitState>(
            bloc: BlocProvider.of<AuthCubit>(context),
            builder: (context, state) {
              if (state is AuthErrorState) {
                return const Text('error');
              } else if (state is AuthLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: const Offset(0, 4), // Deslocamento da sombra
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'Informe suas credenciais',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                            ),
                            const SizedBox(height: 40),
                            TextFieldWidget(
                              controller: email,
                              hintText: 'E-mail',
                              prefixIcon: SvgPicture.asset(AppAssets.email, height: 20),
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder(
                                valueListenable: passwordVisible,
                                builder: (context, isVisible, _) {
                                  return TextFieldWidget(
                                    controller: password,
                                    hintText: 'Senha',
                                    obscureText: isVisible,
                                    prefixIcon: SvgPicture.asset(AppAssets.password, height: 20),
                                    suffixIcon: isVisible ? GestureDetector(onTap: () => passwordVisible.value = false, child: SvgPicture.asset(AppAssets.visible, height: 20)) : GestureDetector(onTap: () => passwordVisible.value = true, child: SvgPicture.asset(AppAssets.unvisible, height: 20)),
                                  );
                                }),
                            const SizedBox(height: 16),
                            ValueListenableBuilder(
                                valueListenable: confirmPasswordVisible,
                                builder: (context, isVisible, _) {
                                  return TextFieldWidget(
                                    hintText: 'Confirmação de Senha',
                                    obscureText: isVisible,
                                    prefixIcon: SvgPicture.asset(AppAssets.password, height: 20),
                                    suffixIcon: isVisible ? GestureDetector(onTap: () => confirmPasswordVisible.value = false, child: SvgPicture.asset(AppAssets.visible, height: 20)) : GestureDetector(onTap: () => confirmPasswordVisible.value = true, child: SvgPicture.asset(AppAssets.unvisible, height: 20)),
                                  );
                                }),
                            const SizedBox(height: 32),
                            const Spacer(),
                            ElevatedButton(
                              style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(MediaQuery.sizeOf(context).width * 0.8, 50))),
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).createAccount(email: email.text, password: password.text);
                              },
                              child: const Text('Criar Conta'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
