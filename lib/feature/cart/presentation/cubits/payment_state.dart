part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentPending extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String clientSecret;

  PaymentSuccess({required this.clientSecret});
}

class PaymentFSuccess extends PaymentState {
  final transactionDetails;

  PaymentFSuccess({required this.transactionDetails});
}

class PaymentFailure extends PaymentState {
  final String message;

  PaymentFailure({required this.message});
}
