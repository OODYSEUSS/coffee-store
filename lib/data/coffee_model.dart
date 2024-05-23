// class Coffee {
//   final String id;
//   final String name;
//   final String topping;
//   final String description;
//   final double point;
//   final double price;
//   final String imageUrl;

//   Coffee({
//     required this.id,
//     required this.name,
//     required this.topping,
//     required this.description,
//     required this.point,
//     required this.price,
//     required this.imageUrl,
//   });

//   factory Coffee.fromJson(Map<dynamic, dynamic> json) {
//     return Coffee(
//       id: json['id'],
//       name: json['name'],
//       topping: json['topping'],
//       description: json['description'],
//       point: json['point'],
//       price: json['price'],
//       imageUrl: json['image_url'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'topping': topping,
//       'description': description,
//       'point': point,
//       'price': price,
//       'image_url': imageUrl,
//     };
//   }
// }

class Coffee {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String topping;
  final String description;
  final double point;

  Coffee({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.topping,
    required this.description,
    required this.point,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      price: json['price'],
      topping: json['topping'],
      point: json['point'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'price': price,
      'topping': topping,
      'description': description,
      'point': point,
    };
  }
}
