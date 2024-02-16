class ClubModel{
  int id;
  String name;
  String imageUrl;
  String address;
  String province;
  String description;
  var minPrice;



 


  ClubModel({
    required this.id,
    required this.minPrice,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.address,
    required this.province
  });


  factory ClubModel.fromJson(Map<String, dynamic> json){
    return ClubModel(
      id: json['id'],
      name: json['name'],
      minPrice: json['min_price'],
      description: json['description'],
      imageUrl: json['image_url'],
      address: json['address'],
      province: json['province']['name'],
      

      
    );
  }
}