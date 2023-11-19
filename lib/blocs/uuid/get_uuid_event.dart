part of 'get_uuid_bloc.dart';

abstract class GetUuidEvent {

}

class FetchUuidEvent extends GetUuidEvent {
  FetchUuidEvent({
    required this.userName,
  });
  final String userName;
}
