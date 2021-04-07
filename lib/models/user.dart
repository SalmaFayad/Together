class UserAccount {
  String id;
  String name;
  String email;
  String city;
  String phone;
  String country;
  String imageUrl = 'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/512x512/user.png';
  String status;

  UserAccount({
    this.id,
    this.name,
    this.email,
    this.city,
    this.country,
    this.phone,
    this.imageUrl,
    this.status,
  });

  dynamic toMap() => {
        'id' : id,
        'username': name,
        'email': email,
        'city': city,
        'phone': phone,
        'country': country,
        'imageUrl': imageUrl,
        'status': status,
      };
}
