part of 'get_uuid_bloc.dart';

abstract class GetUuidEvent {
  const GetUuidEvent();
}

class FetchUuidEvent extends GetUuidEvent {
  const FetchUuidEvent();
}
