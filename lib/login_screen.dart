import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:unicode_app/home_screen.dart';
import 'package:unicode_app/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonenocontroller = TextEditingController();

  String date = "";

  DateTime? selectdate;

  getCurrentDate() {
    DateTime currentDate = DateTime.now();

    setState(() {});
  }

  String? name;
  String? email;
  String? phoneno;

  final userdata = Hive.box("users_data");

  @override
  void initState() {
    super.initState();
    getCurrentDate();
    if (userdata.containsKey('name') &&
        userdata.containsKey('email') &&
        userdata.containsKey('phoneno')) {
      namecontroller.text = userdata.get("name");
      emailcontroller.text = userdata.get("email");
      phonenocontroller.text = userdata.get("phoneno");
    }
  }

  // @override
  // void dispose() {
  //   namecontroller.dispose();
  //   emailcontroller.dispose();
  //   phonenocontroller.dispose();
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: Image.asset("assets/welcome-back.png")),
                  ),
                ),
                Text(
                  "About You",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomTextField(
                    controller: namecontroller,
                    labelText: "Enter Name",
                    hintText: "Your Name",
                    errortext: "Enter your Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomTextField(
                    controller: emailcontroller,
                    labelText: "Enter Email",
                    hintText: "Your Email Id",
                    keyboardType: TextInputType.emailAddress,
                    errortext: "Enter Email Id",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomTextField(
                    controller: phonenocontroller,
                    labelText: "Enter Phone No",
                    hintText: "Your Phone No",
                    errortext: "Enter Phone number",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());

                      if (picked != null && selectdate != null) {
                        setState(() {
                          selectdate = picked;
                          date = DateFormat('yyyy-MM-dd').format(picked);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: Text(date.isEmpty
                        ? "Select BirthDate"
                        : "Selected Date:$date"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        name = namecontroller.text;
                        email = emailcontroller.text;
                        phoneno = phonenocontroller.text;
                        userdata.put("name", name);
                        userdata.put("email", email);
                        userdata.put("phoneno", phoneno);

                        if (formkey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                      name: name,
                                      date: date,
                                      email: email,
                                      phoneno: phoneno)));
                        }
                        setState(() {
                          userdata.put("name", name);
                          userdata.put("email", email);
                          userdata.put("phoneno", phoneno);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: Text("Proceed"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
