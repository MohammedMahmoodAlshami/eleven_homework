import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

const ProductCard({
  super.key,
  required this.product,
});




  @override
  Widget build(BuildContext context) {
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
        //استخدم لونًا مخصصًا للخلفيات أو الحاويات المرتفعة داخل التصميم.
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

    return Padding(
     padding: const EdgeInsets.all(8),
      child: Card(
        clipBehavior: Clip.antiAlias,
      
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.35,
                child: coverImage(
                  url: product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding (
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                const SizedBox(height: 4),
                    Text(
                      product.categoryName,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(0)} ريال',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: colorScheme.primary,
                          ),
                        ),

                        Container(
                     
                        padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: colorScheme.onPrimary,
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
      ),
    );
  }
}
