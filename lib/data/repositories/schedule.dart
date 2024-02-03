class ScheduleModel {
  int id;
  var date;
  var startTime;
  var endTime;
  var courtId;
  var priceId;
  var statusId;
  var status;
  var price;
  var statusColor;
  var court;
  var players;
  var priceValue;
  // String code;
  // var today;
  // var yesterday;
  // var month;
  // var year;


  ScheduleModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.courtId,
    required this.priceId,
    required this.statusId,
    required this.status,
    required this.statusColor,
    required this.price,
    required this.court,
    required this.players,
    required this.priceValue

    // required this.code,
    // required this.today,
    // required this.year,
    // required this.yesterday,
    // required this.month,

  });


  factory ScheduleModel.fromJson(Map<String, dynamic> json){
    return ScheduleModel(
      id: json['id'],
      date: json['date'],
      players: json['players'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      courtId: json['court_id'],
      priceId: json['price_id'],
      statusId: json['status_id'],
      status: json['status']['name'],
      statusColor: json['status']['color'],
      price: json['price']['name'],
      priceValue: json['price']['price'],
      court: json['court']['name'],
      // code: json['user']['code'],
      // today: json['dashboard']['today'],
      // yesterday: json['dashboard']['yesterday'],
      // month: json['dashboard']['month'],
      // year: json['dashboard']['year'],

    );
  }
}