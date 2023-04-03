//done
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zass/api/fetchsearchedproduct.dart';
import 'package:zass/api/securestorage.dart';
import 'package:zass/config/service-config.dart';
import 'package:zass/models/getproductsclass.dart';
import 'package:zass/provider/home_provider.dart';
import 'package:zass/widgets/showoneproduct.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // var id;
  void selectShowOneProduct(BuildContext ctx, int id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return ShowOneProduct(
        id: id,
      );
    }));
  }

  @override
  initState() {
    //token = SharedPrefs.getToken() ;
    super.initState();
    init();
  }

  var token;
  init() {
    SecureStorage storage = SecureStorage();
    storage.read().then((result) {
      setState(() {
        token = result;
        print(token + 'dddd');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Search Products'),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            //the enter name field

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.fromLTRB(5, 10, 10, 20),
                  child: Consumer<HomeProvider>(
                    builder: (context, searchProvider, child) => TextField(
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        hintText: 'Name ',
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onChanged: (v) {
                        searchProvider.changeName(v);
                      },
                    ),
                  ),
                ),

                //THE CATEGORY
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 5, 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Consumer<HomeProvider>(
                      builder: (context, searchProvider, child) =>
                          DropdownButton(
                        icon: Icon(Icons.arrow_drop_down_circle_outlined),
                        iconSize: 35,
                        hint: Text('   Select category  '),
                        underline: SizedBox(),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                        value: searchProvider.valueChoosen,
                        onChanged: (newValue) {
                          searchProvider.changeCategory(newValue);
                          searchProvider.editCategory();
                          print(searchProvider.id1);
                        },
                        items: searchProvider.listItem.map(
                          (valueItem) {
                            return DropdownMenuItem(
                              child: Text(
                                '   ' + valueItem,
                                style: TextStyle(color: Colors.indigo[300]),
                              ),
                              value: valueItem,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Consumer<HomeProvider>(
                    builder: (context, searchProvider, child) => TextField(
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      decoration: InputDecoration(
                        hintText: 'price ',
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.price_check,
                          color: Colors.deepOrange,
                        ),
                      ),
                      onChanged: (v) {
                        searchProvider.changePrice(v);
                      },
                    ),
                  ),
                ),
                //the text to view the date

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 7),
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.deepOrange, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              searchProvider.time,
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    //the Expiry date

                    Consumer<HomeProvider>(
                      builder: (context, searchProvider, child) =>
                          ElevatedButton(
                        onPressed: () async {
                          searchProvider.expirationDate = await showDatePicker(
                            context: context,
                            initialDate: searchProvider.expirationDate == null
                                ? DateTime.now()
                                : searchProvider.expirationDate!,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2030),
                          );
                          searchProvider.changeDate();
                        },
                        child: Text('Expiration date'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),

            Consumer<HomeProvider>(
              builder: (context, searchProvider, child) => ElevatedButton.icon(
                onPressed: () {
                  searchProvider.editChanges();
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: (Text(
                  'search',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Divider(
                height: 18.0,
                thickness: 0.6,
                color: Colors.deepOrange,
              ),
            ),

            Expanded(
              child: FutureBuilder<List<GetProducts>>(
                future: searchProvider.dataa.fetchSearchedProducts(
                  searchProvider.names,
                  searchProvider.prices,
                  searchProvider.ids,
                  searchProvider.dates,
                  searchProvider.p,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Container(
                          margin: EdgeInsets.all(20),
                          height: 200,
                          child: InkWell(
                            onTap: () {
                              int id = snapshot.data![index].id!;
                              selectShowOneProduct(context, id);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 16,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                      child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      ServerConfig.domainNameServer +
                                          snapshot.data![index].imageUrl!,
                                      // Utils.getproduct[index].imageUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                  Positioned(
                                    bottom: 16,
                                    left: 8,
                                    child: Text(
                                      snapshot.data![index].name!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //child: Text(addproduct[index].name),
                        ); //container prudacts name
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (!snapshot.hasData) {
                    return Text('no data yet');
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
