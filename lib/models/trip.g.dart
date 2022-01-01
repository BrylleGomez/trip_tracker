// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 3;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      startTime: fields[0] as DateTime,
      endTime: fields[1] as DateTime,
      startMileage: fields[2] as int,
      endMileage: fields[3] as int,
      routeKey: fields[4] as int,
      notes: fields[5] as String,
      tripDuration: fields[6] as int,
      tripDistance: fields[7] as int,
      date: fields[8] as DateTime,
      weekday: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.startTime)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.startMileage)
      ..writeByte(3)
      ..write(obj.endMileage)
      ..writeByte(4)
      ..write(obj.routeKey)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.tripDuration)
      ..writeByte(7)
      ..write(obj.tripDistance)
      ..writeByte(8)
      ..write(obj.date)
      ..writeByte(9)
      ..write(obj.weekday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
