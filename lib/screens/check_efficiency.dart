import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuel_efficiency/models/vehicle.dart';

class CheckEfficiency extends StatelessWidget {
  List<Vehicle> listData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          title: const Text("Vehicle Health"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.done) {
              if (snapShot.hasData) {
                final List<DocumentSnapshot> documents = snapShot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final model = documents[index]['model'];

                    final brand = documents[index]['brand'];

                    final fuelefficiency = documents[index]['fuel_capacity'];

                    final age = documents[index]['age'];
                    Color color;

                    if (fuelefficiency >= 15 && age <= 5) {
                      color = Colors.green;
                    } else if (fuelefficiency >= 15 && age >= 5) {
                      color = Colors.amber;
                    } else {
                      color = Colors.red;
                    }

                    return Container(
                      margin: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          color: color, borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(
                          '$brand $model',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          'Year: $age, Fuel Efficiency: $fuelefficiency km/l',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapShot.hasError) {
                return Center(
                  child: Text(snapShot.error.toString()),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
            return const Text("Went wrong");
          },
        ));
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() {
    final db = FirebaseFirestore.instance;
    return db.collection('vehicles').get();
  }

}
