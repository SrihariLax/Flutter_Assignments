import '/model/member.dart';

abstract class AuthService {
  Future registerMember(Member member);

  Future loginMember(String idNumber, String password);

  Future googleSignIn();

  Future signOut();
}
