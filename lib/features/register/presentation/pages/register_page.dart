import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/resources/extensions.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../injection_container.dart';
import '../../../login/presentation/pages/login/login_page.dart';
import '../../../login/presentation/widgets/custom_button.dart';
import '../../../login/presentation/widgets/custom_text_button.dart';
import '../bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: AppStrings.nameHintText,
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (!value!.isUserNameValid()) {
                      return AppStrings.nameInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s8),
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
                const SizedBox(height: AppSize.s8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: AppStrings.phoneHintText,
                    prefixIcon: Icon(Icons.call_outlined),
                  ),
                  validator: (value) {
                    if (!value!.isMobileNumberValid()) {
                      return AppStrings.phoneInvalid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s16),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
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
                    } else if (state is RegisterFailure) {
                      debugPrint(state.exception.message);
                    }
                  },
                  builder: (context, state) {
                    return state is RegisterLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButtonBuilder(
                            title: AppStrings.signUp,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterBloc>(context).add(
                                  UserWantToRegister(
                                    email: _emailController.text.trim(),
                                    phone: _phoneController.text.trim(),
                                    name: _nameController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ),
                                );
                              }
                            },
                          );
                  },
                ),
                const SizedBox(height: AppSize.s24),
                CustomTextButtonForAuth(
                  title1: AppStrings.haveAnAccount,
                  title2: AppStrings.signIn,
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.loginPageKey,
                    );
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
