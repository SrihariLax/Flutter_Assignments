abstract class StorageService {
  Future<bool> getLoginData();

  Future<String> getName();

  Future<String> getIdNumber();

  Future saveLoginData(bool isLoggedIn);

  Future saveName(String name);

  Future saveIdNumber(String idNumber);
}
