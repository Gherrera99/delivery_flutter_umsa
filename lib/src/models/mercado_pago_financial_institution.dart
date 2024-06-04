class MercadoPagoFinancialInstitution {

  String? id;
  String? description;

  MercadoPagoFinancialInstitution();

  static List<MercadoPagoFinancialInstitution> fromJsonList(List<dynamic> jsonList) {
    List<MercadoPagoFinancialInstitution> toList = [];

    jsonList.forEach((item) {
      MercadoPagoFinancialInstitution model = MercadoPagoFinancialInstitution.fromJson(item);
      toList.add(model);
    });

    return toList;
  }

  MercadoPagoFinancialInstitution.fromJson( Map<String, dynamic> json ) {
    id            = json['id'];
    description   = json['description'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id'          : id,
        'description' : description
      };
}