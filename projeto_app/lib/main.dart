import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:projeto_app/menu_inicial.dart';
import 'package:http/http.dart' as http;
import 'menu_hamburger.dart';

Future main() async {
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(Duration(seconds: 10), 0, callbackFumos,
      wakeup: true, rescheduleOnReboot: true);
  
  
  runApp(MyApp());
}

void callbackFumos() async {
  
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  FlutterLocalNotificationsPlugin localNotificationsPlugin2 =
      FlutterLocalNotificationsPlugin();

  String url =
      "http://169.254.155.190:8080/rest/items/Fumo/state";
  http.Response response = await http.get(url);

  String st = response.body;


  String url2 =
      "http://169.254.155.190:8080/rest/items/PessoasPresentes/state";
  http.Response response2 = await http.get(url2);

  String st2 = response2.body;


  if (int.parse(st) >= 170 || int.parse(st2)>4) {
    
    var initializeAndroid = AndroidInitializationSettings('alerta');
    var initializeIOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(initializeAndroid, initializeIOS);

    await localNotificationsPlugin.initialize(initSettings);
    await localNotificationsPlugin2.initialize(initSettings);

    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-description',
      importance: Importance.Max,
      priority: Priority.Max,
    );

    var iosChannel = IOSNotificationDetails();

    var platformChannel = NotificationDetails(androidChannel, iosChannel);

    DateTime now = DateTime.now().toUtc().add(
          Duration(seconds: 10),
        );

    int hashcode = 98123871;
    int hashcode2 = 98123800;

    if(int.parse(st) >= 170 && int.parse(st2)<4){

    localNotificationsPlugin.schedule(
        hashcode, "ALERTA", "NÍVES DE FUMO ELEVADOS !", now, platformChannel,
        payload: hashcode.toString());

    } else if(int.parse(st2)>4 && int.parse(st) < 170){

      localNotificationsPlugin.schedule(
        hashcode, "ALERTA", "POSSIVEL INTRUSO !", now, platformChannel,
        payload: hashcode.toString());

    } else{ 

        print("aqui1");
        localNotificationsPlugin.schedule(
        hashcode, "ALERTA", "POSSIVEL INTRUSO !", now, platformChannel,
        payload: hashcode.toString());


        print("aqui2");
        localNotificationsPlugin2.schedule(
        hashcode2, "ALERTA", "NÍVES DE FUMO ELEVADOS !", now, platformChannel,
        payload: hashcode2.toString());
    }
  }
}




class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Projeto"),
      ),
      drawer: MenuHamburguer(),
      body: Container(
        margin: EdgeInsets.all(5.0),
        child: MenuGridInicial(),
      ),
    );

    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.blueAccent),
      home: scaffold,
    );
  }
}
