import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test_api_application/components/employee_list.dart';
import 'package:test_api_application/components/info_box.dart';
import 'package:test_api_application/components/profile_thumb.dart';
import 'package:test_api_application/employeeData.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<EmployeeData> data = List<EmployeeData>();
  bool showLoader = false;

  Future<bool> getData(BuildContext context) async {
    Response response =
        await get('http://dummy.restapiexample.com/api/v1/employees');

    int code = response.statusCode;

    if (code != 200) {
      setState(() {
        showLoader = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error, Status Code : $code!'),
        ),
      );
      return false;
    } else {
      setState(() {
        showLoader = false;
      });
      data.clear();
      jsonDecode(response.body)['data'].toList().forEach((dataList) {
        data.add(EmployeeData.fromMap(dataList));
      });
      return true;
    }
  }

  Future<Map<String, dynamic>> postData(
      BuildContext context, String name, String salary, String age) async {
    final Response response = await post(
      'http://dummy.restapiexample.com/api/v1/create',
      body: {
        "name": name,
        "salary": salary,
        "age": age,
      },
    );

    int code = response.statusCode;

    if (code == 200) {
      Map<String, dynamic> receivedData = {
        "message": jsonDecode(response.body)['message'],
        "status": jsonDecode(response.body)['status'],
        "data": EmployeeData(
          employee_name: jsonDecode(response.body)['data']['name'],
          employee_salary:
              int.parse(jsonDecode(response.body)['data']['salary']),
          employee_age: int.parse(jsonDecode(response.body)['data']['age']),
          id: jsonDecode(response.body)['data']['id'],
          profile_image: '',
        ),
      };
      setState(() {
        showLoader = false;
      });
      return receivedData;
    } else {
      setState(() {
        showLoader = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Error, Status Code : $code!'),
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showLoader,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.teal),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Test API Application',
          ),
          backgroundColor: Colors.teal,
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Builder(
                  builder: (context) => MaterialButton(
                    onPressed: () => getRequest(context),
                    child: Text(
                      ' GET ',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 5.0,
                    color: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 14.0,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => MaterialButton(
                    onPressed: () => postRequest(context),
                    child: Text(
                      'POST',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    elevation: 5.0,
                    color: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 14.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getRequest(BuildContext context) async {
    setState(() {
      showLoader = true;
    });
    bool gotData = await getData(context);
    if (gotData) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
        ),
        builder: (context) => EmployeeList(data: data),
      );
    }
  }

  void postRequest(BuildContext context) async {
    setState(() {
      showLoader = true;
    });
    Map<String, dynamic> gotData =
        await postData(context, 'Charles Xavier', '32000', '21');
    if (gotData != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
          ),
        ),
        builder: (context) => Container(
          height: 130.0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'ID : ' + gotData['data'].id.toString(),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ProfileThumb(
                          initial: gotData['data']
                              .employee_name
                              .substring(0, 1)
                              .toString()),
                    ),
                    Expanded(
                      flex: 4,
                      child: InfoBox(data: gotData['data']),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      );
    }
  }
}
