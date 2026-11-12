# Kalkulator Sawit — Oil Palm Cost Calculator

A Flutter mobile app that helps oil palm smallholders estimate **fertiliser and pesticide needs, harvest labour costs and income** for their land, check whether their budget is enough, and see the breakdown as a bar chart.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.7%2B-0175C2?style=flat-square&logo=dart&logoColor=white)
![fl_chart](https://img.shields.io/badge/fl__chart-charts-4CAF50?style=flat-square)

## Features

- **Inputs:** land area (ha), harvest weight of fresh fruit bunches (kg), harvesting and transport wages (Rp/kg), fertiliser and pesticide budget, and the palm fruit price (Rp/kg). Thousands separators are added while typing.
- **Results:** fertiliser cost, pesticide cost, harvesting and transport wages, income after wages, total cost, remaining budget, the **largest area the budget can cover**, and a *sufficient / not sufficient* status.
- **Chart screen:** a bar chart of costs, income and remaining budget (fl_chart).
- Splash screen, Poppins font and a custom launcher icon.

### Assumptions used in the calculation (`lib/models/kalkulasi_model.dart`)

| Item | Value |
| --- | --- |
| Fertiliser need | 1,300 kg per hectare |
| Pesticide need | 6 kg per hectare |
| Fertiliser price | Rp 2,500 per kg (subsidised) |
| Pesticide price | Rp 150,000 per kg |
| Labour cost | (harvesting + transport wage) × harvest weight |

These are fixed in the code and shown to the user as a note on the input screen; adjust them for local conditions.

## Project structure

```text
lib/
├── main.dart                     # App entry (MaterialApp, green theme)
├── models/
│   └── kalkulasi_model.dart      # Calculation logic and assumptions
└── screens/
    ├── splash_screen.dart
    ├── kalkulator_screen.dart    # Input form, validation and results
    └── GrafikScreen.dart         # Bar chart of costs and budget
assets/                           # Fonts, logo, background, app icon
```

## Getting started

Requires the Flutter SDK (Dart 3.7 or newer).

```bash
git clone https://github.com/rzkydell/Aplikasi-Kalkulator-Sawit.git
cd Aplikasi-Kalkulator-Sawit
flutter pub get
flutter run
```

Build an Android APK with `flutter build apk --release`.

## Credits

Made at Institut Teknologi Sawit Indonesia (ITSI). The app's splash screen credits **M. Farodis Azhari**. Repository maintained by [Rizky Delianngi](https://github.com/rzkydell) · [Portfolio](https://rzkydell.vercel.app/en#research).

<details>
<summary>Ringkasan (Bahasa Indonesia)</summary>

Aplikasi Flutter untuk menghitung kebutuhan pupuk dan pestisida, upah panen dan angkut, pendapatan, sisa anggaran, serta luas lahan maksimal yang bisa dibiayai, lengkap dengan grafik batang. Asumsi: 1.300 kg pupuk dan 6 kg pestisida per hektar, pupuk Rp 2.500/kg, pestisida Rp 150.000/kg.

</details>
