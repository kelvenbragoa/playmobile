class TransactionModel{
  var id;
  var transaction;
  var amount;
  var balance;
  var method;
  var firstName;
  var lastName;
  var email;
  var createdAt;



 


  TransactionModel({
    required this.id,
    required this.transaction,
    required this.amount,
    required this.balance,
    required this.method,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,

  });


  factory TransactionModel.fromJson(Map<String, dynamic> json){
    return TransactionModel(
      id: json['id'],
      transaction: json['transaction']['name'],
      amount: json['amount'],
      balance: json['balance'],
      method: json['method'],
      firstName: json['user']['name'],
      lastName: json['user']['surname'],
      email: json['user']['email'],
      createdAt: json['created_at'],
    );
  }
}