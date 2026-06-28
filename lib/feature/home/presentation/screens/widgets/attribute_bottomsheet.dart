// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:sweetella/core/widgets/custom_button.dart';
// // import 'package:sweetella/feature/cart/data/models/cart_model.dart';
// // import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
// // import 'package:sweetella/feature/home/data/models/product_model.dart';
// // import 'package:sweetella/feature/home/presentation/screens/widgets/product_attribute_section.dart';

// // void showAttributesBottomSheet(BuildContext context, ProductModel product) {
// //   showModalBottomSheet(
// //     context: context,
// //     isScrollControlled:
// //         true, // عشان لو الخصائص كتير الـ sheet يتمدد وميعملش Overflow
// //     shape: const RoundedRectangleBorder(
// //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //     ),
// //     builder: (context) {
// //       // بنستخدم StatefulBuilder عشان نقدر نحدث الـ UI جوه الـ BottomSheet لما المستخدم يختار حجم أو لون
// //       return StatefulBuilder(
// //         builder: (BuildContext context, StateSetter setModalState) {
// //           return Padding(
// //             padding: EdgeInsets.only(
// //               top: 20,
// //               left: 20,
// //               right: 20,
// //               bottom: MediaQuery.of(context).viewInsets.bottom + 20,
// //             ),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   product.name,
// //                   style: const TextStyle(
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 Text(
// //                   "price: ${product.price} \$ ",
// //                   style: TextStyle(color: Colors.grey[600], fontSize: 14),
// //                 ),
// //                 const SizedBox(height: 15),
// //                 const Divider(),
// //                 product.attributes.isEmpty
// //                     ? Container()
// //                     : ProductAttributesSection(productModel: product),

// //                 const SizedBox(height: 20),

// //                 // زرار التأكيد النهائي للإضافة للكارت
// //                 CustomButton(
// //                   onPressed: () {
// //                     context.read<CartCubit>().addToCart(
// //                       CartItemModel(
// //                         productId: product.id,
// //                         productName: product.name,
// //                         price: product.calculateFinalPrice({
// //                           for (var attr in product.attributes)
// //                             if (attr.options.isNotEmpty)
// //                               attr.title: attr.options.first.value,
// //                         }),
// //                         imageUrl: product.imageUrl,
// //                         quantity: 1,
// //                         selectedAttributes: product.attributes.isEmpty
// //                             ? {}
// //                             : {
// //                                 for (var attr in product.attributes)
// //                                   if (attr.options.isNotEmpty)
// //                                     attr.title: attr.options.first.value,
// //                               },
// //                       ),
// //                     );
// //                   },
// //                   text: "Confirm addition to cart",
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       );
// //     },
// //   );
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sweetella/core/widgets/custom_button.dart';
// import 'package:sweetella/feature/cart/data/models/cart_model.dart';
// import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
// import 'package:sweetella/feature/home/data/models/product_model.dart';
// import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
// import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_state.dart';
// import 'package:sweetella/feature/home/presentation/screens/widgets/product_attribute_section.dart';

// void showAttributesBottomSheet(BuildContext context, ProductModel product) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (bottomSheetContext) {
//       // 1. Wrap everything with the ProductSelectionCubit provider
//       return BlocProvider(
//         create: (context) => ProductAttributesCubit(),
//         child: BlocBuilder<ProductAttributesCubit, int>(
//           builder: (context, state) {
//             final selectionCubit = context.read<ProductAttributesCubit>();

//             return Padding(
//               padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom + 20,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   // 2. Display the live calculated price dynamically
//                   Text(
//                     "Price: \$${selectionCubit.calculatedPrice.toStringAsFixed(2)}",
//                     style: TextStyle(
//                       color: Colors.green[700],
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   const Divider(),

//                   product.attributes.isEmpty
//                       ? const SizedBox()
//                       : ProductAttributesSection(productModel: product),

//                   const SizedBox(height: 20),

//                   // 3. Submit the true selected state choices to your CartCubit
//                   CustomButton(
//                     onPressed: () {
//                       // Access your existing UI context context to read CartCubit
//                       bottomSheetContext.read<CartCubit>().addToCart(
//                         CartItemModel(
//                           productId: product.id,
//                           productName: product.name,
//                           // Pass calculated price as an integer
//                           price: selectionCubit.calculatedPrice.toInt(),
//                           imageUrl: product.imageUrl,
//                           quantity: 1,
//                           // Directly pass the selected attributes map stored in the Cubit State
//                           selectedAttributes: state.selectedAttributes,
//                         ),
//                       );
//                       Navigator.pop(context); // Close sheet on completion
//                     },
//                     text: "Confirm addition to cart",
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       );
//     },
//   );
// }
