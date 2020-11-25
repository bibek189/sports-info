import 'package:SportsInfo/models/sports_league_model.dart';
import 'package:SportsInfo/providers/sports_provider.dart';
import 'package:flutter/material.dart';

class Selectedsport extends StatefulWidget {
  final String sportname;
  Selectedsport({this.sportname});
  @override
  _SelectedsportState createState() => _SelectedsportState();
}

class _SelectedsportState extends State<Selectedsport> {
  Future<SportsLeague> _sportsLeague;
  @override
  void initState() {
    _sportsLeague = SportsProvider().getsportsleaguecountry(widget.sportname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    var a = MediaQuery.of(context).orientation;
    if (a == Orientation.landscape) {
      loading = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sportname),
      ),
      body: Container(
        child: FutureBuilder<SportsLeague>(
            future: _sportsLeague,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data.countrys.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: loading ? 4 : 2),
                    itemBuilder: (BuildContext context, int index) {
                      var country = snapshot.data.countrys[index];
                      return InkWell(
                        onTap: () {},
                        child: Sporttile(
                          id: country.idLeague,
                          image: country.strBadge,
                          format: country.strCountry,
                          name: country.strLeague,
                          desc: country.strDescriptionEN,
                        ),
                      );
                    });
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
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
