import 'package:flutter/material.dart';
import '../../../core/services/navigation_service.dart';
import '../../../routes/app_routes.dart';
import '../../order/order_history_screen.dart';
import '../../../core/services/shared_preference_service.dart';
import '../../cart/cart_screen.dart';





class SideMenuTile extends StatefulWidget {
  const SideMenuTile({super.key});

  @override
  State<SideMenuTile> createState() => _SideMenuTileState();
}

class _SideMenuTileState extends State<SideMenuTile> {
  int _selectedIndex = 0;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartItemCount();
  }

  Future<void> _loadCartItemCount() async {
    final cartItems = await SharedPrefService.getCartItems();
    setState(() {
      _cartItemCount = cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMenuTile(
          icon: Icons.person_2_rounded,
          title: 'Profile',
          index: 1,
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
            NavigationService.pushNamed(AppRoutes.profileScreen);
          },
        ),
        _buildMenuTile(
          icon: Icons.location_on_rounded,
          title: 'Address',
          index: 2,

          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
            NavigationService.pushNamed(AppRoutes.orderHistoryScreen);
          },
        ),
        _buildMenuTile(
          icon: Icons.shopping_bag_rounded,
          title: 'Orders',
          index: 3,
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderHistoryScreen()));
          },
        ),
        _buildMenuTile(
          icon: Icons.favorite_rounded,
          title: 'Wishlist',
          index: 4,
          badgeCount: 3,
          onTap: () {
            setState(() {
              _selectedIndex = 4;
            });
            NavigationService.pushNamed(AppRoutes.wishlistScreen);
          },
        ),
        _buildMenuTile(
          icon: Icons.shopping_cart_rounded,
          title: 'Cart',
          index: 5,
          badgeCount: _cartItemCount,

          onTap: () {
            setState(() {
              _selectedIndex = 5;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            ).then((_) {

              _loadCartItemCount();
            });
          },
        ),
        _buildMenuTile(
          icon: Icons.settings_rounded,
          title: 'Settings',
          index: 6,
          onTap: () {
            setState(() {
              _selectedIndex = 6;
            });
          },
        ),
        _buildMenuTile(
          icon: Icons.logout_rounded,
          title: 'Logout',
          index: 7,
          isLogout: true,
          onTap: () {
            print('Logout tapped');
          },
        ),
      ],
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required int index,
    required VoidCallback onTap,
    int? badgeCount,
    bool isLogout = false,
  }) {
    bool isSelected = _selectedIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xff9775FA), Color(0xff7048D4)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isSelected ? null : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xff9775FA).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: isLogout
              ? Colors.red.withOpacity(0.1)
              : const Color(0xff9775FA).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withOpacity(0.2)
                        : isLogout
                        ? Colors.red.withOpacity(0.1)
                        : const Color(0xff9775FA).withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white.withOpacity(0.3))
                        : null,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? Colors.white
                        : isLogout
                        ? Colors.red
                        : const Color(0xff9775FA),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : isLogout
                          ? Colors.red
                          : Colors.black87,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),

                // Badge or Arrow
                if (badgeCount != null && badgeCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.9)
                          : const Color(0xFFFF6B6B),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      badgeCount > 99 ? '99+' : badgeCount.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color(0xff9775FA)
                            : Colors.white,
                      ),
                    ),
                  )
                else if (!isSelected && !isLogout)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: isLogout
                        ? Colors.red.withOpacity(0.6)
                        : Colors.grey.shade400,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
