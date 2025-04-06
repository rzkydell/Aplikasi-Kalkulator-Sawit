import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GrafikScreen extends StatefulWidget {
  final double biayaPupuk;
  final double biayaTotal;
  final double upahPanen;
  final double upahAngkut;
  final double biayaPestisida;
  final String hasil;
  final double pendapatan;

  GrafikScreen({
    required this.biayaPupuk,
    required this.biayaTotal,
    required this.upahAngkut,
    required this.upahPanen,
    required this.biayaPestisida,
    required this.hasil,
    required this.pendapatan,
  });

  @override
  _GrafikScreenState createState() => _GrafikScreenState();
}

class _GrafikScreenState extends State<GrafikScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Menyesuaikan nilai maxY untuk memastikan grafik tidak terlalu tinggi
    double maxY = (widget.biayaTotal + widget.upahPanen + widget.upahAngkut + widget.biayaPestisida + widget.pendapatan) / 1000000 + 1;

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("Grafik Biaya"),
        backgroundColor: Colors.blue[700],
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Estimaasi Biaya dan Pendapatan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: maxY,
                  backgroundColor: Colors.black54, // Warna background grafik
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        String label;
                        double value;

                        // Tentukan nilai yang ingin ditampilkan, misalnya biayaPupuk, biayaPestisida, dll.
                        switch (group.x.toInt()) {
                          case 0:
                            value = widget.biayaPupuk;
                            break;
                          case 1:
                            value = widget.biayaPestisida;
                            break;
                          case 2:
                            value = widget.upahPanen;
                            break;
                          case 3:
                            value = widget.upahAngkut;
                            break;
                          case 4:
                            value = widget.pendapatan;
                            break;
                          case 5:
                            value = widget.biayaTotal;
                            break;
                          default:
                            value = 0;
                        }

                        // Tentukan satuan berdasarkan nilai
                        String formattedLabel;
                        if (value >= 1000000) {
                          formattedLabel = "Rp ${(value / 1000000).toStringAsFixed(2)} Jt";
                        } else {
                          formattedLabel = "Rp ${(value / 1000).toStringAsFixed(2)} Rb";
                        }

                        return BarTooltipItem(formattedLabel, TextStyle(color: Colors.white));
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.white.withOpacity(0.3),
                      strokeWidth: 1,
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buildBar(0, widget.biayaPupuk, [Colors.blue, Colors.lightBlue]),
                    _buildBar(1, widget.biayaPestisida, [Colors.purple, Colors.deepPurple]),
                    _buildBar(2, widget.upahPanen, [Colors.green, Colors.lightGreen]),
                    _buildBar(3, widget.upahAngkut, [Colors.red, Colors.pinkAccent]),
                    _buildBar(4, widget.pendapatan, [Colors.orange, Colors.deepOrange]),
                    _buildBar(5, widget.biayaTotal, [Colors.greenAccent, Colors.green]),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTextStyles: (value) => TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      getTitles: (value) => "${(value.toInt()).toString()} Jt",
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTextStyles: (value) => TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return "Pupuk";
                          case 1:
                            return "Pestisida";
                          case 2:
                            return "Panen";
                          case 3:
                            return "Angkut";
                          case 4:
                            return "Pendapatan";
                          case 5:
                            return "Total";
                          default:
                            return "";
                        }
                      },
                    ),
                    topTitles: SideTitles(showTitles: false),
                    rightTitles: SideTitles(showTitles: false),
                  ),
                  groupsSpace: 35,
                ),
                swapAnimationDuration: Duration(milliseconds: 500), // Animasi transisi
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
            SizedBox(height: 15),
            Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AutoSizeText(
                  widget.hasil,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 6,
                  minFontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat bar pada grafik
  BarChartGroupData _buildBar(int index, double value, List<Color> colors) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          y: value / 1000000, // Membagi dengan 1 juta untuk memudahkan visualisasi
          colors: colors,
          width: 20,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}
