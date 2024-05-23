// ignore_for_file: unnecessary_this

class Seed{
  final String userId;
  final String seed;

  Seed({
    required this.userId,
    required this.seed,
  });

  factory Seed.fromJson(Map<String, dynamic> json) => Seed(
    userId: json['userID'],
    seed: json['seed'],
  );

  Map<String, dynamic> toJson() => {
    'userID': this.userId,
    'seed': this.seed,
  };

  Seed copyFrom({
    String? userId,
    String? seed
  }) => Seed(
    userId: userId ?? this.userId,
    seed: seed ?? this.seed,
  );
}