import 'package:covid_tracker/Services/state_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: searchController,
                decoration: InputDecoration(
                  hintText: ('Search with country name'),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: statesServices.countriesListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>>snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index){
                         return Shimmer.fromColors(

                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(height: 50,
                                      width: 50,
                                      color: Colors.white,),
                                    title: Container(height: 10,
                                      width: 89,
                                      color: Colors.white,),
                                    subtitle: Container(height: 10,
                                      width: 89,
                                      color: Colors.white,),
                                  )
                                ],
                              ));
                        },
                      );}
                    else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];
                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                        name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                        totalCases: snapshot.data![index]['totalCases'],
                                        deaths: snapshot.data![index]['deaths'],
                                        totalDeaths: snapshot.data![index]['totalDeaths'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        tests: snapshot.data![index]['tests'],


                                      ))
                                      );
                              },
                                    child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot
                                                  .data![index]['countryInfo']['flag'])),
                                      title: Text(snapshot.data![index]['country']
                                          .toString()),
                                      subtitle: Text(
                                          snapshot.data![index]['deaths']
                                              .toString()),
                                    ),
                                  )
                                ],
                              );
                            }
                            else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                   onTap:(){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen(
                                name: snapshot.data![index]['country'],
                                image: snapshot.data![index]['countryInfo']['flag'],
                                totalCases: snapshot.data![index]['totalCases'],
                                deaths: snapshot.data![index]['deaths'],
                                totalDeaths: snapshot.data![index]['totalDeaths'],
                                todayRecovered: snapshot.data![index]['todayRecovered'],
                                active: snapshot.data![index]['active'],
                                critical: snapshot.data![index]['critical'],
                                tests: snapshot.data![index]['tests'],


                              ))
                              );

                              },
                                    child: ListTile(
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot
                                                  .data![index]['countryInfo']['flag'])),
                                      title: Text(snapshot.data![index]['country']
                                          .toString()),
                                      subtitle: Text(
                                          snapshot.data![index]['deaths']
                                              .toString()),
                                    ),
                                  )
                                ],
                              );
                            }
                            else{
                                return Container();
                            }

                          }

                      );
                    }
                  }
                  )
            )],
        ),
      ),
    );
  }
}
