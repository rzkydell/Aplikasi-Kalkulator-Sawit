import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/kalkulasi_model.dart';
import 'GrafikScreen.dart';
import 'dart:async';

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final _luasLahanController = TextEditingController();
  final _beratController = TextEditingController();
  final _upahPanenController = TextEditingController();
  final _upahAngkutController = TextEditingController();
  final _biayaPestisidaController = TextEditingController();
  final _hargaPupukController = TextEditingController();
  final _hargaSawitController = TextEditingController();

  final NumberFormat _formatter = NumberFormat.decimalPattern('id');

  String _hasil = '';
  double _biayaPupuk = 0.0;
  double _biayaTotal = 0.0;
  bool _isLoading = false;
  bool _tampilkanCatatan = true;

  void _hitungBiaya() {
    setState(() => _isLoading = true);

    Timer(const Duration(seconds: 2), () {
      double luasLahan = double.tryParse(_luasLahanController.text.replaceAll(',', '.')) ?? 0;
      double berat = double.tryParse(_beratController.text.replaceAll('.', '')) ?? 0;
      double upahPanen = double.tryParse(_upahPanenController.text.replaceAll('.', '')) ?? 0;
      double upahAngkut = double.tryParse(_upahAngkutController.text.replaceAll('.', '')) ?? 0;
      double hargaSawitPerKg = double.tryParse(_hargaSawitController.text.replaceAll('.', '')) ?? 0;
      double danaPupuk = double.tryParse(_hargaPupukController.text.replaceAll('.', '')) ?? 0;
      double danaPestisida = double.tryParse(_biayaPestisidaController.text.replaceAll('.', '')) ?? 0;

      if (luasLahan == 0 || berat == 0 || upahPanen == 0 || upahAngkut == 0 || hargaSawitPerKg == 0 || danaPupuk == 0 || danaPestisida == 0) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('EROR! Wajib mengisi semua form')),
        );
        return;
      }

      double hargaPupukPerKg = 2500;
      double hargaPestisidaPerKg = 150000;

      Kalkulasi kalkulasi = Kalkulasi();

      double totalBiaya = kalkulasi.hitungEstimasiBiaya(
        beratSawit: berat,
        luasLahan: luasLahan,
        upahPanen: upahPanen,
        upahAngkut: upahAngkut,
        hargaPupukPerKg: hargaPupukPerKg,
        hargaPestisidaPerKg: hargaPestisidaPerKg,
      );

      double hasilPendapatan = (berat * hargaSawitPerKg) - ((upahPanen + upahAngkut) * berat);

      double biayaPupuk = kalkulasi.hitungKebutuhanPupuk(luasLahan) * hargaPupukPerKg;
      double biayaPestisidaTotal = kalkulasi.hitungKebutuhanPestisida(luasLahan) * hargaPestisidaPerKg;
      double totalUpahPanen = upahPanen * berat;
      double totalUpahAngkut = upahAngkut * berat;

      double biayaNonTenagaKerja = biayaPupuk + biayaPestisidaTotal;
      double budgetUser = danaPupuk + danaPestisida;

      double luasLahanMaksimal = kalkulasi.hitungLahanMaksimalDariBudget(
        budget: budgetUser,
        hargaPupukPerKg: hargaPupukPerKg,
        hargaPestisidaPerKg: hargaPestisidaPerKg,
      );

      setState(() {
        _biayaPupuk = biayaPupuk;
        _biayaTotal = totalBiaya;
        _hasil = '''
        Biaya Pupuk: Rp ${_formatter.format(biayaPupuk)}
        Biaya Pestisida: Rp ${_formatter.format(biayaPestisidaTotal)}
        Upah Panen: Rp ${_formatter.format(totalUpahPanen)}
        Upah Angkut: Rp ${_formatter.format(totalUpahAngkut)}
        Harga Sawit: Rp ${_formatter.format(hargaSawitPerKg)}/Kg
        Pendapatan: Rp ${_formatter.format(hasilPendapatan)}
        Biaya Total: Rp ${_formatter.format(_biayaTotal)}
        Sisa Budget: Rp ${_formatter.format(budgetUser - biayaNonTenagaKerja)}
        Luas Maksimal dari Budget: ${luasLahanMaksimal.toStringAsFixed(2)} hektar
        Status: ${budgetUser >= biayaNonTenagaKerja ? "Cukup" : "Tidak Cukup"}
        ''';
        _isLoading = false;
      });

      _luasLahanController.clear();
      _beratController.clear();
      _upahPanenController.clear();
      _upahAngkutController.clear();
      _hargaPupukController.clear();
      _hargaSawitController.clear();
      _biayaPestisidaController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GrafikScreen(
            biayaPupuk: biayaPupuk,
            biayaPestisida: biayaPestisidaTotal,
            upahPanen: totalUpahPanen,
            upahAngkut: totalUpahAngkut,
            pendapatan: hasilPendapatan,
            biayaTotal: totalBiaya,
            sisaBudget: budgetUser - biayaNonTenagaKerja,
            status: budgetUser >= biayaNonTenagaKerja ? "Cukup" : "Tidak Cukup",
          ),
        ),
      );
    });
  }

  Widget _buildInputCard(String label, TextEditingController controller, {bool formatRibuan = true}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          enabled: !_isLoading,
          inputFormatters: formatRibuan ? [FilteringTextInputFormatter.digitsOnly] : [],
          decoration: InputDecoration.collapsed(hintText: label),
          style: const TextStyle(fontSize: 16),
          onChanged: (value) {
            if (formatRibuan) {
              final cursorPos = controller.selection.baseOffset;
              String newValue = value.replaceAll('.', '');
              if (newValue.isNotEmpty) {
                newValue = _formatter.format(int.parse(newValue));
              }
              controller.text = newValue;
              controller.selection = TextSelection.fromPosition(
                TextPosition(offset: cursorPos + (newValue.length - value.length)),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.calculate_rounded, color: Colors.orange, size: 28),
            SizedBox(width: 10),
            Text('Kalkulator Sawit'),
          ],
        ),
        backgroundColor: Colors.blue[800],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInputCard('Luas Lahan (Ha) - contoh: 2.5', _luasLahanController, formatRibuan: false),
              _buildInputCard('Hasil Panen TBS (Kg) - contoh: 5.000', _beratController),
              Row(
                children: [
                  Expanded(child: _buildInputCard('Upah Panen (Rp/Kg) - contoh: 500', _upahPanenController)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildInputCard('Upah Angkut (Rp/Kg) - contoh: 500', _upahAngkutController)),
                ],
              ),
              _buildInputCard('Dana Pestisida - contoh: 1.000.000', _biayaPestisidaController),
              _buildInputCard('Dana Pupuk - contoh: 1.000.000', _hargaPupukController),
              _buildInputCard('Harga Sawit per Kg - contoh: 3.000', _hargaSawitController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _hitungBiaya,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('HITUNG', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 20),
              if (_tampilkanCatatan)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () => setState(() => _tampilkanCatatan = false),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: const Text(
                        '📌 Catatan:\n'
                            '• 1 Hektar membutuhkan 1.300kg pupuk dan 6kg pestisida.\n'
                            '• Harga pupuk: Rp 2.500/kg (subsidi).\n'
                            '• Harga pestisida: Rp 150.000/kg (non subsidi).\n'
                            '• Biaya tenaga kerja dihitung berdasarkan berat sawit.\n\n'
                            '👉 Klik untuk menyembunyikan catatan ini.',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}