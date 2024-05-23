// ignore_for_file: unnecessary_this

class User{
  final String id;
  final String username;
  final String email;
  final String pin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.pin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    pin: json['encryptedPin'],
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'username': this.username,
    'email': this.email,
    'pin': this.pin,
  };

  User copyFrom({
    String? username,
    String? email,
    String? password
  }) => User(
    id: this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    pin: password ?? this.pin,
  );
}