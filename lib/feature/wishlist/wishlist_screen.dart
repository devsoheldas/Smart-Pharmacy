import 'package:flutter/material.dart';
import '../../core/models/wishlist_model.dart';
import '../../core/services/network/api_service.dart';
import '../product/widgets/product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlisstScreenState();
}

class _WishlisstScreenState extends State<WishlistScreen> {

  final ApiService _apiService = ApiService();
  List<Wish> wishlistItems  = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  void _loadWishlist() async {

    try {

      setState(() {
         isLoading = true;
         errorMessage = null;
       });

      final response = await _apiService.getWishlist();
      setState(() {
        if (response.success) {
            isLoading = false;
          wishlistItems = response.data?.data?.wishes ?? [];
        } else {
         errorMessage = response.message;
          debugPrint("Error:${response.message}");
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
    });
      print("Failed to load wishlist: $e");
    }
  }



  // void _onAddToWishlist(int productId) async {
  //   try {
  //     Wish newWish = await _apiService.addToWishlist(productId);
  //
  //     setState(() {
  //       wishlistItems.add(newWish);
  //     });
  //   } catch (e) {
  //     print('Add wishlist error: $e');
  //   }
  // }
  //
  // void _onWishlistToggle(Wish wish) async {
  //   int newStatus = (wish.status == 1) ? 0 : 1;
  //
  //   try {
  //     Wish updatedWish = await _apiService.updataToWishList(wish.id!, newStatus);
  //
  //     setState(() {
  //       int index = wishlistItems.indexWhere((w) => w.id == wish.id);
  //       if (index != -1) {
  //         wishlistItems[index] = updatedWish;
  //       }
  //     });
  //   } catch (e) {
  //     print('Update wishlist error: $e');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist"),
        centerTitle: true,
      ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child:  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : errorMessage != null
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          errorMessage!,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadWishlist,
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  )
                      :  wishlistItems.isEmpty
                ? const Center(
              child: Text(
                "No items in wishlist",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
                : GridView.builder(
              itemCount: wishlistItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final wish = wishlistItems[index];

                // Skip invalid / deleted product
                if (wish.product == null) {
                  return const SizedBox.shrink();
                }

                final product = wish.product!;

                return ProductCard(
                  productId: product.id ?? 0,
                  image: product.modifiedImage ?? product.image ?? '',
                  name: product.name ?? 'No Name',
                  price: product.discountedPrice?.toDouble() ??
                      product.price?.toDouble() ??
                      0,
                  regularPrice: product.price?.toDouble() ?? 0,
                  rating: 4.5,
                  isInWishlist: wish.status == 1,
                  onWishlistToggle: () {
                    // Function add/Remove
                  },
                );
              },
            )
            ,
          )

      );
  }
}
