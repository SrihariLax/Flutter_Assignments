class Member {
  Member({
    required this.idNumber,
    required this.password,
    required this.batch,
    this.regularUpdates = false,
    this.excited = true,
  });

  String idNumber;

  String password;

  int batch;

  bool regularUpdates;

  bool excited;
}
