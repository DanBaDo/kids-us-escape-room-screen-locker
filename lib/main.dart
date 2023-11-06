import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate',
    );
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Next Screen Lock'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => screenLock(
                      context: context,
                      correctString: '79260',
                      canCancel: false,
                      useBlur: false,
                      config: const ScreenLockConfig(
                        backgroundColor: Colors.black,
                      ),
                      onUnlocked: () {
                        Navigator.pop(context);
                        NextPage.show(context);
                      },
                    ),
                    child: const Text('Start'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  static show(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Image(image: AssetImage('images/smile.png'))],
      ),
    );
  }
}