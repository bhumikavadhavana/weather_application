import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/connectivty_provider.dart';
import '../../controller/provider/themeprovider.dart';
import '../../controller/provider/weather_provider.dart';
import '../../models/weather_model.dart';
import '../../utils/helpers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  WeatherModel? weatherModel;

  late Future<WeatherModel?> weatherdata;

  @override
  void initState() {
    super.initState();
    weatherdata = APIHelper.apiHelper.fetchweather(locationame: "Surat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Sky Scrapper",
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 24,
      //     ),
      //   ),
      //   centerTitle: true,
      //   leading: Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Provider.of<ThemeProvider>(context, listen: false).changeTheme();
      //       },
      //       icon: (Provider.of<ThemeProvider>(context).themeModel.isDark)
      //           ? const Icon(Icons.mode_night)
      //           : const Icon(Icons.light_mode_rounded),
      //     ),
      //   ],
      // ),
      body: (Provider.of<ConnectivityProvider>(context)
                  .connectitvityModel
                  .connectivitystatus ==
              "Waiting..")
          ? const Center(
              child: Text("No Data Connection"),
            )
          : FutureBuilder(
              future: Provider.of<WeatherProvider>(context, listen: false)
                  .Weatherdata(
                      locationame:
                          (Provider.of<WeatherProvider>(context).location)),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("ERROR : ${snapshot.error}"),
                  );
                } else if (snapshot.hasData) {
                  WeatherModel? weatherdata = snapshot.data;
                  return (weatherdata == null)
                      ? const Center(
                          child: Text("No Internet "),
                        )
                      : Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (Provider.of<ThemeProvider>(context)
                                          .themeModel
                                          .isDark)
                                      ? AssetImage("assets/image/m1.jpg")
                                      : AssetImage("assets/image/m3.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    TextField(
                                      onSubmitted: (String name) async {
                                        if (name.isNotEmpty) {
                                          Provider.of<WeatherProvider>(context,
                                              listen: false)
                                              .locationchanage(name);
                                        } else {
                                          Provider.of<WeatherProvider>(context,
                                              listen: false)
                                              .locationchanage(
                                              Provider.of<WeatherProvider>(
                                                  context)
                                                  .location);
                                        }
                                      },
                                      controller:
                                      Provider.of<WeatherProvider>(context)
                                          .citynamecontroller,
                                      decoration: InputDecoration(
                                        fillColor: Colors.transparent,
                                        filled: true,
                                        prefixIcon: Icon(
                                          Icons.location_city_sharp,
                                          color: Colors.white,
                                        ),
                                        hintText: "SEARCH ",
                                        hintStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                'manage_cities_page');
                                          },
                                          icon: Icon(
                                            CupertinoIcons.add,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${weatherdata.name}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${weatherdata.region}",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  ", ${weatherdata.country}",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('setting_page');
                                          },
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${weatherdata.name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${weatherdata.region}",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  ", ${weatherdata.country}",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 200,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${weatherdata.temp_c}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 80,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Mostly ${weatherdata.text}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${weatherdata.localtime}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  ...weatherdata.hour
                                                      .map(
                                                        (e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                e['time']
                                                                    .toString()
                                                                    .split(
                                                                        " ")[1],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                e['temp_c']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Weather Details",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Apparent Temperature",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${weatherdata.feelslike_c} ◦c"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Humidity",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${weatherdata.humidity} %"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "SW Wind",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        " ${weatherdata.wind_kph} km/h"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 120,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "UV",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${weatherdata.uv}"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Center(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Visibility",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${weatherdata.vis_km} km"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 70,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Air Pressure",
                                                        style: TextStyle(
                                                          color: Colors.white60,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${weatherdata.pressure_mb} hPa"
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 30,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}
