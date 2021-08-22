class Member {
  Member({
    required this.idNumber,
    required this.password,
    required this.batch,
    required this.name,
    required this.gmail,
    this.regularUpdates = false,
    this.excited = true,
  });

  String idNumber;

  String name;

  String gmail;

  String password;

  int batch;

  bool regularUpdates;

  bool excited;
}
