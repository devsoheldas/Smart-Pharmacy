import 'package:flutter/material.dart';

import '../../../core/models/product_models.dart';
import '../../../core/services/api_caller.dart';
import '../widgets/drawer_section_header.dart';
import '../widgets/info_card.dart';
import '../widgets/product_card.dart';
import '../widgets/side_menu_tile.dart';
import 'view_product_details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductService _productService = ProductService();
  Products? _products;
  bool _productInProgress = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      setState(() {
        _productInProgress = true;
        _errorMessage = '';
      });

      final products = await _productService.getProducts();
      setState(() {
        _products = products;
        _productInProgress = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        _productInProgress = false;
        _errorMessage = 'Failed to load products: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: buildDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  buildHeaderSection(),
                  buildBrandSection(),
                  buildNewArrivalSection(),
                  buildProductGrid(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer
  Drawer buildDrawer() {
    return Drawer(
      width: 300,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const InfoCard(name: 'Example', email: 'example@gmail.com'),
            const DrawerSectionHeader(title: "Browse"),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: const [
                    SideMenuTile(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Sliver AppBar
  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Drawer Button
            GestureDetector(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F6FA),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.menu_rounded,
                    color: Color(0xff9775FA),
                    size: 22,
                  ),
                ),
              ),
            ),

            // Notification Button
            GestureDetector(
              onTap: () {

              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F6FA),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("https://i.pinimg.com/736x/50/f2/91/50f2915c4f23c9643efb1c8f05020f2b.jpg"),
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Section
  Widget buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              text: 'Hello! User ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Welcome to E-pharma!',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          buildSearchBar(),
        ],
      ),
    );
  }

  // Search Bar
  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xffF5F6FA),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.search_rounded, color: Color(0xff9775FA), size: 22),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products, brands...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff9775FA), Color(0xff7048D4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff9775FA).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.filter_list_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  //cattegories
  Widget buildBrandSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Choose Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff9775FA).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xff9775FA),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryButton('Food', Icons.fastfood_rounded),
                _buildCategoryButton('Cosmetics', Icons.face_retouching_natural_rounded),
                _buildCategoryButton('Electronics', Icons.electrical_services_rounded),
                _buildCategoryButton('Fashion', Icons.shopping_bag_rounded),
                _buildCategoryButton('Home', Icons.home_rounded),
                _buildCategoryButton('Sports', Icons.sports_basketball_rounded),
                _buildCategoryButton('Books', Icons.menu_book_rounded),
                _buildCategoryButton('Toys', Icons.toys_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Category Button
  Widget _buildCategoryButton(String name, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xff9775FA).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xff9775FA),
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  //Arrival
  Widget buildNewArrivalSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'New Arrival',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff9775FA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xff9775FA),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xff9775FA),
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Product Grid
  Widget buildProductGrid() {
    if (_productInProgress) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              CircularProgressIndicator(
                color: const Color(0xff9775FA),
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              const Text(
                'Loading products...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loadProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9775FA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (_products?.products == null || _products!.products!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.inventory_2_outlined,
                color: Colors.grey.shade400,
                size: 60,
              ),
              const SizedBox(height: 16),
              const Text(
                'No products found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for new arrivals',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          childAspectRatio: 0.60,
        ),
        itemCount: _products!.products!.length,
        itemBuilder: (context, index) {
          final product = _products!.products![index];
          double regularPrice = product.price ?? 0;
          double discountPercentage = product.discountPercentage ?? 0;
          double discountedPrice = regularPrice;

          if (discountPercentage > 0) {
            discountedPrice = regularPrice - (regularPrice * discountPercentage / 100);
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewProductDetails(product: product),
                ),
              );
            },
            child: ProductCard(
              image: product.thumbnail ?? '',
              name: product.title ?? 'No Name',
              price: discountedPrice,
              regularPrice: regularPrice,
              rating: product.rating ?? 0,
            ),
          );
        },
      ),
    );
  }


}