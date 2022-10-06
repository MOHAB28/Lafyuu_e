import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/network/end_points.dart';
import '../../../../../core/resources/extensions.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/strings_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../injection_container.dart';
import '../../bloc/login_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const String tokenKey = 'set-token';

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: AppSize.s0,
        toolbarHeight: AppSize.s1,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              children: [
                SvgPicture.asset(ImageAssets.logo),
                const SizedBox(height: AppSize.s16),
                Text(
                  AppStrings.welcome,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: AppSize.s8),
                Text(
                  AppStrings.signInToContinue,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: AppSize.s28),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: AppStrings.emailHintText,
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (!value!.isEmailValid()) {
                      return AppStrings.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: AppStrings.passwordHintText,
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (!value!.isPasswordValid()) {
                      return AppStrings.passwordInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s16),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      if (state.data.status != false) {
                        sl<SharedPreferences>()
                            .setString(tokenKey, state.data.authData.token)
                            .then((value) {
                          if (value) {
                            token = sl<SharedPreferences>().getString(tokenKey);
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.layoutPage,
                            );
                          }
                        });
                      } else {
                        FlushbarHelper.createError(message: state.data.message)
                            .show(context);
                      }
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButtonBuilder(
                            title: AppStrings.signIn,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginBloc>(context).add(
                                  UserWantToLogin(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          );
                  },
                ),
                const SizedBox(height: AppSize.s24),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.forgotPassword,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                CustomTextButtonForAuth(
                  title1: AppStrings.donothaveAnAccount,
                  title2: AppStrings.register,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.registerPageKey);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
