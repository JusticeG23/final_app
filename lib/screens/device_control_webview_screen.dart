// TODO: Make so can access HTTP pages (non-encrypted pages)
// https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android

// Dart imports
import 'dart:async';

// Flutter imports
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// File imports
import '../widgets/navigation/app_drawer.dart';
import '../widgets/webview_navigation_controls.dart';
import '../constants/constants.dart';

//////////////////////////////////////////////////////////////////
// StateFUL widget which manages state. Simply initializes the
// state object.
//////////////////////////////////////////////////////////////////
class DeviceControlWebviewScreen extends StatefulWidget {
  // Route name declaration
  static const routeName = '/device-control-webview';

  @override
  _DeviceControlWebviewScreenState createState() =>
      _DeviceControlWebviewScreenState();
}

//////////////////////////////////////////////////////////////////
// THe actual STATE which is managed by the above widget.
//////////////////////////////////////////////////////////////////
class _DeviceControlWebviewScreenState
    extends State<DeviceControlWebviewScreen> {
  // Instance variables
  var _targetUrlConfirmed = false;
  var _targetUrl = 'http://192.168.4.1';
  var _isInit = true;
  var _futureLoadTargetUrl;

  // Final variables
  final _form = GlobalKey<FormState>();
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  /// Helper Methods (for state object)
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////

  Future<void> _getTargetUrlFromStorage() async {
    print(_targetUrl);
    try {
      // Connect to device storage
      final storage = await SharedPreferences.getInstance();

      // If find target URL is saved, retrieve
      var target;
      if (storage.containsKey(SPK_TARGET_URL))
        target = storage.getString(SPK_TARGET_URL)!;

      //setState(() {
      _targetUrl = target;
      //});

      return Future<void>(() => {}); // return dummy future
    } catch (error) {
      throw error;
    }
  }

  ////////////////////////////////////////////////////////////////
  // Runs the following code once upon initialization, which reads
  // the Product from navigation parameters and updates the vars
  // connected to the UI (used for loading data from existing
  // products).
  ////////////////////////////////////////////////////////////////
  @override
  void didChangeDependencies() {
    // If first time running this code, attempt to load the target URL from storage
    if (_isInit) _futureLoadTargetUrl = _getTargetUrlFromStorage();

    // Mark that this method has been called and call super
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<bool> _saveTargetUrlToStorageAndLaunch() async {
    // Unfocus from any controls that may have focus to disengage the keyboard
    FocusScope.of(context).unfocus();

    // Validate the different form controls and return if validation issues...
    if (!_form.currentState!.validate()) return Future<bool>(() => false);

    // ...otherwise, save the form and display the loading icon
    _form.currentState!.save();

    // Store user credentials on the device storage as JSON object
    try {
      // Connect to device storage and save target url to storage
      final storage = await SharedPreferences.getInstance();
      final futureResult = await storage.setString(SPK_TARGET_URL, _targetUrl);

      setState(() {
        _targetUrlConfirmed = true;
      });

      return futureResult;
    } catch (error) {
      throw error;
    }
  }

  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Control (Dev Mode)'),
        actions: <Widget>[
          if (_targetUrlConfirmed)
            WebviewNavigationControls(_controller.future),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _futureLoadTargetUrl,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          else {
            return _targetUrlConfirmed
                ? WebView(
                    initialUrl: _targetUrl,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _form,
                      child: ListView(
                        children: [
                          TextFormField(
                            initialValue: _targetUrl,
                            decoration: InputDecoration(
                              labelText: 'Your Device\'s IP ',
                              hintText: 'EX: http://192.168.4.1',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              _saveTargetUrlToStorageAndLaunch();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Please provide a URL';
                              else if (!value.startsWith('http'))
                                return 'Value must start with "http"';
                              return null;
                            },
                            onSaved: (value) {
                              _targetUrl = value!.trim();
                            },
                          ),
                          ElevatedButton(
                            child: Text("Launch"),
                            onPressed: _saveTargetUrlToStorageAndLaunch,
                          )
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}



      // _targetUrlConfirmed
      //     ? WebView(
      //         initialUrl:
      //             _targetUrl, //'https://www.google.com', //'http://192.168.4.1',
      //         onWebViewCreated: (WebViewController webViewController) {
      //           _controller.complete(webViewController);
      //         },
      //       )
      //     : Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Form(
      //           key: _form,
      //           child: ListView(
      //             children: [
      //               TextFormField(
      //                 initialValue: _targetUrl,
      //                 decoration: InputDecoration(
      //                   labelText: 'Your Device\'s IP ',
      //                   hintText: 'EX: http://192.168.4.1',
      //                   hintStyle: TextStyle(color: Colors.grey),
      //                 ),
      //                 textInputAction: TextInputAction.done,
      //                 onFieldSubmitted: (_) {
      //                   _saveTargetUrlToStorageAndLaunch();
      //                 },
      //                 validator: (value) {
      //                   if (value == null || value.isEmpty)
      //                     return 'Please provide a URL';
      //                   else if (!value.startsWith('http'))
      //                     return 'Value must start with "http"';
      //                   return null;
      //                 },
      //                 onSaved: (value) {
      //                   _targetUrl = value!.trim();
      //                 },
      //               ),
      //               ElevatedButton(
      //                 child: Text("Launch"),
      //                 onPressed: _saveTargetUrlToStorageAndLaunch,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),





// WebView(
//         initialUrl:
//             _targetUrl, //'https://www.google.com', //'http://192.168.4.1',
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//       ),