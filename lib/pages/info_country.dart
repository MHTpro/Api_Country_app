import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../api/my_api.dart';
import '../models/api_model.dart';

class CountryInformation extends StatefulWidget {
  final String? countryName;
  const CountryInformation({super.key, this.countryName});

  @override
  State<CountryInformation> createState() => _CountryInformationState();
}

class _CountryInformationState extends State<CountryInformation> {
  List<ApiModels>? theCountry;
  final RefreshController _refreshController = RefreshController();
  final RefreshController _refreshController2 = RefreshController();

  void _onRefresh() async {
    await getOne(widget.countryName).then(
      (value) => setState(
        () => theCountry = value,
      ),
    );

    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    getOne(widget.countryName).then((value) => theCountry = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: const Text(
          "Information",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: getOne(widget.countryName),
          builder:
              (BuildContext context, AsyncSnapshot<List<ApiModels>> snapshot) {
            if (!(snapshot.hasData)) {
              return CircularProgressIndicator(
                strokeWidth: 10.0,
                color: Colors.orange.shade800,
                backgroundColor: Colors.orangeAccent,
              );
            }
            return theCountry == null
                ? SmartRefresher(
                    controller: _refreshController2,
                    onRefresh: _onRefresh,
                    child: const Center(
                      child: Text(
                        "Connection Error,please try again!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: theCountry!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 650.0,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Name:\n${theCountry![index].name}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Borders:\n${theCountry![index].borders}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Region:\n${theCountry![index].region}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Capital:\n${theCountry![index].capital}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),
                                  Image.network(
                                    theCountry![index].flags!.png.toString(),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
