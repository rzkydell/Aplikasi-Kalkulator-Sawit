import 'package:Kalkulator_Sawit/screens/kalkulator_screen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gambar Latar Belakang
          Image.asset(
            'assets/images/bg.jpg',
            fit: BoxFit.cover,
          ),

          // Lapisan Blur + Warna Gelap Transparan
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          // Konten Utama
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: Image.asset(
                      'assets/images/LOGO-ITSI1.PNG',
                      width: 120,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Judul
                  AnimatedDefaultTextStyle(
                    duration: const Duration(seconds: 1),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                    ),
                    child: const Text('Kalkulator Kebun Sawit'),
                  ),

                  const SizedBox(height: 12),

                  // Deskripsi
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Hitung kebutuhan pupuk, estimasi biaya produksi, dan perawatan lahan sawit anda dengan mudah & cepat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.white70,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'By: M.Farodis Azhari',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Poppins',
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Tombol Mulai
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(seconds: 2),
                    child: ElevatedButton(
                      onPressed: () {
                        _navigateToKalkulatorScreen(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      ),
                      child: const Text(
                        'Mulai Hitung',
                        style: TextStyle(
                          fontSize: 18,
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
          ),
        ],
      ),
    );
  }

  void _navigateToKalkulatorScreen(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const KalkulatorScreen()),
      );
    });
  }
}
