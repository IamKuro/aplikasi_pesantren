class Pesantren {
  final String id;
  final String nama;
  final String nspp;
  final String alamat;
  final String kyai;
  final Kabupaten kabupaten;
  final Provinsi provinsi;

  Pesantren({
    required this.id,
    required this.nama,
    required this.nspp,
    required this.alamat,
    required this.kyai,
    required this.kabupaten,
    required this.provinsi,
  });

  factory Pesantren.fromJson(Map<String, dynamic> json) {
    return Pesantren(
      id: json['id'],
      nama: json['nama'],
      nspp: json['nspp'],
      alamat: json['alamat'],
      kyai: json['kyai'],
      kabupaten: Kabupaten.fromJson(json['kab_kota']),
      provinsi: Provinsi.fromJson(json['provinsi']),
    );
  }
}

class Kabupaten {
  final String id;
  final String nama;

  Kabupaten({required this.id, required this.nama});

  factory Kabupaten.fromJson(Map<String, dynamic> json) {
    return Kabupaten(
      id: json['id'],
      nama: json['nama'],
    );
  }
}

class Provinsi {
  final String id;
  final String nama;

  Provinsi({required this.id, required this.nama});

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    return Provinsi(
      id: json['id'],
      nama: json['nama'],
    );
  }
}
