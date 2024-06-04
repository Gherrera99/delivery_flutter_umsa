class MercadoPagoSecurityCode {

  //LONGITUD DEL CODIGO DE SEGURIDAD
  int? length;

  //UBICACION DEL CODIGO DE SEGURIDAD EN LA TARJETA
  String? cardLocation;

  List<MercadoPagoSecurityCode>? issuerList = [];

  MercadoPagoSecurityCode();

  static List<MercadoPagoSecurityCode> fromJsonList(List<dynamic> jsonList) {
    List<MercadoPagoSecurityCode> toList = [];

    jsonList.forEach((item) {
      MercadoPagoSecurityCode model = MercadoPagoSecurityCode.fromJson(item);
      toList.add(model);
    });

    return toList;
  }

  MercadoPagoSecurityCode.fromJson( Map<String, dynamic> json ) {
    length          = json['length'];
    cardLocation    = json['card_location'];
  }

  Map<String, dynamic> toJson() =>
      {
        'length'         : length,
        'card_location'  : cardLocation
      };
}