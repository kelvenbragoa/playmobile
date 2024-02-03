class MyScheduleModel{
  int id;
  var date;
  var startTime;
  var endTime;
  var court;


  MyScheduleModel({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.court,

  });


  factory MyScheduleModel.fromJson(Map<String, dynamic> json){
    return MyScheduleModel(
      id: json['id'],
      date: json['schedule']['date'],
      startTime: json['schedule']['start_time'],
      endTime: json['schedule']['end_time'],
      court: json['schedule']['court']['name'],
      // code: json['user']['code'],
      // today: json['dashboard']['today'],
      // yesterday: json['dashboard']['yesterday'],
      // month: json['dashboard']['month'],
      // year: json['dashboard']['year'],

    );
  }
}