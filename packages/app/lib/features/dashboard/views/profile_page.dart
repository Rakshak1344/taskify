import 'package:app/features/auth/views/state/user_state.dart';
import 'package:app/navigation/app_route_name.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  void watchAuthState() {
    ref.listen(userStateProvider, (prev, next) {
      if (next.hasValue && next.value == null) {
        context.goNamed(AppRouteName.auth.loginSignUp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildProfileListTile(),
          SizedBox(height: 12),
          ref
              .watch(userStateProvider)
              .maybeWhen(
                loading: context.buildLoadingIndicator,
                orElse: buildLogoutButton,
              ),
        ],
      ),
    );
  }

  Widget buildProfileListTile() {
    var user = ref.watch(userStateProvider).valueOrNull;

    if (user == null) {
      return ListTile(
        visualDensity: VisualDensity.comfortable,
        leading: CircleAvatar(child: Icon(Icons.person_outline_rounded)),
        title: Text("Invalid User"),
      );
    }

    return ListTile(
      visualDensity: VisualDensity.comfortable,
      leading: CircleAvatar(
        backgroundImage:
            user.photoUrl != null
                ? CachedNetworkImageProvider(user.photoUrl!)
                : null,
        child: Text(user.displayName.substring(0, 1).toUpperCase()),
      ),
      title: Text(user.displayName),
      subtitle: Text(user.email),
    );
  }

  Widget buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton.icon(
        onPressed: () => ref.read(userStateProvider.notifier).logout(),
        icon: Icon(Icons.logout),
        label: Text("Logout"),
      ),
    );
  }
}
