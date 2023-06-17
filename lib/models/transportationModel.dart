class TransportationModel {
  int? id;
  int? idCustomer;
  String? tanggalPenggunaan;
  String? tujuan;
  String? lamaPenggunaan;
  String? tipeMobil;
  String? jumlah;
  String? harga;
  Null? createdAt;
  Null? updatedAt;

  TransportationModel(
      {this.id,
      this.idCustomer,
      this.tanggalPenggunaan,
      this.tujuan,
      this.lamaPenggunaan,
      this.tipeMobil,
      this.jumlah,
      this.harga,
      this.createdAt,
      this.updatedAt});

  TransportationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCustomer = json['id_customer'];
    tanggalPenggunaan = json['tanggal_penggunaan'];
    tujuan = json['tujuan'];
    lamaPenggunaan = json['lama_penggunaan'];
    tipeMobil = json['tipe_mobil'];
    jumlah = json['jumlah'];
    harga = json['harga'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_customer'] = this.idCustomer;
    data['tanggal_penggunaan'] = this.tanggalPenggunaan;
    data['tujuan'] = this.tujuan;
    data['lama_penggunaan'] = this.lamaPenggunaan;
    data['tipe_mobil'] = this.tipeMobil;
    data['jumlah'] = this.jumlah;
    data['harga'] = this.harga;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
