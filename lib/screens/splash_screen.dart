import 'package:Kalkulator_Sawit/screens/kalkulator_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10, // Menggunakan warna latar belakang yang lebih segar
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animasi Logo
            Center(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/LOGO-ITSI.png',
                  width: 2000, // Ukuran logo lebih proporsional
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Judul dengan animasi
            AnimatedDefaultTextStyle(
              duration: const Duration(seconds: 1),
              style: TextStyle(
                fontSize: 28, // Ukuran font yang lebih besar
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
              child: const Text(
                'Kalkulator Biaya',
              ),
            ),
            const SizedBox(height: 10),
            // Deskripsi dengan animasi
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Aplikasi ini membantu anda menghitung estimasi pengeluaran dan pendapatan panen anda dengan mudah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10), // Jarak antar teks
                  Text(
                    'By: Rizky Delianggi',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                      fontStyle: FontStyle.italic, // Menambahkan gaya italic untuk menonjolkan
                    ),
                  ),
                ],
              ),

            ),
            const SizedBox(height: 30),
            // Tombol Mulai dengan animasi
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              child: ElevatedButton(
                onPressed: () {
                  _navigateToKalkulatorScreen(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Warna tombol yang lebih mencolok
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut tombol lebih melengkung
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Lebar dan tinggi tombol lebih besar
                ),
                child: const Text(
                  'Hitung',
                  style: TextStyle(
                    fontSize: 20, // Ukuran font yang lebih besar
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToKalkulatorScreen(BuildContext context) {
    // Menampilkan loading screen sementara
    showDialog(
      context: context,
      barrierDismissible: false, // agar dialog tidak dapat ditutup dengan menekan di luar
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(), // Menampilkan loading
        );
      },
    );

    // Delay sebelum pindah ke kalkulator screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const KalkulatorScreen()),
      );
    });
  }
}
