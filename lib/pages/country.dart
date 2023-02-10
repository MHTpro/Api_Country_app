
import 'package:flutter/material.dart';
import 'package:test_flutter_app/pages/info_country.dart';
import '../api/my_api.dart';
import '../models/api_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  List<ApiModels?>? allResponse;
  final RefreshController _refreshController = RefreshController();
  final RefreshController _refreshController2 = RefreshController();

  void _onRefresh() async {
    await getAll().then(
      (value) => setState(
        () => allResponse = value,
      ),
    );

    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    getAll().then((value) => allResponse = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: const Text(
          "Country",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: FutureBuilder(
          future: getAll(),
          builder:
              (BuildContext context, AsyncSnapshot<List<ApiModels>> snapshot) {
            if (!(snapshot.hasData)) {
              return CircularProgressIndicator(
                strokeWidth: 10.0,
                color: Colors.orange.shade800,
                backgroundColor: Colors.orangeAccent,
              );
            }
            return allResponse == null
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
                : SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      cacheExtent: 200.0,
                      itemCount: allResponse!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CountryInformation(
                                      countryName:
                                          allResponse![index]!.name.toString(),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              height: 80.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.orange,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Name: ${allResponse![index]!.name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
