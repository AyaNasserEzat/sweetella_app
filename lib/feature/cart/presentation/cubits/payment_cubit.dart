import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_paymob_sdk/flutter_paymob_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  final Dio dio = Dio();
  String publicKey = "";
  Future<void> openCheckout({
    required String clientSecret,
    required String publicKey,
  }) async {
    final uri = Uri.https('eg.checkout.paymob.com', '/', {
      'publicKey': publicKey,
      'clientSecret': clientSecret,
    });

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched) {
      emit(PaymentFailure(message: 'Could not open Paymob Checkout'));
    }
  }

  Future<void> createPaymentIntent() async {
    emit(PaymentLoading());

    try {
      dio.interceptors.add(LogInterceptor(request: true, responseBody: true));
      final response = await dio.post(
        'https://accept.paymob.com/v1/intention/',
        options: Options(
          headers: {
            'Authorization': 'Token ',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'amount': 10000,
          'currency': 'EGP',
          'payment_methods': [4999212],
          'items': [
            {
              'name': 'Test Product',
              'amount': 10000,
              'description': 'Test payment',
              'quantity': 1,
            },
          ],
          'billing_data': {
            'first_name': 'Alaa',
            'last_name': 'Test',
            'email': 'test@example.com',
            'phone_number': '+201000000000',
            'apartment': 'NA',
            'building': 'NA',
            'street': 'NA',
            'floor': 'NA',
            'city': 'Cairo',
            'state': 'Cairo',
            'country': 'EG',
          },
          "notification_url":
              "https://hooks.paymob.com/4d269efd-3225-4e46-9f71-c022e14e832a",
        },
      );

      final clientSecret = response.data['client_secret'];

      emit(PaymentSuccess(clientSecret: clientSecret));
    } on DioException catch (e) {
      emit(
        PaymentFailure(
          message: e.response?.data.toString() ?? e.message ?? 'Payment failed',
        ),
      );
    } catch (e) {
      emit(PaymentFailure(message: e.toString()));
    }
  }

  Future<void> payWithSdk({required String clientSecret}) async {
    try {
      final paymobService = PaymobService();

      final result = await paymobService.payWithPaymob(
        publicKey: publicKey,
        clientSecret: clientSecret,
        customization: PaymobCustomization(
          appName: 'Sweetella',
          showTransactionResult: true,
        ),
      );

      if (result.isSuccessful) {
        emit(PaymentFSuccess(transactionDetails: result.transactionDetails));
      } else if (result.isFailure) {
        emit(PaymentFailure(message: result.errorMessage ?? 'Payment failed'));
      } else if (result.isPending) {
        emit(PaymentPending());
      }
    } catch (e) {
      emit(PaymentFailure(message: e.toString()));
    }
  }
}
