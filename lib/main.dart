import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Topics()),
      ],
      child: MyApp(),
    ),
  );
}

class Topics with ChangeNotifier {
  String _postion = '';
  String _velocity = '';
  String _battery = '';

  String get postion => _postion;
  String get velocity => _velocity;
  String get battery => _battery;

  void changePostion(data) {
    this._postion = data;
    _postion = data;
    notifyListeners();
  }

  void changeVelocity(data) {
    _velocity = data;
    notifyListeners();
  }

  void changeBattery(data) {
    _battery = data;
    notifyListeners();
  }
}

void postion1(data) {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'NotoSerif',
      ),
      home: MyHomePage(title: 'Socket in Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IO.Socket socket;

  @override
  void initState() {
    super.initState();

    _listenWebSocket();
  }

  void _listenWebSocket() {
    socket = IO.io(
        'http://localhost:3000/',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    // 链接建立成功之后，可以发送数据到socket.io的后端了
    socket.on('connect', (_) {
      print('connect');
    });
    // 链接建立失败时调用
    socket.on('error', (data) {
      print('error');
      print(data);
    });

    // 链接出错时调用
    socket.on("connect_error", (data) => print(data));
    // 链接断开时调用
    socket.on('disconnect', (_) => print('disconnect======'));
    // 链接关闭时调用
    socket.on('close', (_) => print('close===='));
    // 服务端emit一个message的事件时，可以直接监听到
    socket.on('chat message', (data) {
      print('onmessage');
      print(data);
    });
  }

// 关闭websocket链接，避免内存占用
  @override
  void dispose() {
    super.dispose();

    print('close');
    socket.close();
  }

  @override
  Widget build(BuildContext context) {
    socket.on('position', (data) {
      context.read<Topics>().changePostion(data);
    });
    socket.on('battery', (data) {
      context.read<Topics>().changeVelocity(data);
    });
    socket.on('velocity', (data) {
      context.read<Topics>().changeBattery(data);
    });

    TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: socket.connect,
                          child: Text('连接Socket',
                              style: TextStyle(fontWeight: FontWeight.w900)),
                        ),
                        SizedBox(width: 50),
                        RaisedButton(
                          onPressed: socket.disconnect,
                          child: Text('断开Socket'),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: Color(0xFF535353)),
                              children: [
                                TextSpan(
                                    text:
                                        'Postion: ${context.watch<Topics>().postion}'),
                              ]),
                        ),
                        SizedBox(height: 50),
                        // Text('Velocity: ${Topics().velocity}'),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Color(0xFF535353)),
                            children: [
                              TextSpan(text: 'Velocity: '),
                              TextSpan(
                                  text: '${context.watch<Topics>().velocity}')
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Color(0xFF535353)),
                            children: [
                              TextSpan(text: 'Battery: '),
                              TextSpan(
                                  text: '${context.watch<Topics>().battery}')
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: 200,
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    autofocus: false,
                                    controller: _textController,
                                    decoration: InputDecoration(
                                      hintText: "请输入Goal的值1-5",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => {
                                socket.emit('goal', _textController.text),
                              },
                              child: Text('提交'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
