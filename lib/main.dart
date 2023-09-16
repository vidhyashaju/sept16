import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Employee(),
    );
  }
}

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  Map resNew = {};

  Future<void> getData() async {
    String url = "https://dummy.restapiexample.com/api/v1/employees";
    Response res = await get(Uri.parse(url));
    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      resNew = response;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Employee Details Are...............",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ListView.builder(
            shrinkWrap: true,
            itemCount: resNew.length,
            itemBuilder: (BuildContext, index) {
              return Card(
                  color: Colors.redAccent,
                  shape: StadiumBorder(),
                  child: ListTile(
                    title: Column(
                      children: [
                        Text(
                            "Employee Name:${resNew['data'][index]['employee_name']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                            "Employee Salary:${resNew['data'][index]['employee_salary']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                            "Employee Age:${resNew['data'][index]['employee_age']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ));
            }),
      ]),
    );
  }
}
