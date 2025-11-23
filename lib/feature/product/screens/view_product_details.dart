import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../core/models/cart_model.dart';
import '../../../core/models/product_models.dart';
import '../../../core/services/shared_preference_service.dart';


class ViewProductDetails extends StatefulWidget {
  final Product product;

  const ViewProductDetails({super.key, required this.product});

  @override
  State<ViewProductDetails> createState() => _ViewProductDetailsState();
}

class _ViewProductDetailsState extends State<ViewProductDetails> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    double regularPrice = product.price ?? 0;
    double discountPercentage = product.discountPercentage ?? 0;
    double discountedPrice = discountPercentage > 0
        ? regularPrice - (regularPrice * discountPercentage / 100)
        : regularPrice;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App and favorite
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F6FA),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Color(0xff9775FA)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xffF5F6FA),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Color(0xff9775FA),
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorite = !_isFavorite;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            // Image
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: [
                      if (product.thumbnail != null) product.thumbnail!,
                      ...?product.images,
                    ].map((imageUrl) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported, size: 50),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < (product.images?.length ?? 1); i++)
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == i
                                ? const Color(0xff9775FA)
                                : Colors.grey[300],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),


            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        if (product.brand != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xff9775FA).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.brand!,
                              style: const TextStyle(
                                color: Color(0xff9775FA),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        const SizedBox(width: 8),
                        if (product.category != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.category!.name,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),


                    Text(
                      product.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),


                    Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.rating ?? 0}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: (product.stock ?? 0) > 10
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            (product.stock ?? 0) > 10 ? 'In Stock' : 'Stock Out',
                            style: TextStyle(
                              color: (product.stock ?? 0) > 10 ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),


                    Row(
                      children: [
                        Text(
                          '\$${discountedPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff9775FA),
                          ),
                        ),
                        if (discountPercentage > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                            '\$${regularPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${discountPercentage.toStringAsFixed(1)}% OFF',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),


                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description ?? 'No description available',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _buildDetailSection('Product Details', [
                      if (product.sku != null) _buildDetailItem('SKU', product.sku!),
                      if (product.weight != null) _buildDetailItem('Weight', '${product.weight}g'),
                      if (product.dimensions != null)
                        _buildDetailItem('Dimensions', '${product.dimensions!.width} x ${product.dimensions!.height} x ${product.dimensions!.depth} cm'),
                      if (product.warrantyInformation != null)
                        _buildDetailItem('Warranty', product.warrantyInformation!),
                      if (product.shippingInformation != null)
                        _buildDetailItem('Shipping', product.shippingInformation!),
                    ]),


                    const SizedBox(height: 24),
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_quantity > 1) {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: _quantity > 1 ? const Color(0xff9775FA) : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.remove,
                                color: _quantity > 1 ? Colors.white : Colors.grey.shade500,
                                size: 18,
                              ),
                            ),
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Color(0xff9775FA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),


      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${(discountedPrice * _quantity).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff9775FA),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                height: 56,
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
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {

                      _showAddToCartSuccess();
                    },
                    child: const Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartSuccess() async {
    final product = widget.product;
    double regularPrice = product.price ?? 0;
    double discountPercentage = product.discountPercentage ?? 0;
    double discountedPrice = discountPercentage > 0
        ? regularPrice - (regularPrice * discountPercentage / 100)
        : regularPrice;


    CartItem cartItem = CartItem(
      productId: product.id!,
      title: product.title ?? 'No Name',
      thumbnail: product.thumbnail ?? '',
      price: discountedPrice,
      regularPrice: regularPrice,
      discountPercentage: discountPercentage,
      quantity: _quantity,
    );


    List<Map<String, dynamic>> existingItems = await SharedPrefService.getCartItems();


    bool productExists = false;
    for (int i = 0; i < existingItems.length; i++) {
      if (existingItems[i]['productId'] == product.id) {

        existingItems[i]['quantity'] += _quantity;
        productExists = true;
        break;
      }
    }


    if (!productExists) {
      existingItems.add(cartItem.toMap());
    }


    await SharedPrefService.saveCartItems(existingItems);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xff9775FA),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Product added to cart successfully!'),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}