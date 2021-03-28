class UserAccount {
  String name;
  String email;
  String city;
  String phone;
  String country;

  UserAccount({
    this.name,
    this.email,
    this.city,
    this.country,
    this.phone,
  });

  dynamic toMap() => {
        'username': name,
        'email': email,
        'city': city,
        'phone': phone,
        'country': country,
      };
}
