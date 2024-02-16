class ConfirmationSchedule{
  int id;
  var firstName;
  var lastName;
  var clubName;
  var email;
  var courtName;
  var date;
  var startTime;
  var endTime;
  var price;





 


  ConfirmationSchedule({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.clubName,
    required this.email,
    required this.courtName,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
  });




  factory ConfirmationSchedule.fromJson(Map<String, dynamic> json){
    return ConfirmationSchedule(
      id: json['id'],
      firstName: json['user']['name'],
      lastName: json['user']['surname'],
      email: json['user']['email'],
      clubName: json['schedule']['court']['club']['name'],
      courtName: json['schedule']['court']['name'],
      date: json['schedule']['date'],
      startTime: json['schedule']['start_time'],
      endTime: json['schedule']['end_time'],
      price: json['schedule']['price']['price'],


      
    );
  }
}