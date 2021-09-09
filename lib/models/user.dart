class UserModel {
  final String uid;

  UserModel({this.uid});
}

class UserData {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;

  UserData(this.email, this.password, this.firstName, this.lastName,
      this.phoneNumber, this.address);
}
