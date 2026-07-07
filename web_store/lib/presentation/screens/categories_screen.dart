import 'package:flutter/material.dart';
import '../../data/dummy_data.dart';
import '../widgets/category_card.dart';
import '../widgets/custom_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen ({super.key});
 static const routeName = '/categories';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'جميع الأقسام', showBackButton: true),
      body: Directionality ( 
      textDirection: TextDirection.rtl,
       child : GridView.builder(
        
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (ctx, i) => CategoryCard(category: categories[i]),
      ),
      )
       
    );
  }
}
