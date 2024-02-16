class CourtModel{
  int id;
  var limit;
  String name;
  String description;
  String imageUrl;
  String clubName;



 


  CourtModel({
    required this.id,
    required this.limit,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.clubName

   
  });


  factory CourtModel.fromJson(Map<String, dynamic> json){
    return CourtModel(
      id: json['id'],
      name: json['name'],
      limit: json['limit'],
      description: json['description'],
      imageUrl: json['image_url'],
      clubName: json['club']['name']
      

      
    );
  }
}