import 'dart:convert';

/// Representational model of a user, following the database model.
/// Note: Any additions to the fields of this class must result to additions on the constructor and the factory
/// constructor.
class User {
  String _authenticationKey;
  String _username;
  String _firstName;
  String _lastName;
  int _savedOutages;
  int _sharedOutages;
  int _friends;

  ///Constructor that *must* set all the fields of the User model.
  User(String authenticationKey, String username, String firstName, String lastName,
      int savedOutages, int sharedOutages, int friends) {
    this._authenticationKey = authenticationKey;
    this._username = username;
    this._firstName = firstName;
    this._lastName = lastName;
    this._savedOutages = savedOutages;
    this._sharedOutages = sharedOutages;
    this._friends = friends;
  }

  ///Factory constructor that initializes a final variable from a json object.
  ///This is used to instantly create a User object from the user details response.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['authentication_key'] as String, json['username'] as String,
    json['first_name'] as String, json['last_name'] as String, json['saved_outages'] as int,
    json['shared_outages'] as int, json['friends'] as int);
  }

  ///Converts a User model to a json object based on the APIs specification.
  String toJson(User user){
    Map<String, dynamic> mapUser = {
      'authentication_key' : user._authenticationKey,
      'username' : user._username,
      'first_name' : user._firstName,
      'last_name' : user._lastName,
      'saved_outages' : user._savedOutages,
      'shared_outages' : user._sharedOutages,
      'friends' : user._friends
    };
    return jsonEncode(mapUser);
  }
}
