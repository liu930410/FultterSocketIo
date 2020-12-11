// // ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// /// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].
// import 'dart:async';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// IO.Socket socket = IO.io(
//     'http://192.168.0.59:3000',
//     IO.OptionBuilder()
//         .setTransports(['websocket'])
//         .disableAutoConnect()
//         .build());

// void main() {
//   HttpOverrides.global = new MyHttpOverrides();

//   socket.onConnect((_) {
//     print('connect');
//     socket.emit('msg', 'test');
//   });
//   socket.onDisconnect((_) => print('disconnectIO'));
//   socket.connect();
//   runApp(
//     /// Providers are above [MyApp] instead of inside it, so that tests
//     /// can use [MyApp] while mocking the providers
//     // MultiProvider(
//     //   providers: [
//     //     ChangeNotifierProvider(create: (_) => Counter()),
//     //   ],
//     //   child: const MyApp(),
//     // ),

//     MyApp(),
//   );
// }

// /// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// // ignore: prefer_mixin
// // class Counter with ChangeNotifier {
// //   int _count = 0;

// //   int get count => _count;

// //   void increment() {
// //     _count++;
// //     notifyListeners();
// //   }

// //   /// Makes `Counter` readable inside the devtools by listing all of its properties

// // }

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// // class MyHomePage extends StatelessWidget {
// //   const MyHomePage({Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Example'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: const <Widget>[
// //             Text('You have pushed the button this many times:'),

// //             /// Extracted as a separate widget for performance optimization.
// //             /// As a separate widget, it will rebuild independently from [MyHomePage].
// //             ///
// //             /// This is totally optional (and rarely needed).
// //             /// Similarly, we could also use [Consumer] or [Selector].
// //             Count(),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         /// Calls `context.read` instead of `context.watch` so that it does not rebuild
// //         /// when [Counter] changes.
// //         onPressed: () => context.read<Counter>().increment(),
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ),
// //     );
// //   }
// // }

// // class Count extends StatelessWidget {
// //   const Count({Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Text(

// //         /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
// //         '${context.watch<Counter>().count}',
// //         style: Theme.of(context).textTheme.headline4);
// //   }
// // }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => MyModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('provider'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Builder(
//               builder: (context) {
//                 MyModel _model = Provider.of<MyModel>(context);
//                 return Container(
//                     margin: const EdgeInsets.only(top: 20),
//                     width: MediaQuery.of(context).size.width,
//                     padding: const EdgeInsets.all(20),
//                     alignment: Alignment.center,
//                     color: Colors.lightBlueAccent,
//                     child: Text('当前是：${_model.counter}'));
//               },
//             ),
//             Consumer<MyModel>(
//               builder: (context, model, child) {
//                 return Container(
//                   margin: const EdgeInsets.only(top: 20),
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(20),
//                   alignment: Alignment.center,
//                   color: Colors.lightGreen,
//                   child: Text(
//                     '${model.counter}',
//                   ),
//                 );
//               },
//             ),
//             Consumer<MyModel>(
//               builder: (context, model, child) {
//                 return FlatButton(
//                     color: Colors.tealAccent,
//                     onPressed: model.incrementCounter,
//                     child: Icon(Icons.add));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyModel with ChangeNotifier {
//   //                                               <--- MyModel
//   MyModel({this.counter = 0});

//   int counter = 0;
//   // Function abc() {
//   //   IO.Socket socket = IO.io('http://localhost:3000');
//   //   socket.onConnect((_) {
//   //     print('connect');
//   //     socket.emit('msg', 'test');
//   //   });
//   //   socket.on('event', (data) => print(data));
//   //   socket.onDisconnect((_) => print('disconnect'));
//   //   socket.on('fromServer', (_) => print(_));
//   // }

