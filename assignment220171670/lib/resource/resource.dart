import './../classes/member.dart';

/*
  The resource passed along between navigating pages.
*/
class Resource {
  Resource({
    this.membersList,
  });

  /*
    Stores list of valid members currently registered.
  */
  List<Member>? membersList;
}
