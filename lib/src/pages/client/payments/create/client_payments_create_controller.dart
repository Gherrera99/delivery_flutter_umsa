import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';

class ClientPaymentsCreateController extends GetxController {

  TextEditingController documentNumberController = TextEditingController();

  var cardNumber = ''.obs;
  var expireDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  var isCvvFocused = false.obs;
  //var idDocument = ''.obs;
  GlobalKey<FormState> keyForm = GlobalKey();

//   MercadoPagoProvider mercadoPagoProvider = MercadoPagoProvider();
//   List<MercadoPagoDocumentType> documents = <MercadoPagoDocumentType>[].obs;
//
//   ClientPaymentsCreateController() {
//     getDocumentType();
//   }
//
//   void createCardToken() async {
//     String documentNumber = documentNumberController.text;
//
//     if (isValidForm(documentNumber)) {
//       cardNumber.value = cardNumber.value.replaceAll(RegExp(' '), '');
//       List<String> list = expireDate.split('/');
//       int month = int.parse(list[0]);
//       String year = '20${list[1]}';
//
//       MercadoPagoCardToken mercadoPagoCardToken = await mercadoPagoProvider.createCardToken(
//         cardNumber: cardNumber.value,
//         expirationYear: year,
//         expirationMonth: month,
//         cardHolderName: cardHolderName.value,
//         cvv: cvvCode.value,
//         documentId: idDocument.value,
//         documentNumber: documentNumber
//       );
//
//       Get.toNamed('/client/payments/installments', arguments: {
//         'card_token': mercadoPagoCardToken.toJson(),
//         'identification_number': documentNumber,
//         'identification_type': idDocument.value,
//       });
//
//       print('Mercado Pago: ${mercadoPagoCardToken.toJson()}');
//
//     }
//
//   }
//
//   bool isValidForm (String documentNumber) {
//     if (cardNumber.value.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Ingresa el numero de la tarjeta');
//       return false;
//     }
//     if (expireDate.value.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Ingresa la fecha de vencimiento de la tarjeta');
//       return false;
//     }
//     if (cardHolderName.value.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Ingresa el nombre del titular');
//       return false;
//     }
//     if (cvvCode.value.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Ingresa el codigo de seguridad');
//       return false;
//     }
//     if (idDocument.value.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Selecciona el tipo de documento');
//       return false;
//     }
//     if (documentNumber.isEmpty) {
//       Get.snackbar('Formulario no valido', 'Ingresa el numero del documento');
//       return false;
//     }
//
//     return true;
//   }
//
  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber.value = creditCardModel.cardNumber;
    expireDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }
//
//   void getDocumentType() async {
//     var result = await mercadoPagoProvider.getDocumentsType();
//     documents.clear();
//     documents.addAll(result);
//   }
//
 }