class UserAccount {
  String id;
  String name;
  String email;
  String city;
  String phone;
  String country;
  String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/solution-challenge-b89fb.appspot.com/o/user_image%2Fuser.png?alt=media&token=9e0e8709-9dfa-4b0b-a3af-2c7c7eb633a9';
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
