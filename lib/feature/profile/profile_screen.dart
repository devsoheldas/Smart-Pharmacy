import 'dart:io';
import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:e_pharma/feature/order/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/services/navigation_service.dart';
import '../../routes/app_routes.dart';
import 'edit_profile_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                // SPACE FOR BACK BUTTON
                const SliverToBoxAdapter(
                  child: SizedBox(height: 70),
                ),

                // =========================
                //    PROFILE HEADER
                // =========================
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF667eea),
                          Color(0xFF764ba2),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667eea).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -50,
                          right: -50,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          left: -30,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              // Profile Row
                              Row(
                                children: [
                                  // Profile Image
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: const LinearGradient(
                                            colors: [Colors.white, Colors.white70],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 15,
                                              offset: const Offset(0, 5),
                                            )
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: AppColors.whiteColor,
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/profile_pic.png',
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) {
                                                return const Icon(
                                                  Icons.person_rounded,
                                                  size: 45,
                                                  color: Color(0xFF667eea),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => EditProfilePage(
                                                  currentName: "SOHEL DAS",
                                                  currentEmail:
                                                  "soheldas3210@gmail.com",
                                                  onImageSelected: (file) {},
                                                  onSave: (name, email) {},
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: AppColors.greyLight,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors.whiteColor,
                                                  width: 2.5),
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 20),

                                  // Name + Email
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'SOHEL DAS',
                                          style: TextStyle(
                                            color: AppColors.whiteColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.email_outlined,
                                              color: Colors.white.withOpacity(0.9),
                                              size: 16,
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Text(
                                                'soheldas3210@gmail.com',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Stats
                              Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildQuickStat(
                                        '12', 'Orders', Icons.shopping_bag_outlined),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildQuickStat(
                                        '48', 'Wishlist', Icons.favorite_outline),
                                    Container(
                                      width: 1,
                                      height: 40,
                                      color: Colors.white.withOpacity(0.3),
                                    ),
                                    _buildQuickStat(
                                        '5', 'Cart', Icons.add_shopping_cart),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // =============== MENU OPTIONS ===============
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([

                      _buildMenuOption(
                        icon: Icons.details,
                        title: 'Profile Details ',
                        subtitle: 'Details about your account',
                        color: const Color(0xFF6B7280),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                        onTap: () {},
                      ),
                      _buildMenuOption(
                        icon: Icons.password_outlined,
                        title: 'Change Password',
                        subtitle: 'Change your password',
                        color: const Color(0xFFF59E0B),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                        ),
                        onTap: () {},
                      ),

                      _buildMenuOption(
                        icon: Icons.shopping_bag_rounded,
                        title: 'My Orders',
                        subtitle: 'View your order history',
                        color: const Color(0xFF3B82F6),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const OrderHistoryScreen()));
                        },
                      ),

                      _buildMenuOption(
                        icon: Icons.location_on_rounded,
                        title: 'Address',
                        subtitle: 'Manage shipping address',
                        color: const Color(0xFF10B981),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                        onTap: () {},
                      ),

                      _buildMenuOption(
                        icon: Icons.local_activity_rounded,
                        title: 'Wishlist',
                        subtitle: 'Your saved items',
                        color: const Color(0xFFF59E0B),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                        ),
                        onTap: () {
                          NavigationService.pushNamed(AppRoutes.wishlistScreen);
                        },
                      ),

                      _buildMenuOption(
                        icon: Icons.notifications_rounded,
                        title: 'Notifications',
                        subtitle: 'Manage notifications',
                        color: const Color(0xFF8B5CF6),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                        ),
                        onTap: () {},
                      ),

                      _buildMenuOption(
                        icon: Icons.settings_rounded,
                        title: 'Settings',
                        subtitle: 'App preferences',
                        color: const Color(0xFF6B7280),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
                        ),
                        onTap: () {},
                      ),

                      _buildMenuOption(
                        icon: Icons.help_rounded,
                        title: 'Help & Support',
                        subtitle: 'Get help',
                        color: const Color(0xFF14B8A6),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                        ),
                        onTap: () {},
                      ),

                      const SizedBox(height: 24),

                      _buildLogoutButton(
                        context,
                        icon: Icons.logout,
                        title: "Logout",
                        subtitle: "Sign out from your account",
                        onTap: () => _showLogoutDialog(context),
                      ),

                      const SizedBox(height: 32),
                    ]),
                  ),
                ),
              ],
            ),

            // ======================
            // FLOATING BACK BUTTON
            // ======================
            Positioned(
              top: 16,
              left: 16,
              child: _buildBackButton(context),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- BACK BUTTON ----------------
  Widget _buildBackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- QUICK STAT ----------------
  Widget _buildQuickStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---------------- MENU OPTION ----------------
  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LOGOUT BUTTON ----------------
  Widget _buildLogoutButton(BuildContext context, {
    required IconData icon,
    required String subtitle,
    required String title,
    required VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF97316)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Are you sure you want to logout and exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(ctx);
                _exitApp();
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  void _exitApp() {
    exit(0);
  }
}