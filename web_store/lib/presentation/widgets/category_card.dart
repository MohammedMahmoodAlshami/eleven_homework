
import 'package:flutter/material.dart';
import '../../models/category.dart';
import '../screens/products_by_category_screen.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key , required this.category}) ;



  @override
  Widget build(BuildContext context) {
    
    final textTheme = Theme.of(context).textTheme;
    final color = Color(int.parse(category.colorValue));
    final onColor = ThemeData.estimateBrightnessForColor(color) == Brightness.dark
        ? Colors.white
        : const Color(0xFF0B1220);
    
    return Padding(
      
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(

         color: Colors.transparent,
        
        child: InkWell(
          // borderRadius: BorderRadius.circular(28),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductsByCategoryScreen(category: category),
              ),
            );
          },


          child: Ink(
            width: 108,
            

            decoration: BoxDecoration (
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.95),
                  Color.lerp(color, Colors.white, 0.18)!.withValues(alpha: 0.92),
                ],
              ),

              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.30),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child:
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.22),
                        width: 1,
                      ),
                    ),


                    child: SizedBox(
                        width:  80,
                         height:  60,
                        child: Image.asset(  category.icon,
                           fit: BoxFit.contain,
                             ),
                                )
                    ),
                  
                  const SizedBox(height: 10),
                  Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: onColor,
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
