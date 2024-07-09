import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/resources/constants.dart';
import 'package:weather_app/views/components/container_box.dart';
import 'package:weather_app/views/splash_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherController weatherController = WeatherController();
  Position? currentPosition;
  String? place;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return currentPosition == null
        ? SplashScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                place == null || place == '' ? "Current Location" : place!,
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(Icons.place),
              backgroundColor: MyColors.darkBlue,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: SafeArea(
                child: FutureBuilder(
                    future: weatherController.getWeatherDetails(
                        currentPosition!.latitude, currentPosition!.longitude),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.api),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Requesting Weather API")
                              ],
                            ),
                          ),
                        );
                      } else {
                        var iconUrl =
                            "http://openweathermap.org/img/w/${snapshot.data!.weather![0].icon!}.png";
                        String temp = (snapshot.data!.main!.temp! - 273)
                            .toStringAsFixed(0);
                        String mintemp = (snapshot.data!.main!.tempMin! - 273)
                            .toStringAsFixed(0);
                        String maxtemp = (snapshot.data!.main!.tempMax! - 273)
                            .toStringAsFixed(0);

                        String wind = snapshot.data!.wind!.speed.toString();
                        String humidity =
                            snapshot.data!.main!.humidity.toString();
                        String pressure =
                            snapshot.data!.main!.pressure.toString();
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  MyColors.lightBlue,
                                  Colors.white,
                                  MyColors.lightBlue,
                                  MyColors.darkBlue,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.28,
                                child: Image.network(
                                  iconUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                snapshot.data!.weather![0].main.toString(),
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.darkBlue.withOpacity(0.7),
                                  fontSize: 28,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${temp}°C",
                                    style: GoogleFonts.ubuntu(
                                      fontSize:
                                          MediaQuery.sizeOf(context).width *
                                              0.15,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.darkBlue,
                                    ),
                                  ),
                                  Text(
                                    "$mintemp / $maxtemp°C",
                                    style: GoogleFonts.ubuntu(
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.darkBlue.withOpacity(0.5),
                                      fontSize:
                                          MediaQuery.sizeOf(context).width *
                                              0.05,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ContainerBox(
                                    icon: Icons.wind_power,
                                    text: "Wind",
                                    value: "$wind m/sec",
                                  ),
                                  ContainerBox(
                                    icon: Icons.water,
                                    text: "Humidity",
                                    value: "$humidity%",
                                  ),
                                  ContainerBox(
                                    icon: Icons.gesture,
                                    text: "Pressure",
                                    value: "$pressure hPa",
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ),
          );
  }

  Future<Position> getCurrentLocation() async {
    bool isLocationEnabled;
    LocationPermission permission;
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      print("Location access not given..");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("denied forever");
    }

    Position currentLocation = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    print(currentLocation);
    setState(() {
      currentPosition = currentLocation;
      place = placemarks.first.locality;
    });
    return currentLocation;
  }
}
