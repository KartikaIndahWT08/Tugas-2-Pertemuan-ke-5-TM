import 'package:flutter/material.dart';
import 'package:tugas_pertemuantm_5/page/checkout.dart';
// import 'package:tugas_pertemuantm_5/models/produk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Checkout();
  }
}
