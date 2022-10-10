import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/presentation/widgets/failure_handler_item_builder.dart';
import 'update_profile_page.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../injection_container.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../login/presentation/pages/login/login_page.dart';
import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    if (ProfileBloc.get(context).authData == null) {
      BlocProvider.of<ProfileBloc>(context).add(GetProfileDataEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppPadding.p16),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          var bloc = ProfileBloc.get(context);
          if (state is GetProfileDataLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is GetProfileDataSuccess) {
            if (bloc.authData != null) {
              if (bloc.authData!.status == false) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Text(bloc.authData!.message),
                  ),
                );
              } else {
                return _getContentWidget(bloc.authData!);
              }
            }
          } else if (state is GetProfileDataFailure) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: FailureHandlerItemBuilder(
                title: state.exception.error,
                message: state.exception.message,
                onTap: () {
                  ProfileBloc.get(context).add(GetProfileDataEvent());
                },
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget _getContentWidget(AuthEntity authData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: AppSize.s50,
              backgroundImage: NetworkImage(authData.authData.image),
            ),
            const SizedBox(width: AppSize.s16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authData.authData.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorManager.dark),
                ),
                const SizedBox(height: AppSize.s20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text(AppStrings.editProfile),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => UpdateProfilePage(
                          authData: authData.authData,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSize.s32),
        ListTile(
          leading: const Icon(Icons.email_outlined),
          title: const Text(AppStrings.email),
          trailing: Text(
            authData.authData.email,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.phone_iphone_sharp),
          title: const Text(AppStrings.phonNumber),
          trailing: Text(
            authData.authData.phone,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.loginPageKey);
            sl<SharedPreferences>().remove(tokenKey);
          },
          trailing: const Icon(Icons.logout),
          title: const Text(AppStrings.logout),
        ),
      ],
    );
  }
}
