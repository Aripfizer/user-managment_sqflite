class User {
    final int? id;
    final int? isAsset;
    final String firstname;
    final String lastname;
    final String birthday;
    final String adress;
    final String phone;
    final String mail;
    final String gender;
    final String picture;
    final String citation;

    User(this.id, this.isAsset, this.firstname, this.lastname, this.birthday, this.adress,
      this.phone, this.mail, this.gender, this.picture, this.citation);


    @override
  String toString() {
    return 'User{id: $id, isAsset: $isAsset, firstname: $firstname, lastname: $lastname, birthday: $birthday, adress: $adress, phone: $phone, mail: $mail, gender: $gender, picture: $picture, citation: $citation}';
  }

  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'isAsset' : isAsset,
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday,
        'adress': adress,
        'phone': phone,
        'mail': mail,
        'gender': gender,
        'picture': picture,
        'citation': citation,
      };
    }

    factory User.fromMap(Map<String, dynamic> map) => User(
      map['id'],
      map['isAsset'],
      map['firstname'],
      map['lastname'],
      map['birthday'],
      map['adress'],
      map['phone'],
      map['mail'],
      map['gender'],
      map['picture'],
      map['citation'],
    );

}