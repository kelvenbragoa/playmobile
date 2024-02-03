class PaymentModel{
  int id;
  var amount;
  String name;
  String title;
  String obs;
  String createdAt;
  String firstName;
  String lastName;
  String latitude;
  String longitude;



 


  PaymentModel({
    required this.id,
    required this.amount,
    required this.name,
    required this.title,
    required this.obs,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.latitude,
    required this.longitude

   
  });


  factory PaymentModel.fromJson(Map<String, dynamic> json){
    return PaymentModel(
      id: json['id'],
      name: json['fee']['name'],
      amount: json['amount'],
      title: json['title'],
      obs: json['obs'],
      createdAt: json['created_at'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],

      
    );
  }
}