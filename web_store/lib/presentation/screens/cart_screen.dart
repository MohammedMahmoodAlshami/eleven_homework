import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen ({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    Widget coverImage({  required String url,  required BoxFit fit, double? width,double? height,} ) {
     
      Widget fallback() => ColoredBox(
            color: colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.broken_image_outlined,
              color: colorScheme.outline,
            ),   );
    
    
      return Image.asset(
        url.trim(),
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => fallback(),
      );
    }  // END coverImage

    return Scaffold(
      
      appBar: CustomAppBar(title: 'سلة التسوق', showBackButton: true),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: colorScheme.onSurfaceVariant,
                  ),  
                  SizedBox(height: 16),
                  Text(
                    'سلة التسوق فارغة',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('تسوق الآن'),
                  ),
                ],
              ),
            )


          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, i) {
                      final item = cartItems[i];
                      
                      return Dismissible(
                        key: Key(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: colorScheme.errorContainer,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: colorScheme.onErrorContainer),
                        ),

                        onDismissed: (_) => cartProvider.removeFromCart(item.product.id),
                        child: Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),


                        child : Directionality (
                  textDirection: TextDirection.rtl,  
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: coverImage(
                                url: item.product.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),

                            title: Text(
                              item.product.name,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),

                            subtitle: Text('${item.product.price} ريال × ${item.quantity}'),
                          
                          
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                              IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () => cartProvider.addToCart(item.product),
                                ),

                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () => cartProvider.removeOneFromCart(item.product.id),
                                ),
                                Text(
                                  '    ${item.quantity}',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                               

                              ],
                            ),


                          ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // ملخص السلة
               
                
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.shadow.withValues(alpha: 0.08),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                 child : Directionality (
                  textDirection: TextDirection.rtl,  
                   child:  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الإجمالي :',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 20
                            ),
                          ),
                          Text(
                            '${cartProvider.totalAmount} ريال',
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colorScheme.primary,
                               fontSize: 22 , 
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // هنا يمكن إضافة عملية الدفع
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('شكراً لتسوقك!' ,  textAlign: TextAlign.right,),
                                  content: Text('تم إتمام عملية الشراء بنجاح.' , textAlign: TextAlign.right,),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        cartProvider.clearCart();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text('موافق'),
                                    ),
                                  ],
                                ),
                              );
                          },
                         child: Text('إتمام الشراء'),
                        ),
                      ),
                    ],
                  ),
              )
                
               



                ),
              ],
            ),
    );
  }
}
