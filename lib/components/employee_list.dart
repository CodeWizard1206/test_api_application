import 'package:flutter/material.dart';
import 'package:test_api_application/components/info_box.dart';
import 'package:test_api_application/components/profile_thumb.dart';
import 'package:test_api_application/employeeData.dart';

class EmployeeList extends StatelessWidget {
  final List<EmployeeData> data;
  const EmployeeList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ProfileThumb(
                      initial:
                          data[index].employee_name.substring(0, 1).toString()),
                ),
                Expanded(
                  flex: 4,
                  child: InfoBox(data: data[index]),
                ),
              ],
            ),
          );
        },
        itemCount: data.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            thickness: 1.0,
          );
        },
      ),
    );
  }
}
