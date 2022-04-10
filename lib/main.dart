import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcul de Calorie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Calcul de Calorie'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var couleurPrim;
  bool? sexe;
  int taille = 100;
  double? poids;
  double? activite;
  int? age;

  @override
  void initState() {
    sexe = false;
    couleurPrim = (sexe!) ? Colors.blue : Colors.red;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: couleurPrim,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.all(25),
              ),
              const Text(
                "Remplissez tous les champs pour obtenir votre besoin journalier en calories.",
                textAlign: TextAlign.center,
                textScaleFactor: 1.25,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 7 / 8,
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Femme",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          Switch(
                            value: sexe ?? false,
                            onChanged: (bool b) {
                              setState(() {
                                sexe = b;
                                couleurPrim = (b) ? Colors.blue : Colors.red;
                              });
                            },
                            activeColor: Colors.blue,
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: Colors.red,
                          ),
                          const Text(
                            "Homme",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      ElevatedButton(
                        onPressed: montrerDate,
                        child: Text((age == null)
                            ? "Appuyer pour entrer votre age"
                            : "Votre age est de: $age"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => couleurPrim),
                          foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.white),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      Text(
                        "Votre taille est de $taille cm",
                        style: TextStyle(
                          color: couleurPrim,
                        ),
                      ),
                      Slider(
                        activeColor: couleurPrim,
                        min: 100,
                        max: 215,
                        value: taille.toDouble(),
                        onChanged: (double slider) {
                          setState(() {
                            taille = slider.toInt();
                          });
                        },
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Entrez votre poids en kilos",
                          focusColor: couleurPrim,
                        ),
                        onChanged: (String text) {
                          setState(() {
                            poids = double.tryParse(text);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Quelle est votre activité sportive ?",
                        style: TextStyle(
                          color: couleurPrim,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                activeColor: couleurPrim,
                                value: 0.5,
                                groupValue: activite,
                                onChanged: (double? value) {
                                  setState(() {
                                    activite = value;
                                  });
                                },
                              ),
                              Text(
                                "Faible",
                                style: TextStyle(
                                  color: couleurPrim,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                activeColor: couleurPrim,
                                value: 1.5,
                                groupValue: activite,
                                onChanged: (double? value) {
                                  setState(() {
                                    activite = value;
                                  });
                                },
                              ),
                              Text(
                                "Modere",
                                style: TextStyle(
                                  color: couleurPrim,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                activeColor: couleurPrim,
                                value: 2.0,
                                groupValue: activite,
                                onChanged: (double? value) {
                                  setState(() {
                                    activite = value;
                                  });
                                },
                              ),
                              Text(
                                "Forte",
                                style: TextStyle(
                                  color: couleurPrim,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          bottom: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                onPressed: validons,
                child: const Text("Calculer"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => couleurPrim),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> montrerDate() async {
    DateTime? choix = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (choix != null) {
      setState(() {
        age = DateTime.now().difference(choix).inDays ~/ 356;
      });
    }
  }

  void validons() {
    if ((age == null) || (poids == null) || (activite == null)) {
      alerte();
    } else {
      dialog();
    }
  }

  Future<void> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Erreur",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const SizedBox(
              child: Center(
                child: Text("Tous les champs ne sont pas remplis"),
              ),
              height: 40,
            ),
            contentPadding: const EdgeInsets.all(5),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
  }

  Future<void> dialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(10),
            children: <Widget>[
              Text(
                "Votre besoin en calories",
                style: TextStyle(
                  color: couleurPrim,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Votre besoin de base est de: ${(taille * 0.01 * age! * poids! * ((sexe!) ? 1 : 2)).toInt()}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Votre besoin avec activité sportive est de: ${(taille * 0.01 * age! * poids! * ((sexe!) ? 1 : 2) * activite! * 10).toInt()}",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => couleurPrim),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.white),
                ),
              )
            ],
          );
        });
  }
}
