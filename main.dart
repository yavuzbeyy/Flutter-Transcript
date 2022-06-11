import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models2.dart';

void main() {
  runApp(MyApp());
}
final List<Item> _data = generateItems(1);

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transkript"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future:
            jsonOku(),
            builder: (context, snapshot) {
              var items = snapshot.data as List<Dersler>;
             

              //var myData = jsonDecode(snapshot.data.toString());
              //List myData2 = jsonDecode(snapshot.data.toString())['Dersler'] as List;
              //List<Dersler> mydata3 = myData2.map((x)=>Dersler.fromJson(x)).toList();
              //print(mydata3);
              // Dersler dersler = Dersler.fromJson(myData2);



              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                 // Dersler(myData[index]['kitapAdi'],myData[index]['yazar']);
                  // burda yapıcı methoda direk yollamaya çalıştım olmadı
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: ExpansionPanelList(
                              expansionCallback: (int index2, bool isExpanded) {
                                setState(() {
                                  _data[index2].isExpanded = !isExpanded;
                                });
                              },
                              children: _data.map<ExpansionPanel>((Item item) {
                                return ExpansionPanel(
                                  headerBuilder: (BuildContext context, bool isExpanded) {
                                    return ListTile(
                                      title: Text(item.headerValue),
                                    );
                                  },
                                  body:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Spacer(),
                                        Expanded(
                                          flex: 3,
                                          child:
                                          ListTile(
                                            title: const Text('Ders Adı',textAlign: TextAlign.center),
                                            subtitle: Text(items[index].dersAdi.toString(),textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child:
                                          ListTile(
                                            title: const Text('Harf Notu',textAlign: TextAlign.center),
                                            subtitle: Text(items[index].harfNotu.toString(),
                                              textAlign: TextAlign.center,style:
                                            TextStyle(
                                          color: Colors.red),),
                                          ),
                                        ),
                                        Spacer(),
                                      ]
                                  ),
                                  isExpanded: item.isExpanded,
                                );
                              }).toList(),
                            ),
                          ),
                          flex: 2,
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items == null ? 0 : items.length,
              );
            },
          ),
        ),
      ),
    );
  }
  Future<List<Dersler>>jsonOku() async {
    final jsondata = await rootBundle.loadString('assets/data.json');

    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => Dersler.fromJson(e)).toList();

  }
}
