import 'package:flutter/material.dart';
import 'package:tugas_pertemuantm_5/models/produk.dart';
import 'package:tugas_pertemuantm_5/models/map.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Checkout> {
  DataBelanjaan dataBelanjaan = DataBelanjaan();
  List<bool> checkedProducts = []; // Untuk menyimpan status checkbox
  int harga = 0;
  bool couponApplied = false; // Apakah kupon diskon sudah digunakan
  double discountPercentage = 5; // Persentase diskon, misalnya 5%
  int voucherAmount = 25000; // Misalnya potongan harga voucher sebesar Rp25.000

  @override
  void initState() {
    super.initState();
    // Inisialisasi status checkbox
    for (int i = 0; i < dataBelanjaan.daftarbelanjaan.length; i++) {
      checkedProducts.add(false);
    }
  }

  void toggleChecked(int index) {
    setState(() {
      checkedProducts[index] = !checkedProducts[index];
    });
    if (checkedProducts[index]) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sukses Menambahkan Produk!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  int getCheckedCount() {
    int count = 0;
    for (bool isChecked in checkedProducts) {
      if (isChecked) {
        count++;
      }
    }
    return count;
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (int i = 0; i < dataBelanjaan.daftarbelanjaan.length; i++) {
      if (checkedProducts[i]) {
        totalPrice += dataBelanjaan.daftarbelanjaan[i].harga;
      }
    }
    return totalPrice;
  }

  double getDiscountAmount() {
    return getTotalPrice() * (discountPercentage / 100);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Checkout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.shopping_cart_rounded, size: 30),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dataBelanjaan.daftarbelanjaan.length,
                itemBuilder: (context, index) {
                  Belanjaan belanjaan = dataBelanjaan.daftarbelanjaan[index];
                  return Card(
                    child: CheckboxListTile(
                      title: Text(belanjaan.nama),
                      subtitle: Text('Rp ${belanjaan.harga}'),
                      value: checkedProducts[index],
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            checkedProducts[index] = value;
                            if (value) {
                              harga += belanjaan.harga;
                            } else {
                              harga -= belanjaan.harga;
                            }
                          });
                        }
                      },
                      secondary: Image.network(
                        belanjaan.img,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (couponApplied)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Discount (${discountPercentage.toStringAsFixed(0)}%):',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                          Text(
                            '-Rp${getDiscountAmount().toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    SizedBox(height: 10),
                    Text(
                      'Total selected items: ${getCheckedCount()}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Price: Rp${harga.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Voucher',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Switch(
                          value: couponApplied,
                          onChanged: (value) {
                            setState(() {
                              couponApplied = value;
                              if (couponApplied) {
                                harga -= voucherAmount;
                              } else {
                                harga += voucherAmount;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
