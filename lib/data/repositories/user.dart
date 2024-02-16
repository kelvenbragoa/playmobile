class UserData {
  int id;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String birthDate;
  var balance;
  // String code;
  // var today;
  // var yesterday;
  // var month;
  // var year;


  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.birthDate,
    required this.balance
    // required this.code,
    // required this.today,
    // required this.year,
    // required this.yesterday,
    // required this.month,

  });


  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      id: json['user']['id'],
      firstName: json['user']['name'],
      lastName: json['user']['surname'],
      mobile: json['user']['mobile'],
      email: json['user']['email'],
      birthDate: json['user']['birth_date'],
      balance: json['user']['balance'],
      // code: json['user']['code'],
      // today: json['dashboard']['today'],
      // yesterday: json['dashboard']['yesterday'],
      // month: json['dashboard']['month'],
      // year: json['dashboard']['year'],

    );
  }
}