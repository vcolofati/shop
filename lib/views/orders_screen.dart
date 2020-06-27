import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import '../widgets/order_widget.dart';

Future<void> _refreshOrders(BuildContext context) {
  return Provider.of<Orders>(context, listen: false).loadOrders();
}

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshOrders(context),
        child: FutureBuilder(
          future: _refreshOrders(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orders, child) {
                  return ListView.builder(
                    itemCount: orders.itemsCount,
                    itemBuilder: (_, i) => OrderWidget(orders.items[i]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
