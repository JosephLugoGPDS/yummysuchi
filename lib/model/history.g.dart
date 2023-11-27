// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

History _$HistoryFromJson(Map<String, dynamic> json) => History(
      name: json['name'] as String,
      after: json['after'] as int,
      before: json['before'] as int,
      date: json['date'] as String,
      isUp: json['isUp'] as bool,
    );

Map<String, dynamic> _$HistoryToJson(History instance) => <String, dynamic>{
      'name': instance.name,
      'after': instance.after,
      'before': instance.before,
      'date': instance.date,
      'isUp': instance.isUp,
    };
