import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../login/presentation/widgets/custom_button.dart';
import '../bloc/profile_bloc.dart';

class UpdateProfilePage extends StatefulWidget {
  final AuthData authData;
  const UpdateProfilePage({super.key, required this.authData});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _emailController.text = widget.authData.email;
    _phoneController.text = widget.authData.phone;
    _nameController.text = widget.authData.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editProfile),
      ),
      body: _getContentWidget(),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UpdataProfileSuccess) {
              if (state.authEntity.status != false) {
                FlushbarHelper.createSuccess(message: state.authEntity.message)
                    .show(context);
                BlocProvider.of<ProfileBloc>(context)
                    .add(GetProfileDataEvent());
              } else {
                FlushbarHelper.createError(message: state.authEntity.message)
                    .show(context);
              }
            }
          },
          builder: (context, state) {
            return state is UpdataProfileLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : CustomButtonBuilder(
                    title: AppStrings.save,
                    onTap: () {
                      BlocProvider.of<ProfileBloc>(context).add(
                        UpdataProfileDataEvent(
                          email: _emailController.text.trim(),
                          name: _nameController.text.trim(),
                          phone: _phoneController.text.trim(),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: AppStrings.nameHintText,
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: AppSize.s24),
          TextFormField(
            controller: _emailController,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: AppStrings.emailHintText,
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: AppSize.s24),
          TextFormField(
            controller: _phoneController,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              hintText: AppStrings.passwordHintText,
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
