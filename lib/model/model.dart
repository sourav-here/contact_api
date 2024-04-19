class ContactApi {
  String id;
  String name;
  String phone;
  String email;
  String address;

  ContactApi({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  factory ContactApi.fromJson(Map<String, dynamic> json) {
    return ContactApi(
        id: json['_id'],
        name: json['name'],
        phone: json['phone'].toString(),
        email: json['email'],
        address: json['address']);
  }
}
