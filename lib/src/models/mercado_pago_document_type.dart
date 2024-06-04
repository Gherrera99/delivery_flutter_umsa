class MercadoPagoDocumentType {

  //IDENTIFICADOR DEL TIPO DE IDENTIFICACION
  String? id;

  //OMBRE DEL TIPO DE IDENTIFICACION
  String? name;

  //TIPO DE DATO DEL NUMERO DE IDENTIFICACION
  String? type;

  //MINIMA LONGITUD DEL NUMERO DE IDENTIFICACION
  int? minLength;

  //MAXIMA LONGITUD DEL NUMERO DE IDENTIFICACION
  int? maxLength;

  MercadoPagoDocumentType();

  static List<MercadoPagoDocumentType> fromJsonList(List<dynamic> jsonList) {
    List<MercadoPagoDocumentType> toList = [];

    jsonList.forEach((item) {
      MercadoPagoDocumentType document = MercadoPagoDocumentType.fromJsonMap(item);
      toList.add(document);
    });

    return toList;
  }

  MercadoPagoDocumentType.fromJsonMap( Map<String, dynamic> json ) {
    print('EL JSON ES $json');
    id            = json['id'];
    name          = json['name'];
    type          = json['type'];
    minLength     = (json['min_length'] != null) ? int.parse(json['min_length'].toString()) : 0;
    maxLength     = (json['max_length'] != null) ? int.parse(json['max_length'].toString()) : 0;
  }

  Map<String, dynamic> toJson() =>
      {
        'id'          : id,
        'name'        : name,
        'type'        : type,
        'min_length'  : minLength,
        'max_length'  : maxLength
      };
}