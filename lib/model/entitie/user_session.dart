class UserSession{

  int? _id;
  String? _token, _firstName, _lastName, _email, _rol, _userImage;

  static final UserSession _singleton = UserSession._internal();

  factory UserSession(){
    return _singleton;
  }

  userLogin(int id, String token, String firstName, String lastName, String email, String rol, String userImage){
    _id = id;
    _token = token;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _rol = rol;
    _userImage = userImage;
  }

  int getId(){ return _id!; }
  String getFirstName() { return _firstName!; }
  String getLastName() { return _lastName!; }
  String getEmail() { return _email!; }
  String getToken() { return _token!; }
  String getRol(){ return _rol!; }
  String getImage() { return _userImage!; }

  UserSession._internal();

}