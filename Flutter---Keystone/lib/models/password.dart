// ignore_for_file: unnecessary_this

class Password{
  final String id;
  final String userId;
  final String platformName;
  final String password;

  Password({
    required this.id,
    required this.userId,
    required this.platformName,
    required this.password,
  });

  factory Password.fromJson(Map<String, dynamic> json) => Password(
    id: json['id'],
    userId: json['userID'],
    platformName: json['platformName'],
    password: json['encryptedPassword'],
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'userID': this.userId,
    'platformName': this.platformName,
    'password': this.password,
  };

  Password copyFrom({
    String? userId,
    String? platformName,
    String? password,
  }) => Password(
    id: this.id,
    userId: userId ?? this.userId,
    platformName: platformName ?? this.platformName,
    password: password ?? this.password,
  );
}