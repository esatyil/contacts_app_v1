import 'package:contacts_app/data/entity/persons.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Persons person;

  DetailPage({required this.person});

  @override
  State<DetailPage> createState() => _DetailPageState();
}


class _DetailPageState extends State<DetailPage> {

  var tfPersonName = TextEditingController();
  var tfPersonPhoneNumber = TextEditingController();

  Future<void> updateContact (int personId, String personName, String personPhoneNumber)async{
    print("Contact updated: $personId - $personName - $personPhoneNumber");
  }

  //When detail page is opened, the text fields will be installed with current values.
  @override
  void initState(){
    super.initState();
    var person = widget.person;
    //updateContact(widget.person.personId, widget.person.personName, widget.person.personPhoneNum);
    tfPersonName.text = widget.person.personName;
    tfPersonPhoneNumber.text = widget.person.personPhoneNum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfPersonName,
                decoration: InputDecoration(
                  hintText: "Name"
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
                  updateContact(widget.person.personId, tfPersonName.text, tfPersonPhoneNumber.text);
                });
              }, child: Text("Update")),
            ],
          ),
        ),

      ),
    );
  }
}
