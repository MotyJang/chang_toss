class Bank {
  String? name;
  String? bankImage;
  int? balance;

  Bank({
    this.name,
    this.bankImage,
    this.balance,
  });

  Bank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bankImage = json['bank_image'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['bank_image'] = bankImage;
    data['balance'] = balance;
    return data;
  }
}
