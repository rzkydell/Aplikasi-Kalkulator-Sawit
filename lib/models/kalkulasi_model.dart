class Kalkulasi {
  static const double kebutuhanPupukPerHektar = 1300.0;//kg
  static const double kebutuhanPestisidaPerHektar = 6.0;//kg

  static const double defaultHargaPupukPerKg = 2500.0;//Rp
  static const double defaultHargaPestisidaPerKg = 150000.0;//Rp

  /// Hitung total kebutuhan pupuk
  double hitungKebutuhanPupuk(double luasLahan) {
    return luasLahan * kebutuhanPupukPerHektar;
  }

  /// Hitung total kebutuhan pestisida
  double hitungKebutuhanPestisida(double luasLahan) {
    return luasLahan * kebutuhanPestisidaPerHektar;
  }

  /// Hitung total biaya
  double hitungEstimasiBiaya({
    required double beratSawit,
    required double luasLahan,
    required double upahPanen,
    required double upahAngkut,
    double hargaPupukPerKg = defaultHargaPupukPerKg,
    double hargaPestisidaPerKg = defaultHargaPestisidaPerKg,
  }) {
    double biayaPupuk = hitungKebutuhanPupuk(luasLahan) * hargaPupukPerKg;
    double biayaPestisida = hitungKebutuhanPestisida(luasLahan) * hargaPestisidaPerKg;
    double biayaTenagaKerja = (upahPanen + upahAngkut) * beratSawit;

    return biayaPupuk + biayaPestisida + biayaTenagaKerja;
  }

  /// Hitung luas lahan maksimal yang bisa dikelola dari budget
  double hitungLahanMaksimalDariBudget({
    required double budget,
    required double beratSawit,
    required double upahPanen,
    required double upahAngkut,
    double hargaPupukPerKg = defaultHargaPupukPerKg,
    double hargaPestisidaPerKg = defaultHargaPestisidaPerKg,
  }) {
    double biayaPerHektar = (kebutuhanPupukPerHektar * hargaPupukPerKg) +
        (kebutuhanPestisidaPerHektar * hargaPestisidaPerKg);

    double biayaTenagaKerjaPerKg = upahPanen + upahAngkut;
    double biayaTenagaKerja = beratSawit * biayaTenagaKerjaPerKg;

    double sisaBudget = budget - biayaTenagaKerja;

    if (sisaBudget <= 0) {
      return 0; // uang hanya cukup buat bayar tenaga kerja
    }

    double luasLahanMaks = sisaBudget / biayaPerHektar;
    return luasLahanMaks;
  }
}
