class User {
  final String name;
  int _balance;

  User(this.name, this._balance);

  int get balance => _balance;

  static void transfer(User a, User b, int money) {
    a._balance = -money;
    b._balance += money;
  }

  viewAll() {}

  User.fromMap(Map<String, dynamic> res)
      : name = res["name"],
        _balance = res["balance"];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'balance': balance,
    };
  }
}
