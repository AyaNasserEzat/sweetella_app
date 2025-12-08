import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/profile/presentation/screens/widgets/profile_header.dart';
import 'package:sweetella/feature/profile/presentation/screens/widgets/profile_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarTitle(title: "My Profile"),
            const SizedBox(height: 10),
            ProfileHeader(),
            const SizedBox(height: 30),
            // Options List
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                spacing: 4,
                children: [
                  buildProfileOption(
                    icon: Icons.shopping_bag,
                    title: 'My Orders',
                    onTap: () {
                      // Navigate to orders
                    },
                  ),
                  Divider(height: 1, color: Colors.grey.shade300),
                  buildProfileOption(
                    icon: Icons.favorite,
                    title: 'Favorites',
                    onTap: () {
                      // Navigate to favorites
                    },
                  ),
                  const Divider(height: 1),
                  buildProfileOption(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // Navigate to settings
                    },
                  ),
                  const Divider(height: 1),
                  buildProfileOption(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      // Logout functionality
                    },
                  ),
                  const Divider(height: 1),
                  buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      // Logout functionality
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
