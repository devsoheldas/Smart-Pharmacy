import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_asset_paths.dart';
import '../../../core/models/pruduct_details_model.dart';
import '../../../core/services/network/api_service.dart';
import '../../home/widgets/product_card.dart';
import '../../home/widgets/simillar_product_card.dart';

class ViewProductDetails extends StatefulWidget {
  final String productSlug;

  const ViewProductDetails({super.key, required this.productSlug});

  @override
  State<ViewProductDetails> createState() => _ViewProductDetailsState();
}

class _ViewProductDetailsState extends State<ViewProductDetails> {
  final ApiService _apiService = ApiService();
  bool _isFavorite = false;
  int _currentImageIndex = 0;
  bool _isLoading = true;
  String? _errorMessage;
  ProductDetailsInfo? _product;
  List<SimilarProduct> _similarProducts = [];

  // Checkout state
  int _quantity = 1;
  ProductDetailsUnit? _selectedUnit;
  double _selectedUnitPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _apiService.getProductDetailsBySlug(widget.productSlug);

    if (!mounted) return;

    if (response.success && response.data?.data?.productDetails != null) {
      setState(() {
        _product = response.data!.data!.productDetails;
        _similarProducts = response.data!.data!.similarProducts;
        _isLoading = false;

        // Initialize selected unit
        if (_product!.units.isNotEmpty) {
          _selectedUnit = _product!.units.first;
          _updateUnitPrice(_selectedUnit!);
        }
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = response.message.isNotEmpty ? response.message : 'Unable to load product details';
      });
    }
  }

  String _stripHtmlTags(String htmlString) {
    final regex = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlString.replaceAll(regex, '').trim();
  }

  void _updateQuantity(int change) {
    setState(() {
      _quantity += change;
      if (_quantity < 1) _quantity = 1;
      if (_quantity > (_product?.maxQuantity ?? 999)) {
        _quantity = _product?.maxQuantity ?? 999;
      }
    });
  }

  void _updateUnitPrice(ProductDetailsUnit unit) {
    if (unit.pivot?.price != null) {
      _selectedUnitPrice = double.tryParse(unit.pivot!.price!) ?? 0.0;
    } else if (_product!.discountedPrice != null) {
      _selectedUnitPrice = _product!.discountedPrice!;
    } else if (_product!.price != null) {
      _selectedUnitPrice = _product!.price!;
    } else {
      _selectedUnitPrice = 0.0;
    }
  }

  void _onUnitChanged(ProductDetailsUnit? unit) {
    if (unit != null) {
      setState(() {
        _selectedUnit = unit;
        _updateUnitPrice(unit);
      });
    }
  }

  void _addToCart() async {
    if (_product == null || _selectedUnit == null) return;

    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0xff9775FA)),
      ),
    );

    final response = await _apiService.addToCart(
      productSlug: widget.productSlug,
      unitId: _selectedUnit!.id!,
      quantity: _quantity,
    );

    if (!mounted) return;
    Navigator.pop(context); // Remove loading dialog

    if (response.success) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xff9775FA),
          content: Text(response.message),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(response.message),
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _buyNow() {
    // TODO: Implement buy now
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buy Now functionality coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: _product != null ? _buildCheckoutSection() : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) return _buildLoading();
    if (_errorMessage != null) return _buildError();
    if (_product == null) return _buildNotFound();

    return RefreshIndicator(
      color: const Color(0xff9775FA),
      onRefresh: _fetchProductDetails,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(),
                _buildProductContent(),
                if (_similarProducts.isNotEmpty) _buildSimilarProducts(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    final totalPrice = _selectedUnitPrice * _quantity;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_product!.units.length > 1) ...[
            _buildUnitSelector(),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              // Quantity
              _buildQuantitySelector(),
              const SizedBox(width: 12),
              // Price
              Expanded(child: _buildPriceDisplay(totalPrice)),
            ],
          ),
          const SizedBox(height: 12),
          // Buttons
          Row(
            children: [
              _buildAddToCartButton(),
              const SizedBox(width: 12),
              _buildBuyNowButton(),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildUnitSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Pack', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xffF5F6FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButton<ProductDetailsUnit>(
            value: _selectedUnit,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xff9775FA)),
            items: _product!.units.map((unit) {
              double unitPrice = _calculateUnitPrice(unit);
              return DropdownMenuItem<ProductDetailsUnit>(
                value: unit,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(unit.formattedName ?? unit.name ?? 'Unit', style: const TextStyle(fontWeight: FontWeight.w500)),
                    Text('৳${unitPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, color: Color(0xff9775FA))),
                  ],
                ),
              );
            }).toList(),
            onChanged: _onUnitChanged,
          ),
        ),
      ],
    );
  }

  double _calculateUnitPrice(ProductDetailsUnit unit) {
    if (unit.pivot?.price != null) return double.tryParse(unit.pivot!.price!) ?? 0.0;
    if (_product!.discountedPrice != null) return _product!.discountedPrice!;
    if (_product!.price != null) return _product!.price!;
    return 0.0;
  }

  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF5F6FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () => _updateQuantity(-1),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
          Container(
            width: 40,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(_quantity.toString(), textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () => _updateQuantity(1),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay(double totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total: ৳${totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff9775FA))),
        if (_selectedUnit != null)
          Text('${_selectedUnit!.name ?? ''} • ৳${_selectedUnitPrice.toStringAsFixed(2)} each',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return Expanded(
      child: OutlinedButton(
        onPressed: _addToCart,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Color(0xff9775FA)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Add to Cart', style: TextStyle(color: Color(0xff9775FA), fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildBuyNowButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: _buyNow,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff9775FA),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Buy Now', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator(color: Color(0xff9775FA)));
  }

  Widget _buildError() {
    return _buildMessage(
      icon: Icons.error_outline_rounded,
      title: 'Something went wrong',
      message: _errorMessage!,
      actionLabel: 'Try Again',
      onAction: _fetchProductDetails,
    );
  }

  Widget _buildNotFound() {
    return _buildMessage(
      icon: Icons.inventory_2_outlined,
      title: 'Product not found',
      message: 'We could not find the product info',
      actionLabel: 'Back',
      onAction: () => Navigator.pop(context),
    );
  }

  Widget _buildMessage({required IconData icon, required String title, required String message, required String actionLabel, required VoidCallback onAction}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Colors.grey.shade500),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(message, style: TextStyle(color: Colors.grey.shade600), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff9775FA),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCircleButton(icon: Icons.arrow_back_rounded, onTap: () => Navigator.pop(context)),
            _buildCircleButton(
              icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
              iconColor: _isFavorite ? Colors.red : const Color(0xff9775FA),
              onTap: () => setState(() => _isFavorite = !_isFavorite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap, Color iconColor = const Color(0xff9775FA)}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xffF5F6FA),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8)],
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }

  Widget _buildImageCarousel() {
    final images = _collectImages();

    if (images.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.asset(AssetPaths.Placeholder, height: 280, width: double.infinity, fit: BoxFit.cover),
        ),
      );
    }

    return Column(
      children: [
        CarouselSlider(
          items: images.map((imageUrl) => _buildCarouselItem(imageUrl)).toList(),
          options: CarouselOptions(
            height: 320,
            viewportFraction: 0.88,
            enlargeCenterPage: true,
            enableInfiniteScroll: images.length > 1,
            autoPlay: images.length > 1,
            onPageChanged: (index, reason) => setState(() => _currentImageIndex = index),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(images.length, (index) => Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentImageIndex == index ? const Color(0xff9775FA) : Colors.grey[300],
            ),
          )),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCarouselItem(String imageUrl) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Color(0xff9775FA), strokeWidth: 2)),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade200,
            child: const Icon(Icons.broken_image_rounded, size: 48, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildProductContent() {
    final product = _product!;
    final discountedPrice = product.discountedPrice ?? product.price ?? 0;
    final regularPrice = product.price ?? discountedPrice;
    final discountPercentage = product.discountPercentage?.toDouble() ?? 0;
    final descriptionText = product.description?.trim().isNotEmpty == true ? _stripHtmlTags(product.description!) : 'Description not found.';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (product.company?.name != null) _buildInfoChip(product.company!.name!, const Color(0xff9775FA)),
              if (product.proCat?.name != null) ...[
                const SizedBox(width: 8),
                _buildInfoChip(product.proCat!.name!, Colors.grey.shade600),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(product.name ?? 'Untitled Product', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildPriceRow(discountedPrice, regularPrice, discountPercentage),
          const SizedBox(height: 24),
          _buildDescription(descriptionText),
          const SizedBox(height: 24),
          _buildProductDetails(),
          if (product.units.isNotEmpty) _buildAvailablePacks(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPriceRow(double discountedPrice, double regularPrice, double discountPercentage) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('৳${discountedPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Color(0xff9775FA))),
        if (discountPercentage > 0 && regularPrice > discountedPrice) ...[
          const SizedBox(width: 10),
          Text('৳${regularPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: Colors.grey.shade500, decoration: TextDecoration.lineThrough)),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
            child: Text('${discountPercentage.toStringAsFixed(0)}% OFF', style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(description, style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.6)),
      ],
    );
  }

  Widget _buildProductDetails() {
    final product = _product!;
    final details = <String, String?>{};

    void addDetail(String key, String? value) {
      if (value != null && value.trim().isNotEmpty) details[key] = value;
    }

    addDetail('Category', product.proCat?.name);
    addDetail('Company', product.company?.name);
    addDetail('Generic', product.generic?.name);
    addDetail('Strength', product.strength?.name);
    addDetail('Dosage', product.dosage?.name);
    addDetail('Slug', product.slug);

    if (details.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...details.entries.map((entry) => _buildDetailItem(entry.key, entry.value!)),
      ],
    );
  }

  Widget _buildAvailablePacks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text('Available Packs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _product!.units.map((unit) => Chip(
            label: Text(unit.formattedName ?? unit.name ?? 'Unit', style: const TextStyle(fontWeight: FontWeight.w500)),
            backgroundColor: const Color(0xffF5F6FA),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14))),
          const SizedBox(width: 16),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildSimilarProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Similar Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 310,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _similarProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = _similarProducts[index];
                final imageUrl = _pickImage(product.image, product.modifiedImage, product.units);
                final discountedPrice = product.discountedPrice ?? product.price ?? 0;
                final regularPrice = product.price ?? discountedPrice;
                final discountPercentage = product.discountPercentage?.toDouble() ?? 0;

                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewProductDetails(productSlug: product.slug ?? widget.productSlug),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 180,
                    child: SimillarProductCard(
                      image: imageUrl,
                      name: product.name ?? 'Untitled',
                      price: discountedPrice,
                      regularPrice: regularPrice,
                      rating: 4.5,
                      discountPercentage: discountPercentage,
                      productId: product.id ?? 0,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> _collectImages() {
    final images = <String>{};
    final product = _product!;

    void addImage(String? url) {
      if (url != null && url.trim().isNotEmpty) images.add(url);
    }

    addImage(product.modifiedImage);
    addImage(product.image);
    for (final unit in product.units) {
      addImage(unit.image);
    }

    return images.toList();
  }

  String _pickImage(String? primary, String? fallback, List<SimilarProductUnit> units) {
    if (primary != null && primary.trim().isNotEmpty) return primary;
    if (fallback != null && fallback.trim().isNotEmpty) return fallback;
    for (final unit in units) {
      if (unit.image != null && unit.image!.trim().isNotEmpty) return unit.image!;
    }
    return 'https://i.ibb.co/Vv5VY7S/placeholder.jpg';
  }
}