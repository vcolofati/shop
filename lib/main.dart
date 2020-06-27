import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/views/auth_home_screen.dart';

import './utils/app_routes.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/orders_screen.dart';
import 'package:shop/views/products_screen.dart';
import 'package:shop/views/product_form_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, previusProducts) => Products(
            auth.token,
            previusProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, previusOrders) => Orders(
            auth.token,
            auth.userId,
            previusOrders.items,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Minha Loja',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        // home: ProductOverviewScreen(),
        routes: {
          AppRoutes.AUTH_HOME: (_) => AuthOrHomeScreen(),
          AppRoutes.PRODUCT_DETAIL: (_) => ProductDetailScreen(),
          AppRoutes.CART: (_) => CartScreen(),
          AppRoutes.ORDERS: (_) => OrdersScreen(),
          AppRoutes.PRODUCTS: (_) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (_) => ProductFormScreen(),
        },
      ),
    );
  }
}
