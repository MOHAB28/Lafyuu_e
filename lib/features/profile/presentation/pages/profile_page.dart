import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/features/profile/presentation/pages/update_profile_page.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../login/domain/entities/login_entity.dart';
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
        builder: (context, snapshot) {
          var bloc = ProfileBloc.get(context);
          return bloc.authData != null
              ? bloc.authData!.status == false
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: Text(bloc.authData!.message),
                      ),
                    )
                  : _getContentWidget(bloc.authData!)
              : SizedBox(
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
      ],
    );
  }
}
