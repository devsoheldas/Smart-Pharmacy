import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_pharma/feature/product/screens/view_product_details.dart';
import 'package:flutter/material.dart';
import '../../../core/configs/api_endpoints.dart';
import '../../../core/models/categories_model.dart';
import '../../../core/models/product_models.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/services/network/api_service.dart';
import '../../../routes/app_routes.dart';
import '../widgets/drawer_section_header.dart';
import '../widgets/info_card.dart';
import '../widgets/product_card.dart';
import '../widgets/side_menu_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ApiService _apiService = ApiService();

  Product? _products;
  Categories? _categories;
  bool _productInProgress = true;
  bool _categoryInProgress = true;
  String _errorMessage = '';
  String _categoryErrorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadCategories();
  }

  // Load products from API
  Future<void> _loadProducts() async {
    try {
      setState(() {
        _productInProgress = true;
        _errorMessage = '';
      });

      final response = await _apiService.getProducts();

      if (response.success) {
        setState(() {
          _products = response.data;
          _productInProgress = false;
        });
      } else {
        setState(() {
          _productInProgress = false;
          _errorMessage = response.message;
        });
      }
    } catch (e) {
      setState(() {
        _productInProgress = false;
        _errorMessage = 'Failed to load products';
      });
    }
  }

  // c API
  Future<void> _loadCategories() async {
    try {
      setState(() {
        _categoryInProgress = true;
        _categoryErrorMessage = '';
      });

      final response = await _apiService.get(ApiEndpoints.getCategory);

      if (response.statusCode == 200) {
        final categories = Categories.fromJson(response.data);
        setState(() {
          _categories = categories;
          _categoryInProgress = false;
        });
      } else {
        setState(() {
          _categoryInProgress = false;
          _categoryErrorMessage = 'Failed to load categories';
        });
      }
    } catch (e) {
      setState(() {
        _categoryInProgress = false;
        _categoryErrorMessage = 'Failed to load categories';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _buildDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildHeaderSection(),
                  _buildCategorySection(),
                  _buildNewArrivalSection(),
                  _buildProductGrid(),
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
  Drawer _buildDrawer() {
    return Drawer(
      width: 300,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
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
                child: Column(children: const [SideMenuTile()]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // App Bar
  SliverAppBar _buildSliverAppBar() {
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
            // Menu Button
            _buildCircleButton(
              onTap: () => _scaffoldKey.currentState!.openDrawer(),
              child: const Icon(
                Icons.menu_rounded,
                color: Color(0xff9775FA),
                size: 22,
              ),
            ),

            // Profile Button
            _buildCircleButton(
              onTap: () => NavigationService.pushNamed(AppRoutes.profileScreen),
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/50/f2/91/50f2915c4f23c9643efb1c8f05020f2b.jpg",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // circle button
  Widget _buildCircleButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
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
        child: Center(child: child),
      ),
    );
  }

  // Header
  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello! User',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
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
          _buildSearchBar(),
        ],
      ),
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return Row(
      children: [
        // Search Field
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

        // Filter Button
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

  // Categories Section
  Widget _buildCategorySection() {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
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

          // Categories Content
          if (_categoryInProgress)
            _buildLoadingIndicator(height: 70)
          else if (_categoryErrorMessage.isNotEmpty)
            _buildErrorWidget(message: 'Failed to load categories', height: 70)
          else if (_categories?.data != null && _categories!.data!.isNotEmpty)
            _buildCategoriesList()
          else
            _buildEmptyWidget(message: 'No categories available', height: 70),
        ],
      ),
    );
  }

  // Categories List
  Widget _buildCategoriesList() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _categories!.data!.map((category) {
          return _buildCategoryButton(
            name: category.name ?? 'Unnamed',
            imageUrl: category.image,
          );
        }).toList(),
      ),
    );
  }

  //  Category btn
  Widget _buildCategoryButton({
    required String name,
    required String? imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
            child: (imageUrl != null && imageUrl.isNotEmpty)
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildDefaultIcon(),
                      errorWidget: (context, url, error) => _buildDefaultIcon(),
                    ),
                  )
                : _buildDefaultIcon(),
          ),

          const SizedBox(width: 8),

          // Category Name
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Default icon for categories
  Widget _buildDefaultIcon() {
    return Icon(
      Icons.category_rounded,
      color: const Color(0xff9775FA),
      size: 18,
    );
  }

  // Arrival
  Widget _buildNewArrivalSection() {
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

  // Products Grid
  Widget _buildProductGrid() {
    if (_productInProgress) {
      return _buildLoadingIndicator();
    }

    if (_errorMessage.isNotEmpty) {
      return _buildErrorWidget(message: _errorMessage);
    }

    if (_products?.data == null || _products!.data!.isEmpty) {
      return _buildEmptyWidget(message: 'No products found');
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
        itemCount: _products!.data!.length,
        itemBuilder: (context, index) {
          final product = _products!.data![index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(dynamic product) {
    double regularPrice = product.price ?? 0;
    double discountPercentage = product.discountPercentage?.toDouble() ?? 0;
    double discountedPrice = product.discountedPrice ?? regularPrice;

    // Get product image
    String imageUrl = product.modifiedImage ?? product.image ?? '';
    if (imageUrl.isEmpty &&
        product.units != null &&
        product.units!.isNotEmpty) {
      imageUrl = product.units!.first.image ?? '';
    }
    if (imageUrl.isEmpty) {
      imageUrl =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVYS7KEXYFAwqdRCW81e4DSR_nSLYSFStx1Q&s';
    }

    return GestureDetector(
      onTap: () {
        final slug = product.slug;
        if (slug == null || slug.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product details unavailable')),
          );
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ViewProductDetails(productSlug: slug),
          ),
        );
      },
      child: ProductCard(
        image: imageUrl,
        name: product.name ?? 'No Name',
        price: discountedPrice,
        regularPrice: regularPrice,
        rating: 4.5,
        discountPercentage: discountPercentage,
      ),
    );
  }

  // Reusable loading widget
  Widget _buildLoadingIndicator({double height = 120}) {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xff9775FA),
          strokeWidth: 2,
        ),
      ),
    );
  }

  // Reusable error widget
  Widget _buildErrorWidget({required String message, double height = 200}) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: Colors.red.shade400,
              size: height == 70 ? 24 : 60,
            ),
            const SizedBox(height: 8),
            Text(
              height == 70
                  ? 'Failed to load categories'
                  : 'Oops! Something went wrong',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: height == 70 ? 12 : 16,
              ),
            ),
            if (height != 70) ...[
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _loadProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9775FA),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // empty widget
  Widget _buildEmptyWidget({required String message, double height = 200}) {
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              height == 70
                  ? Icons.category_rounded
                  : Icons.inventory_2_outlined,
              color: Colors.grey.shade400,
              size: height == 70 ? 24 : 60,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: height == 70 ? 14 : 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
