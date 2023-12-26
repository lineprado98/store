import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store/app/commons/widgets/text_field_widget.dart';
import 'package:store/app/commons/theme/resources/app_assets.dart';
import 'package:store/app/commons/theme/resources/app_validators.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:store/app/features/auth/presenter/cubit/auth_cubit_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppValidatorsMixin {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final ValueNotifier<bool> passwordVisible = ValueNotifier(false);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthCubit, AuthCubitState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
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
                      SvgPicture.asset(
                        AppAssets.svgLogo,
                        height: 100,
                      ),
                      const SizedBox(height: 40),
                      TextFieldWidget(
                        controller: email,
                        hintText: 'E-mail',
                        prefixIcon: SvgPicture.asset(AppAssets.email, height: 20),
                        onValidator: (value) => combineValidations([
                          () => isNotEmpty(value),
                          () => validateEmail(value),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder(
                          valueListenable: passwordVisible,
                          builder: (context, isVisible, _) {
                            return TextFieldWidget(
                              controller: password,
                              hintText: 'Senha',
                              obscureText: isVisible,
                              onValidator: (value) => combineValidations([
                                () => isNotEmpty(value),
                                () => validatePassword(value),
                              ]),
                              prefixIcon: SvgPicture.asset(AppAssets.password, height: 20),
                              suffixIcon: isVisible ? GestureDetector(onTap: () => passwordVisible.value = false, child: SvgPicture.asset(AppAssets.visible, height: 20)) : GestureDetector(onTap: () => passwordVisible.value = true, child: SvgPicture.asset(AppAssets.unvisible, height: 20)),
                            );
                          }),
                      const SizedBox(height: 32),
                      ElevatedButton(
                          style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(MediaQuery.sizeOf(context).width * 0.8, 50))),
                          onPressed: () {
                            final isValid = _formKey.currentState?.validate() ?? false;
                            if (isValid) {
                              _formKey.currentState?.reset();
                              cubit.signin(email: email.text, password: password.text);
                            }
                          },
                          child: const Text('Entrar')),
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surface),
                              fixedSize: MaterialStatePropertyAll(
                                Size(MediaQuery.sizeOf(context).width * 0.7, 50),
                              )),
                          onPressed: () => context.pushNamed('create_account'),
                          child: const Text('Criar uma conta'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
