import 'package:SportsInfo/pages/selected_sport.dart';
import 'package:SportsInfo/providers/sports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  bool isInternetOn = true;
  @override
  void initState() {
    super.initState();
    getConnect(); 
  }

  void getConnect() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetOn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;

    var a = MediaQuery.of(context).orientation;
    if (a == Orientation.landscape) {
      loading = true;
    }
    final SportsProvider sportsProvider = Provider.of<SportsProvider>(context);
    sportsProvider.fetchsports();
    return Scaffold(
      appBar: AppBar(
        title: Text("Awesome Sports"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        child: isInternetOn
            ? sportsProvider.listsportsmodel != null
                ? GridView.builder(
                    itemCount: sportsProvider.listsportsmodel.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: loading ? 4 : 2),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          sportsProvider.sportName =
                              sportsProvider.listsportsmodel[index].name;
                              print(sportsProvider.sportName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Selectedsport(
                                        sportname: sportsProvider
                                            .listsportsmodel[index].name,
                                      )));
                        },
                        child: Sporttile(
                          id: sportsProvider.listsportsmodel[index].id,
                          image: sportsProvider.listsportsmodel[index].image1,
                          format: sportsProvider.listsportsmodel[index].format,
                          name: sportsProvider.listsportsmodel[index].name,
                          desc:
                              sportsProvider.listsportsmodel[index].description,
                        ),
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 50,
                    ),
                  )
            : buildAlertDialog(),
        controller: _refreshController,
        onRefresh: _onRefresh,
      ),
    );
  }
}

AlertDialog buildAlertDialog() {
  return AlertDialog(
    title: Text(
      "You are not Connected to Internet",
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );
}

class Sporttile extends StatelessWidget {
  final String id, name, image, format, desc;
  Sporttile({this.format, this.name, this.id, this.image, this.desc});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width / 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      child: Image.network(
                        image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      format,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
