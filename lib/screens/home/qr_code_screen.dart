import 'package:coffee_store/widgets/my_qr_code_appbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:coffee_store/data/coffee_model.dart';
import 'dart:convert';

class QrCodeScreen extends StatelessWidget {
  final List<Coffee> cartItems;

  QrCodeScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final cartIds = cartItems.map((item) => item.id).toList();
    final cartIdsJson = json.encode(cartIds);

    return Scaffold(
      appBar: MyQrCodeAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: QrImageView(
              data: cartIdsJson,
              version: QrVersions.auto,
            ),
          ),
        ),
      ),
    );
  }
}
