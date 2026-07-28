class AddressModel {
  final String? id;
  final String name;
  final String phone;
  final String country;
  final String city;
  final String streetName;
  final String floorNumber;
  final String buildingNumber;
  final String apartmentNumber;

  const AddressModel({
    this.id,
    required this.name,
    required this.phone,
    required this.country,
    required this.city,
    required this.streetName,
    required this.floorNumber,
    required this.buildingNumber,
    required this.apartmentNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      streetName: json['streetName'] ?? '',
      floorNumber: json['floorNumber'] ?? '',
      buildingNumber: json['buildingNumber'] ?? '',
      apartmentNumber: json['apartmentNumber'] ?? '',
    );
  }

  AddressModel copyWith({String? id}) {
    return AddressModel(
      id: id ?? this.id,
      name: name,
      phone: phone,
      country: country,
      city: city,
      streetName: streetName,
      floorNumber: floorNumber,
      buildingNumber: buildingNumber,
      apartmentNumber: apartmentNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'country': country,
      'city': city,
      'streetName': streetName,
      'floorNumber': floorNumber,
      'buildingNumber': buildingNumber,
      'apartmentNumber': apartmentNumber,
    };
  }
}
