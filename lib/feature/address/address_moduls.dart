
class Address {
  final String streetSearch;
  final String name;
  final String phone;
  final String houseNumber;
  final String floor;
  final String streetName;
  final String city;
  final String postCode;

  Address({
    required this.streetSearch,
    required this.name,
    required this.phone,
    required this.houseNumber,
    required this.floor,
    required this.streetName,
    required this.city,
    required this.postCode,
  });


  Address copyWith({
    String? streetSearch,
    String? name,
    String? phone,
    String? houseNumber,
    String? floor,
    String? streetName,
    String? city,
    String? postCode,
  }) {
    return Address(
      streetSearch: streetSearch ?? this.streetSearch,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      houseNumber: houseNumber ?? this.houseNumber,
      floor: floor ?? this.floor,
      streetName: streetName ?? this.streetName,
      city: city ?? this.city,
      postCode: postCode ?? this.postCode,
    );
  }
}
