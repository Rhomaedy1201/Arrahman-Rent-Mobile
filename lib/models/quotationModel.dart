class QuotationModel {
  int? id;
  String? kutipanSewa;
  String? namaCustomer;
  String? email;
  String? namaPerusahaan;
  String? kota;
  String? namaJalan;
  String? kodePos;
  String? noHp;
  String? tanggal;
  String? noQuotation;
  Null? komentar;
  Null? totalHarga;
  int? idUser;
  Null? createdAt;
  Null? updatedAt;

  QuotationModel(
      {this.id,
      this.kutipanSewa,
      this.namaCustomer,
      this.email,
      this.namaPerusahaan,
      this.kota,
      this.namaJalan,
      this.kodePos,
      this.noHp,
      this.tanggal,
      this.noQuotation,
      this.komentar,
      this.totalHarga,
      this.idUser,
      this.createdAt,
      this.updatedAt});

  QuotationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kutipanSewa = json['kutipan_sewa'];
    namaCustomer = json['nama_customer'];
    email = json['email'];
    namaPerusahaan = json['nama_perusahaan'];
    kota = json['kota'];
    namaJalan = json['nama_jalan'];
    kodePos = json['kode_pos'];
    noHp = json['no_hp'];
    tanggal = json['tanggal'];
    noQuotation = json['no_quotation'];
    komentar = json['komentar'];
    totalHarga = json['total_harga'];
    idUser = json['id_user'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kutipan_sewa'] = this.kutipanSewa;
    data['nama_customer'] = this.namaCustomer;
    data['email'] = this.email;
    data['nama_perusahaan'] = this.namaPerusahaan;
    data['kota'] = this.kota;
    data['nama_jalan'] = this.namaJalan;
    data['kode_pos'] = this.kodePos;
    data['no_hp'] = this.noHp;
    data['tanggal'] = this.tanggal;
    data['no_quotation'] = this.noQuotation;
    data['komentar'] = this.komentar;
    data['total_harga'] = this.totalHarga;
    data['id_user'] = this.idUser;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
