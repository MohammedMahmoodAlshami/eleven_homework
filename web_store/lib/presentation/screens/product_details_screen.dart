import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/custom_app_bar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

const ProductDetailsScreen({
  super.key,
  required this.product,
});


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final  isFavorite = favoritesProvider.isFavorite(product);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    Widget coverImage({
      required String url,
      required BoxFit fit,
      double? width,
      double? height,
    }) {
    
      Widget fallback() => ColoredBox(
            color: colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.broken_image_outlined,
              color: colorScheme.outline,
            ),
          );
     
      if (url.trim().startsWith('http')) {
        return Image.network(
          url.trim(),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, _, _) => fallback(),
        );
      }

      return Image.asset(
        url.trim(),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => fallback(),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: product.name, showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //image
            ClipRRect(
              child: SizedBox(
                height: 300,
                width: double.infinity,
                child: coverImage(
                  url: product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),



            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // السعر والقسم
              Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${product.price.toStringAsFixed(0)} ريال',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          product.categoryName,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // اسم المنتج
                  Text(
                    product.name,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 16),
                  // الوصف
                  Text(
                    ': الوصف',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.description,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40),
                  // أزرار الإجراءات
                  Row(
                    children: [
                       // زر إضافة للسلة
                     Expanded(
                        child: 
                        ElevatedButton.icon(
                          onPressed: () {
                            cartProvider.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('إلى السلة ${product.name} تم إضافة '),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },


                          icon: Icon(Icons.shopping_cart),
                          label: Text(
                            'إضافة للسلة',
                            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900 , color: Colors.white   ) ,                                    
                          ),
                        ),
                     ),
                      SizedBox(width: 16),
                      // زر إضافة للمفضلة
                     
                     
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFavorite
                              ? colorScheme.error
                              : colorScheme.surfaceContainerHighest,
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await favoritesProvider.toggleFavorite(product);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  favoritesProvider.isFavorite(product)
                                      ? 'تم إضافة ${product.name} إلى المفضلة'
                                      : 'تم إزالة ${product.name} من المفضلة',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite
                                ? colorScheme.onError
                                : colorScheme.onSurfaceVariant,
                          ),
                          iconSize: 28,
                        ),
                      ),
                    ],
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
