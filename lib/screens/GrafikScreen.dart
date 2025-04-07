import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';

class GrafikScreen extends StatefulWidget {
  final double biayaPupuk;
  final double biayaPestisida;
  final double upahPanen;
  final double upahAngkut;
  final double pendapatan;
  final double biayaTotal;
  final double sisaBudget;
  final String status;

  const GrafikScreen({
    required this.biayaPupuk,
    required this.biayaPestisida,
    required this.upahPanen,
    required this.upahAngkut,
    required this.pendapatan,
    required this.biayaTotal,
    required this.sisaBudget,
    required this.status,
  });

  @override
  _GrafikScreenState createState() => _GrafikScreenState();
}

class _GrafikScreenState extends State<GrafikScreen> {
  @override
  Widget build(BuildContext context) {
    double maxY = [
      widget.biayaPupuk,
      widget.biayaPestisida,
      widget.upahPanen,
      widget.upahAngkut,
      widget.pendapatan,
      widget.biayaTotal,
      widget.sisaBudget
    ].reduce((a, b) => a > b ? a : b) / 1000000 + 1;

    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text("Grafik Biaya & Budget"),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Estimasi Biaya dan Budget",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  maxY: maxY,
                  backgroundColor: Colors.black54,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final value = _getValueByIndex(group.x.toInt());
                        String formattedLabel = value >= 1000000
                            ? "Rp ${(value / 1000000).toStringAsFixed(2)} Jt"
                            : "Rp ${(value / 1000).toStringAsFixed(2)} Rb";

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
                    _buildBar(6, widget.sisaBudget, [Colors.cyan, Colors.teal]),
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
                      getTitles: (value) => "${value.toInt()} Jt",
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
                          case 6:
                            return "Sisa";
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
                  "Status Budget Anda: ${widget.status}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 7,
                  minFontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getValueByIndex(int index) {
    switch (index) {
      case 0:
        return widget.biayaPupuk;
      case 1:
        return widget.biayaPestisida;
      case 2:
        return widget.upahPanen;
      case 3:
        return widget.upahAngkut;
      case 4:
        return widget.pendapatan;
      case 5:
        return widget.biayaTotal;
      case 6:
        return widget.sisaBudget;
      default:
        return 0;
    }
  }

  BarChartGroupData _buildBar(int index, double value, List<Color> colors) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          y: value / 1000000,
          colors: colors,
          width: 20,
          borderRadius: BorderRadius.zero,
        ),
      ],
    );
  }
}
