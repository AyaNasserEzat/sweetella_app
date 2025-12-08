enum PaymentMethod { creditCard, paypal, applePay, cashOnDelivery }

class CardDetails {
  final String number;
  final String expiry;
  final String cvv;

  CardDetails({
    required this.number,
    required this.expiry,
    required this.cvv,
  });
}