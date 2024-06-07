import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request = "https://api.hgbrasil.com/finance?key=d18b57f7";

void main() {
  runApp(const MaterialApp(
    home: Conversor(),
  ));
}

class Conversor extends StatefulWidget {
  const Conversor({Key? key}) : super(key: key);

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  var realController = TextEditingController();
  var dolarController = TextEditingController();
  var euroController = TextEditingController();
  late double dolar;
  late double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("\$ Conversor de moeda\$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando...",
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os dados...",
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "Reais",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                        style: const TextStyle(color: Colors.amber, fontSize: 25),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: realController,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "Dolares",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                        style: const TextStyle(color: Colors.amber, fontSize: 25),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: dolarController,
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "Euros",
                            labelStyle: TextStyle(color: Colors.amber),
                            border: OutlineInputBorder(),
                            prefixText: "£\$"),
                        style: const TextStyle(color: Colors.amber, fontSize: 25),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: euroController,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                );
              }
          }
        }),
      ),
    );
  }

  Future<Map> getData() async {
    var url = Uri.parse(request);
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }
}
