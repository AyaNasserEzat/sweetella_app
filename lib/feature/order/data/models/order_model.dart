import 'package:cloud_firestore/cloud_firestore.dart';

enum OrderStatus { pending, confirmed, preparing, outForDelivery, delivered }

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  int get stepIndex {
    switch (this) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.confirmed:
        return 1;
      case OrderStatus.preparing:
        return 2;
      case OrderStatus.outForDelivery:
        return 3;
      case OrderStatus.delivered:
        return 4;
    }
  }

  static OrderStatus fromValue(String? value) {
    switch (value) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'preparing':
        return OrderStatus.preparing;
      case 'outForDelivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      case 'pending':
      default:
        return OrderStatus.pending;
    }
  }
}

class OrderModel {
  final String? id;
  final String addressName;
  final String addressPhone;
  final String addressLine;
  final String paymentMethod;
  final List<Map<String, dynamic>> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final double total;
  final OrderStatus status;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const OrderModel({
    this.id,
    required this.addressName,
    required this.addressPhone,
    required this.addressLine,
    required this.paymentMethod,
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.total,
    this.status = OrderStatus.pending,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return OrderModel(
      id: doc.id,
      addressName: data['addressName']?.toString() ?? '',
      addressPhone: data['addressPhone']?.toString() ?? '',
      addressLine: data['addressLine']?.toString() ?? '',
      paymentMethod: data['paymentMethod']?.toString() ?? 'Not selected',
      items: List<Map<String, dynamic>>.from(
        (data['items'] ?? []).map((item) => Map<String, dynamic>.from(item)),
      ),
      subtotal: (data['subtotal'] as num?)?.toDouble() ?? 0.0,
      shipping: (data['shipping'] as num?)?.toDouble() ?? 0.0,
      tax: (data['tax'] as num?)?.toDouble() ?? 0.0,
      discount: (data['discount'] as num?)?.toDouble() ?? 0.0,
      total: (data['total'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatusX.fromValue(data['status']?.toString()),
      createdAt: data['createdAt'] as Timestamp?,
      updatedAt: data['updatedAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressName': addressName,
      'addressPhone': addressPhone,
      'addressLine': addressLine,
      'paymentMethod': paymentMethod,
      'items': items,
      'subtotal': subtotal,
      'shipping': shipping,
      'tax': tax,
      'discount': discount,
      'total': total,
      'status': status.name,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  OrderModel copyWith({
    String? id,
    String? addressName,
    String? addressPhone,
    String? addressLine,
    String? paymentMethod,
    List<Map<String, dynamic>>? items,
    double? subtotal,
    double? shipping,
    double? tax,
    double? discount,
    double? total,
    OrderStatus? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      addressName: addressName ?? this.addressName,
      addressPhone: addressPhone ?? this.addressPhone,
      addressLine: addressLine ?? this.addressLine,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shipping: shipping ?? this.shipping,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
