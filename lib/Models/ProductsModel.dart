class Products {
  final int id;
  final String title;
  final String category;
  final String image;
  final double price;
  final double rate;

  Products(
      {required this.id,
        required this.title,
        required this.category,
        required this.image,
        required this.price,
        required this.rate});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        image: json['image'],
        rate: double.parse(json['rating']['rate'].toString()),
        price: double.parse(json['price'].toString()));
  }
}