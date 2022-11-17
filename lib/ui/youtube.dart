import 'package:flutter/material.dart';
import 'package:practica_1/ui/menu_opciones.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  static String key = "AIzaSyA6VwKkpxbpZuLYuQXlSeENH-Em1z05tfQ";
  String busqueda = "Comida Ocosingo chiapas";
  // String query = busqueda;
  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI() async {
    videoResult = await youtube.search(busqueda,
        order: 'relevance', videoDuration: 'any', type: "Video");
    videoResult = await youtube.nextPage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text('Videos'),
        ),
        drawer: menuOpciones(context),
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: 60),
                child: ListView(
                  children: videoResult.map<Widget>(listItem).toList(),
                )),
            _buscador()
          ],
        ));
  }

  Widget _buscador() {
    return Row(children: [
      SizedBox(
        child: TextField(
          decoration: InputDecoration(
              labelText: "Buscar",
              icon: IconButton(
                onPressed: () {
                  setState(() {
                    callAPI();
                  });
                  print(busqueda);
                },
                icon: Icon(Icons.search),
                alignment: Alignment.bottomCenter,
              )),
          onChanged: (valor) {
            busqueda = valor;
          },
        ),
        width: 400,
      ),
      // IconButton(
      //     onPressed: () {
      //       callAPI();
      //       // setState(() {});
      //       print(busqueda);
      //     },
      //     icon: Icon(Icons.search))
    ]);
  }

  Future<void> _abreVideo(BuildContext context, String url) async {
    if (!await launch(url)) {
      SnackBar snack = SnackBar(
        content: Text('No se pudo abrir el video'),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
  }

  Widget listItem(YouTubeVideo video) {
    return Card(
      color: Color.fromARGB(255, 119, 190, 248),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: (() {
            String url = video.url;
            _abreVideo(context, url);
          }),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.network(
                  video.thumbnail.small.url ?? '',
                  width: 120.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.title,
                      softWrap: true,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        video.channelTitle,
                        softWrap: true,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      video.url,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
