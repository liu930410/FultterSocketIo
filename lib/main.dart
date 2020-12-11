// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => Counter()),
    //   ],
    //   child: const MyApp(),

    // ),

    MyApp(),
  );
}

/// Mix-in [DiagnosticableTreeMixin] to have access to [debugFillProperties] for the devtool
// ignore: prefer_mixin
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties

}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const <Widget>[
//             Text('You have pushed the button this many times:'),

//             /// Extracted as a separate widget for performance optimization.
//             /// As a separate widget, it will rebuild independently from [MyHomePage].
//             ///
//             /// This is totally optional (and rarely needed).
//             /// Similarly, we could also use [Consumer] or [Selector].
//             Count(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         /// Calls `context.read` instead of `context.watch` so that it does not rebuild
//         /// when [Counter] changes.
//         onPressed: () => context.read<Counter>().increment(),
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class Count extends StatelessWidget {
//   const Count({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(

//         /// Calls `context.watch` to make [Count] rebuild when [Counter] changes.
//         '${context.watch<Counter>().count}',
//         style: Theme.of(context).textTheme.headline4);
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureProvider(
//       initialData: MyModel(counter: 0),
//       create: (context) => someAsyncFunctionToGetMyModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('provider'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Builder(
//               builder: (context) {
//                 MyModel _model = Provider.of<MyModel>(context, listen: false);
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

//   Future<MyModel> someAsyncFunctionToGetMyModel() async {
//     //  <--- async function
//     await Future.delayed(Duration(seconds: 3));
//     return MyModel(counter: 1);
//   }
// }

// class MyModel with ChangeNotifier {
//   //                                               <--- MyModel
//   MyModel({this.counter = 0});

//   int counter = 0;

//   Future<void> incrementCounter() async {
//     await Future.delayed(Duration(seconds: 2));
//     counter++;
//     print(counter);
//     notifyListeners();
//   }
// }
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider(
//       initialData: MyModel(counter: 0),
//       create: (context) => getStreamOfMyModel(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('provider'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Builder(
//               builder: (context) {
//                 MyModel _model = Provider.of<MyModel>(context, listen: false);
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
//                     // onPressed: model.incrementCounter,
//                     child: Icon(Icons.add));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stream<MyModel> getStreamOfMyModel() {
//     return Stream<MyModel>.periodic(
//         Duration(seconds: 1), (x) => MyModel(counter: x)).take(10);
//   }
// }

// class MyModel with ChangeNotifier {
//   //                                               <--- MyModel
//   MyModel({this.counter = 0});

//   int counter = 0;

// Future<void> incrementCounter() async {
//   await Future.delayed(Duration(seconds: 2));
//   counter++;
//   print(counter);
//   notifyListeners();
// }
// }
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(loginServive: LoginServive()),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('provider'),
        ),
        body: Column(
          children: <Widget>[
            model.state == ViewState.Loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Text(model.info),
            FlatButton(
                color: Colors.tealAccent,
                onPressed: () => model.login("pwd"),
                child: Text("登录")),
          ],
        ),
      ),
    );
  }
}

/// viewModel
class LoginViewModel extends BaseModel {
  LoginServive _loginServive;
  String info = '请登录';

  LoginViewModel({@required LoginServive loginServive})
      : _loginServive = loginServive;

  Future<String> login(String pwd) async {
    setState(ViewState.Loading);
    info = await _loginServive.login(pwd);
    setState(ViewState.Success);
  }
}

/// api
class LoginServive {
  static const String Login_path = 'xxxxxx';

  Future<String> login(String pwd) async {
    return new Future.delayed(const Duration(seconds: 1), () => "登录成功");
  }
}

enum ViewState { Loading, Success, Failure, None }

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.None;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  BaseWidget({
    Key key,
    this.builder,
    this.model,
    this.child,
    this.onModelReady,
  }) : super(key: key);

  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (BuildContext context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
