import 'package:contacts_app/data/entity/persons.dart';
import 'package:contacts_app/ui/views/detail_page.dart';
import 'package:contacts_app/ui/views/register_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //To check if we are currently searching
  bool isSearching = false;

  //search textfield controller
  var tfSearchWord = TextEditingController();

  Future<void> search(String searchWord) async {
    print("Search person : $searchWord");
  }

  //To show saved contacts
  Future<List<Persons>> installPersons() async {
    var personsList = <Persons>[];
    var p1 = Persons(personId: 1, personName: "Eric", personPhoneNum: "111");
    var p2 = Persons(personId: 2, personName: "Marie", personPhoneNum: "222");
    var p3 = Persons(personId: 3, personName: "Jack", personPhoneNum: "333");
    personsList.add(p1);
    personsList.add(p2);
    personsList.add(p3);

    return personsList;
  }

  //To remove person
  Future<void> removePerson(int personId) async {
    print("Remove $personId ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: tfSearchWord,
                decoration: InputDecoration(hintText: "Search.."),
                onChanged: (tfSearchWord) {
                  search(tfSearchWord);
                },
              )
            : Text("Persons"),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                  icon: Icon(Icons.clear))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: Icon(Icons.search))
        ],
      ),
      body: FutureBuilder<List<Persons>>(
          future: installPersons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var personsList = snapshot.data;
              return ListView.builder(
                itemCount: personsList!.length,
                itemBuilder: (context, index) {
                  //index = itemCount
                  var person = personsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                    person: person,
                                  ))).then((value) {
                        print("Returned to homepage");
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    person.personName,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(person.personPhoneNum),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              " Are you sure to remove ${person.personName} ?"),
                                          action: SnackBarAction(
                                            label: "Yes",
                                            onPressed: () {
                                              removePerson(person.personId);
                                            },
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.black54,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()))
              .then((value) {
            print("Returned to homepage. Value : $value");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
