import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../providers/products_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_app_bar.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final Category category;

  const ProductsByCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final categoryProducts = productsProvider.products
        .where((product) => product.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: CustomAppBar(title: category.name, showBackButton: true),
      body: productsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productsProvider.errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          productsProvider.errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () =>
                              productsProvider.loadProducts(forceRefresh: true),
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  ),
                )
              : categoryProducts.isEmpty
                  ? Center(
                      child: Text(
                        'لا توجد منتجات في هذا القسم',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    )
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: categoryProducts.length,
                        itemBuilder: (context, i) =>
                            ProductCard(product: categoryProducts[i]),
                      ),
                    ),
    );
  }
}
