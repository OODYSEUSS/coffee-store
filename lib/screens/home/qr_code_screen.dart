import 'package:coffee_store/bloc/home/qr_code_cubit.dart';
import 'package:coffee_store/widgets/my_qr_code_appbar.dart';
import 'package:coffee_store/data/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class QrCodeScreen extends StatelessWidget {
  final List<Coffee> cartItems;

  QrCodeScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          QrCodeCubit()..getUserName(cartItems.map((item) => item.id).toList()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        appBar: MyQrCodeAppBar(),
        body: BlocBuilder<QrCodeCubit, QrCodeState>(
          builder: (context, state) {
            final dataToEncode = {
              'name': state.userName,
              'cartIds': state.cartIds,
            };
            final dataJson = json.encode(dataToEncode);
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: QrImageView(
                    data: dataJson,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
