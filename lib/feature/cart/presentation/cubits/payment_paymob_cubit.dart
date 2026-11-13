// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sweetella/feature/cart/presentation/cubits/payment_cubit.dart';

// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial());
//   final Dio dio = Dio();
//   void creatPaymentIntent() {
//     dio.post(
//       "https://accept.paymob.com/v1/intention/'",
//       options: Options(
//         headers: {
//           'Authorization': 'Token ',
//           'Content-Type': 'application/json',
//         },
//       ),
//       data: {
//         'amount': 10000,
//         'currency': 'EGP',
//         'payment_methods': [4999212],
//         'items': [
//           {
//             'name': 'Test Product',
//             'amount': 10000,
//             'description': 'Test payment',
//             'quantity': 1,
//           },
//         ],
//         'billing_data': {
//           'first_name': 'Alaa',
//           'last_name': 'Test',
//           'email': 'test@example.com',
//           'phone_number': '+201000000000',
//           'apartment': 'NA',
//           'building': 'NA',
//           'street': 'NA',
//           'floor': 'NA',
//           'city': 'Cairo',
//           'state': 'Cairo',
//           'country': 'EG',
//         },
//         "notification_url":
//             "https://hooks.paymob.com/4d269efd-3225-4e46-9f71-c022e14e832a",
//       },
//     );
//   }
// }
