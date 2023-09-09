import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unicode_app/util.dart';

class Weather_Screen extends StatefulWidget {
  const Weather_Screen({super.key});

  @override
  State<Weather_Screen> createState() => _Weather_ScreenState();
}

class _Weather_ScreenState extends State<Weather_Screen> {
  double temp = 0;
  int humidity = 0;
  double windspeed = 0;
  int pressure = 0;
  String cityname = '';
  final city = TextEditingController();

  getWeather(String cityname) async {
    try {
      final apikey = '429fe6c2a4e8b682c98b1afc04bcf293';

      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityname&APPID=$apikey'),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        //print(response.body);
        setState(() {
          temp = (data['main']['temp'] - 273);
          humidity = (data['main']['humidity']);
          windspeed = (data['wind']['speed']);
          pressure = (data['main']['pressure']);
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    print("initcalled");
    // TODO: implement initState
    super.initState();
    getWeather(cityname);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Weather"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: city,
              decoration: InputDecoration(
                labelText: "Enter City Name",
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Fetch weather data for the city entered by the user
              String enteredCity = city.text;
              getWeather(enteredCity);
            },
            child: Text('Get Weather'),
          ),
          (temp == 0 && humidity == 0 && windspeed == 0 && pressure == 0)
              ? Align(
                  alignment: Alignment.center, child: Text("Enter City Name"))
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: Card(
                              color: Color.fromARGB(255, 99, 121, 176),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Image.asset(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.1,
                                        "assets/celsius.png",
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Temperature: ${temp.toStringAsFixed(2)}°C',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    'Humidity:${humidity}',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    'Wind Speed: ${windspeed.toStringAsFixed(2)} km/h',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text(
                                    'Pressure: ${pressure} atm',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: GridView.builder(
                        //       itemCount: properties.length,
                        //       gridDelegate:
                        //           SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 2),
                        //       itemBuilder: (context, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(20.0),
                        //           child: Card(
                        //             color: Color.fromARGB(
                        //                 255, 99, 121, 176),
                        //           ),
                        //         );
                        //       }),
                        // ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
