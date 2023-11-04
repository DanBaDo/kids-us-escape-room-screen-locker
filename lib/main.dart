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
                      correctString: '1234',
                      canCancel: false,
                      useBlur: false,
                      onUnlocked: () {
                        Navigator.pop(context);
                        NextPage.show(context);
                      },
                    ),
                    child: const Text('Resumo'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      screenLockCreate(
                        context: context,
                        title: const Text('change title'),
                        confirmTitle: const Text('change confirm title'),
                        onConfirmed: (value) => Navigator.of(context).pop(),
                        config: const ScreenLockConfig(
                          backgroundColor: Colors.deepOrange,
                          titleTextStyle: TextStyle(fontSize: 24),
                        ),
                        secretsConfig: SecretsConfig(
                          spacing: 15, // or spacingRatio
                          padding: const EdgeInsets.all(40),
                          secretConfig: SecretConfig(
                            borderColor: Colors.amber,
                            borderSize: 2.0,
                            disabledColor: Colors.black,
                            enabledColor: Colors.amber,
                            size: 15,
                            builder: (context, config, enabled) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: enabled
                                    ? config.enabledColor
                                    : config.disabledColor,
                                border: Border.all(
                                  width: config.borderSize,
                                  color: config.borderColor,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              width: config.size,
                              height: config.size,
                            ),
                          ),
                        ),
                        keyPadConfig: KeyPadConfig(
                          buttonConfig: KeyPadButtonConfig(
                            buttonStyle: OutlinedButton.styleFrom(
                              textStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: Colors.deepOrange,
                            ),
                          ),
                          displayStrings: [
                            '零',
                            '壱',
                            '弐',
                            '参',
                            '肆',
                            '伍',
                            '陸',
                            '質',
                            '捌',
                            '玖',
                          ],
                        ),
                        cancelButton: const Icon(Icons.close),
                        deleteButton: const Icon(Icons.delete),
                      );
                    },
                    child: const Text('Customize styles'),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
    );
  }
}