// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_income_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesIncomeModelAdapter extends TypeAdapter<ExpensesIncomeModel> {
  @override
  final int typeId = 1;

  @override
  ExpensesIncomeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpensesIncomeModel(
      month: fields[4] as String?,
      day: fields[3] as String?,
      type: fields[5] as String?,
      category: fields[0] as CategoryModel?,
      amount: fields[1] as int?,
      description: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExpensesIncomeModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.month)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesIncomeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
