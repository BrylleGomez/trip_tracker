// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prelim_trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrelimTripAdapter extends TypeAdapter<PrelimTrip> {
  @override
  final int typeId = 2;

  @override
  PrelimTrip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrelimTrip(
      startTime: fields[0] as DateTime?,
      endTime: fields[1] as DateTime?,
      startMileage: fields[2] as int?,
      endMileage: fields[3] as int?,
      routeKey: fields[4] as int?,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrelimTrip obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrelimTripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
