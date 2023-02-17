import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  String vehicleModel;
  int year;
  int fuelEffeciency;
  String vehicleBrand;

  Vehicle(
      {required this.vehicleBrand,
      required this.vehicleModel,
      required this.fuelEffeciency,
      required this.year});

  factory Vehicle.fromDataBase(
      DocumentSnapshot<Map<String, dynamic>> document) {
    return Vehicle(
      vehicleBrand: document.data.toString().contains('brand')
          ? document.get('brand')
          : 'not given',
      vehicleModel: document.data.toString().contains('model')
          ? document.get('model')
          : 'not given',
      fuelEffeciency: document.data.toString().contains('fuel_capacity')
          ? document.get('fuel_capacity')
          : 'not given',
      year: document.data.toString().contains('age')
          ? document.get('age')
          : 'not given',
    );
  }
}
