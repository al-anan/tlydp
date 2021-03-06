import 'package:flutter/material.dart';
import 'package:tlydp/backend_utils/api.dart';
import 'package:tlydp/backend_utils/globals.dart';
import 'package:tlydp/backend_utils/model.dart';
import 'package:tlydp/data/utils.dart';
import 'package:tlydp/reusables/navbar/nav.dart';
import 'package:tlydp/screens/find_a_duck.dart';
import 'package:tlydp/shared/menu_drawer.dart';
import 'package:tlydp/widgets/app_button.dart';
import 'package:tlydp/widgets/user_found_duck_card.dart';

class DuckFinds extends StatefulWidget {
  const DuckFinds({Key? key}) : super(key: key);

  @override
  DuckFindsState createState() => DuckFindsState();
}

class DuckFindsState extends State<DuckFinds> {  
  List<DuckModel> duckFinds = Utils.getDucksFoundByUser(currentUser.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("TLYDP",
              style: TextStyle(
                color: Color.fromARGB(255, 185, 137, 109),
                fontSize: 45,
                fontFamily: "CherryBomb",
              )),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(0.5),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Image(
                  image: AssetImage("assets/images/yellow-outlined-duck.png"),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
      drawer: const MenuDrawer(),
      body: Container(
              child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: Text("Ducks I've Found",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CherryBomb",
                      fontSize: 40,
                    ),
                  )
                ),
                (duckFinds.length > 0 ? Text("") : 
                const Text("\nNothing here yet...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 185, 137, 109),
                      fontSize: 28,
                    ),
                  )),
                Expanded(
                  child: (duckFinds.length > 0 ? ListView.builder(
                    itemCount: duckFinds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Container(
                          child: UserFoundDuckCard(
                            duckFinds[index].duckName,
                            duckFinds[index].locationFoundLat!,
                            duckFinds[index].locationFoundLng!,
                            duckFinds[index].image!
                          ),
                        ),
                        onTap: () {
                          showDuckInfo(
                            context, 
                            duckFinds[index].duckName,
                            duckFinds[index].locationPlacedLat,
                            duckFinds[index].locationPlacedLng,
                            duckFinds[index].image,
                            duckFinds[index].comments
                          );
                        },
                      );
                    },
                  ): Center(child: AppButton(text: "Find A Duck", onClick: () {
                    Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => FindADuck()));
                  }))),
                ),
                const Nav()
               ]
              ),
            ),
    );
  }
}

showDuckInfo(context, duckName, locationFoundLat, locationFoundLng, image, comments) {
  return showDialog(
    context: context, 
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(-6, 6),
              ),],
              border: Border.all(
                color: const Color.fromARGB(255, 185, 137, 109),
                width: 3
              ),
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 241, 216, 129),
            ),
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 500,
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      image: NetworkImage(image),
                      height: 250,
                    )
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(duckName, 
                      style: const TextStyle(
                        fontFamily: "CherryBomb",
                        fontSize: 50,
                        color: Color.fromARGB(255, 255, 112, 112)
                      ),
                )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("$locationFoundLat, $locationFoundLng", 
                        style: const TextStyle(
                          fontFamily: "CherryBomb",
                          fontSize: 30,
                          color: Color.fromARGB(255, 255, 112, 112)
                        ),
                        maxLines: 3,
                )),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(comments, 
                        style: const TextStyle(
                          fontFamily: "CherryBomb",
                          fontSize: 18,
                          color: Color.fromARGB(255, 185, 137, 109)
                        ),
                        maxLines: 10,
                ))
              ]
            )
          ),
        ),
      );
    }
  );
}