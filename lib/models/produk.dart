class Belanjaan {
  final String nama;
  final int harga;
  bool isChecked;
  final String img;

  Belanjaan(
      {required this.nama,
      required this.harga,
      this.isChecked = false,
      required this.img});
}
