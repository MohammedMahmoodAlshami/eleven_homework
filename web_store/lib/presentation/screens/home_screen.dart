import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import '../../services/auth_service.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final allProducts = productsProvider.products;
    final popularProducts = allProducts.where((p) => p.isPopular).toList();
    final displayProducts = popularProducts.isNotEmpty ? popularProducts : allProducts;

   
    return Scaffold(
appBar: AppBar(
  automaticallyImplyLeading: false,
  // اجعل المسافة بين بداية AppBar والعنوان = 12 بكسل
  titleSpacing: 12,
    elevation: 0,
  backgroundColor: Colors.white,

   title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [

      InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FavoritesScreen(),
            ),
          );
        },

        child:  Container(
          padding: const EdgeInsets.symmetric( horizontal: 14,  vertical: 10,  ),

          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(15),
          ),

          child: Row(
            children: const [

              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 22,
              ),

              SizedBox(width: 6),

              Text(
                'المفضلة',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),


      Row(
        children:  [

         const Text(
            'متجر الموشكي',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          SizedBox(width: 10),

    InkWell(

     onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(),
            ),
          );
        },
        child:  Icon(
            Icons.shopping_cart_outlined,
            color: Colors.black,
            size: 25,
          ), 
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () async {
              try {
                await AuthService().signOut();
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        e.toString().replaceAll('Exception: ', ''),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Icon(
              Icons.logout,
              color: Colors.black,
              size: 25,
            ),
          )
        ],
      ),

      
    ],
  ),
),





     
     
     
     
      body: productsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productsProvider.errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        productsProvider.errorMessage!, 
                        textAlign: TextAlign.center, 
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          productsProvider.loadProducts(forceRefresh: true);
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('إعادة المحاولة (Retry)'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (productsProvider.isOffline)
              Container(
                width: double.infinity,
                color: Colors.orange,
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Offline Mode - Showing Last Saved Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            // Banner ترحيبي
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary,
                    colorScheme.tertiary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مرحباً بك ',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'اكتشف أفضل العروض',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onPrimary.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.storefront, size: 50, color: colorScheme.onPrimary),
                ],
              ),
            ),


           
            // الأقسام
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/categories');
                    },
                    
                    child: Text(
                      'عرض الكل',
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w900,fontSize: 18

                      ),
                    ),
                  ), Text(
                    'الأقسام',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'اختر القسم المناسب لك بسرعة',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 160,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (ctx, i) => CategoryCard(category: categories[i]),
              ),
            ),
            
            // المنتجات الشائعة
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                'المنتجات الشائعة ',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: displayProducts.length,
                itemBuilder: (ctx, i) {
                  return ProductCard(product: displayProducts[i]);
                },
              ),
            ),
            
            SizedBox(height: 80), // مساحة للسفل
          ],
        ),
      ),
    );
  }
}
