class MercadoPagoIssuer {

  //IDENTIFICACION DEL EMISON
  String? id;

  //NOMBRE DEL EMISOR
  String? name;

  MercadoPagoIssuer();

  static List<MercadoPagoIssuer> fromJsonList(List<dynamic> jsonList) {
    List<MercadoPagoIssuer> toList = [];

    jsonList.forEach((item) {
      MercadoPagoIssuer model = MercadoPagoIssuer.fromJson(item);
      toList.add(model);
    });

    return toList;
  }

  MercadoPagoIssuer.fromJson( Map<String, dynamic> json ) {
    id      = json['id'].toString();
    name    = json['name'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id'    : id,
        'name'  : name
      };
}