import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();


}

class _RegisterPageState extends State<RegisterPage> {
  var tfPersonName = TextEditingController();
  var tfPersonPhoneNumber = TextEditingController();

  Future<void> savePerson(String personName, String personPhoneNumber) async{
    print("$personName - $personPhoneNumber has been saved.");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register New"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfPersonName,
                decoration: InputDecoration(
                  hintText: "Name",

                ),

              ),
              TextField(
                controller: tfPersonPhoneNumber,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                ),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  savePerson(tfPersonName.text, tfPersonPhoneNumber.text);
                });
              }, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}
