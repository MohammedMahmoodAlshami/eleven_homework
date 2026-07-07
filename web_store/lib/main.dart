import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'providers/theme_provider.dart';
import 'presentation/providers/cart_provider.dart';
import 'presentation/providers/favorites_provider.dart';
import 'presentation/providers/products_provider.dart';
import 'presentation/screens/auth_wrapper.dart';
import 'presentation/screens/categories_screen.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'services/theme_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool? isDarkTheme;

  try {
    // Load theme preference synchronously before runApp to prevent flicker
    final prefs = ThemePreferences();
    isDarkTheme = await prefs.getThemeMode();
  } catch (e, stack) {
    debugPrint('Theme initialization failed: $e\n$stack');
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  } catch (e, stack) {
    debugPrint('Firebase initialization failed: $e\n$stack');
  }

  runApp(MyApp(initialThemeIsDark: isDarkTheme));
}

class MyApp extends StatelessWidget {
  final bool? initialThemeIsDark;
  
  const MyApp({super.key, this.initialThemeIsDark});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..initializeTheme(initialThemeIsDark)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()..loadProducts()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'متجري',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: themeProvider.themeMode,
            home: const AuthWrapper(),
            routes: {
              CategoriesScreen.routeName: (context) => const CategoriesScreen(),
            },
          );
        },
      ),
    );
  }
}
