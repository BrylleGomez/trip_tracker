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
      startHour: fields[0] as int,
      startMinute: fields[1] as int,
      endHour: fields[2] as int,
      endMinute: fields[3] as int,
      date: fields[4] as String,
      startMileage: fields[5] as int,
      endMileage: fields[6] as int,
      routeKey: fields[7] as int,
      notes: fields[8] as String,
      tripDuration: fields[9] as int,
      tripDistance: fields[10] as int,
      weekday: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.startHour)
      ..writeByte(1)
      ..write(obj.startMinute)
      ..writeByte(2)
      ..write(obj.endHour)
      ..writeByte(3)
      ..write(obj.endMinute)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.startMileage)
      ..writeByte(6)
      ..write(obj.endMileage)
      ..writeByte(7)
      ..write(obj.routeKey)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.tripDuration)
      ..writeByte(10)
      ..write(obj.tripDistance)
      ..writeByte(11)
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
