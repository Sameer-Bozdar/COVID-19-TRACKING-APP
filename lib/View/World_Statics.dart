import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../CountriesList.dart';
import '../Model/world_states_model.dart';
import '../Services/state_services.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
    final colorList =<Color> [
      const Color(0xff4285F4),
      const Color(0xff1aa260),
      const  Color(0xffde5246),
      const Color(0xff003d00),
      const  Color(0xffffff6b),
    ];


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10,right: 10,bottom: 5),
          child: Column(
            children: [
                SizedBox(height: MediaQuery.of(context).size.height* .01),
             FutureBuilder(
                 future: statesServices.fetchWorldStates(),
                 builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
              if(!snapshot.hasData){
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                    controller: _controller,
                  ),
                );

              }else{
                return Column(
                  children: [
                    PieChart(
                      dataMap :  {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                       "Recovered":double.parse(snapshot.data!.recovered!.toString()),
                        "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                        "critical": double.parse(snapshot.data!.critical!.toString()),
                        "todayDeaths": double.parse(snapshot.data!.todayDeaths!.toString()),

                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartRadius: MediaQuery.of(context).size.width/3.2,
                      animationDuration:(Duration(milliseconds: 1200)),
                      legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      chartType: ChartType.ring,
                      colorList: colorList,
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height* .06),
                      child: Card(
                          child:Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths!.toString()),
                              ReusableRow(title: 'critical', value: snapshot.data!.critical!.toString()),
                              ReusableRow(title: 'TotalDeaths', value: snapshot.data!.todayDeaths!.toString()),


                            ],
                          )
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>const CountriesList()));

                      },

                      child: Container(
                        height: 40,

                        child:Center(child: Text('Track Countries'),),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff1aa260),
                        ),

                      ),
                    )
                  ]);
              }
             }),
             

            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 5),
      child: Column(

        children: [
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(title),
    Text(value),

  ],

),
          SizedBox(height: 5,),
          Divider()

        ],
      ),

    );
  }
}
