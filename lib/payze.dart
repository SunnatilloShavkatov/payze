import 'payze_platform_interface.dart';

class Payze {
  Future<String?> pay({
    required PayCard card,
  }) {
    return PayzePlatform.instance.pay(card: card);
  }
}

class PayCard {
  PayCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.cvv,
    required this.expiryDate,
    required this.transactionId,
  });

  final String cardNumber;
  final String cardHolderName;
  final String cvv;
  final String expiryDate;
  final String transactionId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'transactionId': transactionId,
    };
  }
}