//   Future<void> incrementCounter() async {
//     // await Future.delayed(Duration(seconds: 2));
//     counter++;
//     // print(counter);
//     socket.connect();
//     notifyListeners();
//   }
// }
// // class MyHomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureProvider(
// //       initialData: MyModel(counter: 0),
// //       create: (context) => someAsyncFunctionToGetMyModel(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text('provider'),
// //         ),
// //         body: Column(
// //           children: <Widget>[
// //             Builder(
// //               builder: (context) {
// //                 MyModel _model = Provider.of<MyModel>(context, listen: false);
// //                 return Container(
// //                     margin: const EdgeInsets.only(top: 20),
// //                     width: MediaQuery.of(context).size.width,
// //                     padding: const EdgeInsets.all(20),
// //                     alignment: Alignment.center,
// //                     color: Colors.lightBlueAccent,
// //                     child: Text('当前是：${_model.counter}'));
// //               },
// //             ),
// //             Consumer<MyModel>(
// //               builder: (context, model, child) {
// //                 return Container(
// //                   margin: const EdgeInsets.only(top: 20),
// //                   width: MediaQuery.of(context).size.width,
// //                   padding: const EdgeInsets.all(20),
// //                   alignment: Alignment.center,
// //                   color: Colors.lightGreen,
// //                   child: Text(
// //                     '${model.counter}',
// //                   ),
// //                 );
// //               },
// //             ),
// //             Consumer<MyModel>(
// //               builder: (context, model, child) {
// //                 return FlatButton(
// //                     color: Colors.tealAccent,
// //                     onPressed: model.incrementCounter,
// //                     child: Icon(Icons.add));
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<MyModel> someAsyncFunctionToGetMyModel() async {
// //     //  <--- async function
// //     await Future.delayed(Duration(seconds: 3));
// //     return MyModel(counter: 1);
// //   }
// // }

// // class MyModel with ChangeNotifier {
// //   //                                               <--- MyModel
// //   MyModel({this.counter = 0});

// //   int counter = 0;

// //   Future<void> incrementCounter() async {
// //     await Future.delayed(Duration(seconds: 2));
// //     counter++;
// //     print(counter);
// //     notifyListeners();
// //   }
// // }
// // class MyHomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamProvider(
// //       initialData: MyModel(counter: 0),
// //       create: (context) => getStreamOfMyModel(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text('provider'),
// //         ),
// //         body: Column(
// //           children: <Widget>[
// //             Builder(
// //               builder: (context) {
// //                 MyModel _model = Provider.of<MyModel>(context, listen: false);
// //                 return Container(
// //                     margin: const EdgeInsets.only(top: 20),
// //                     width: MediaQuery.of(context).size.width,
// //                     padding: const EdgeInsets.all(20),
// //                     alignment: Alignment.center,
// //                     color: Colors.lightBlueAccent,
// //                     child: Text('当前是：${_model.counter}'));
// //               },
// //             ),
// //             Consumer<MyModel>(
// //               builder: (context, model, child) {
// //                 return Container(
// //                   margin: const EdgeInsets.only(top: 20),
// //                   width: MediaQuery.of(context).size.width,
// //                   padding: const EdgeInsets.all(20),
// //                   alignment: Alignment.center,
// //                   color: Colors.lightGreen,
// //                   child: Text(
// //                     '${model.counter}',
// //                   ),
// //                 );
// //               },
// //             ),
// //             Consumer<MyModel>(
// //               builder: (context, model, child) {
// //                 return FlatButton(
// //                     color: Colors.tealAccent,
// //                     // onPressed: model.incrementCounter,
// //                     child: Icon(Icons.add));
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Stream<MyModel> getStreamOfMyModel() {
// //     return Stream<MyModel>.periodic(
// //         Duration(seconds: 1), (x) => MyModel(counter: x)).take(10);
// //   }
// // }

// // class MyModel with ChangeNotifier {
// //   //                                               <--- MyModel
// //   MyModel({this.counter = 0});

// //   int counter = 0;

// // Future<void> incrementCounter() async {
// //   await Future.delayed(Duration(seconds: 2));
// //   counter++;
// //   print(counter);
// //   notifyListeners();
// // }
// // }
// // class MyHomePage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BaseWidget<LoginViewModel>(
// //       model: LoginViewModel(loginServive: LoginServive()),
// //       builder: (context, model, child) => Scaffold(
// //         appBar: AppBar(
// //           title: Text('provider'),
// //         ),
// //         body: Column(
// //           children: <Widget>[
// //             model.state == ViewState.Loading
// //                 ? Center(
// //                     child: CircularProgressIndicator(),
// //                   )
// //                 : Text(model.info),
// //             FlatButton(
// //                 color: Colors.tealAccent,
// //                 onPressed: () => model.login("pwd"),
// //                 child: Text("登录")),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /// viewModel
// // class LoginViewModel extends BaseModel {
// //   LoginServive _loginServive;
// //   String info = '请登录';

// //   LoginViewModel({@required LoginServive loginServive})
// //       : _loginServive = loginServive;

// //   Future<String> login(String pwd) async {
// //     setState(ViewState.Loading);
// //     info = await _loginServive.login(pwd);
// //     setState(ViewState.Success);
// //   }
// // }

// // /// api
// // class LoginServive {
// //   static const String Login_path = 'xxxxxx';

// //   Future<String> login(String pwd) async {
// //     return new Future.delayed(const Duration(seconds: 1), () => "登录成功");
// //   }
// // }

// // enum ViewState { Loading, Success, Failure, None }

// // class BaseModel extends ChangeNotifier {
// //   ViewState _state = ViewState.None;

// //   ViewState get state => _state;

// //   void setState(ViewState viewState) {
// //     _state = viewState;
// //     notifyListeners();
// //   }
// // }

// // class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
// //   final Widget Function(BuildContext context, T model, Widget child) builder;
// //   final T model;
// //   final Widget child;
// //   final Function(T) onModelReady;

// //   BaseWidget({
// //     Key key,
// //     this.builder,
// //     this.model,
// //     this.child,
// //     this.onModelReady,
// //   }) : super(key: key);

// //   _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
// // }

// // class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
// //   T model;

// //   @override
// //   void initState() {
// //     model = widget.model;

// //     if (widget.onModelReady != null) {
// //       widget.onModelReady(model);
// //     }

// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider<T>(
// //       create: (BuildContext context) => model,
// //       child: Consumer<T>(
// //         builder: widget.builder,
// //         child: widget.child,
// //       ),
// //     );
// //   }
// // }
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  IO.Socket channel;

  @override
  void initState() {
    super.initState();

    _listenWebSocket();
  }

  void _listenWebSocket() async {
    // 构建请求头，可以放一些cookie等信息，这里加上了origin，因为服务端有origin校验
    Map<String, dynamic> headers = new Map();
    headers['origin'] = 'http://192.168.0.59:3000/';
    // 建立websocket链接
    // 链接的书写规范，schame://host:port/namespace, 这里socket_io_client在处理链接时候会把path和后面的query参数都作为namespace来处理，所以如果我们的namespace是/的话，就直接使用http://host/
    channel = IO.io('http://192.168.0.59:3000/', <String, dynamic>{
      // 请求的path
      'path': '/',
      // 构造的header放这里
      'extraHeaders': headers,
      // 查询参数，扔这里
      'query': {'EIO': 3, 'transport': 'websocket'},
      // 说明需要升级成websocket链接
      'transports': ['websocket'],
    });

    // 链接建立成功之后，可以发送数据到socket.io的后端了
    channel.on('connect', (_) {
      print('connect');
      // 发送消息和回调函数给socket.io服务端，在服务端可以直接获取到该方法，然后调用
      channel.emitWithAck('exchange', '11111', ack: (data) {
        print('ack $data');
        if (data != null) {
          print('from server $data');
        } else {
          print("Null");
        }
      });
    });
    // 链接建立失败时调用
    channel.on('error', (data) {
      print('error');
      print(data);
    });
    // 链接出错时调用
    channel.on("connect_error", (data) => print('connect_error: '));
    // 链接断开时调用
    channel.on('disconnect', (_) => print('disconnect======'));
    // 链接关闭时调用
    channel.on('close', (_) => print('close===='));
    // 服务端emit一个message的事件时，可以直接监听到
    channel.on('message', (data) {
      print('onmessage');
      print(data);
    });
  }

// 关闭websocket链接，避免内存占用
  @override
  void dispose() {
    super.dispose();

    print('close');
    channel.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _listenWebSocket();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
