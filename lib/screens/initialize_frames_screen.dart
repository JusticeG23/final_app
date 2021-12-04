// Flutter imports
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// File imports
import '../widgets/navigation/app_drawer.dart';

//////////////////////////////////////////////////////////////////
// StateFUL widget which manages state. Simply initializes the
// state object.
//////////////////////////////////////////////////////////////////
class InitializeFramesScreen extends StatefulWidget {
  // Route name declaration
  static const routeName = '/initialize-frames';

  @override
  _InitializeFramesScreenState createState() => _InitializeFramesScreenState();
}

//////////////////////////////////////////////////////////////////
// THe actual STATE which is managed by the above widget.
//////////////////////////////////////////////////////////////////
class _InitializeFramesScreenState extends State<InitializeFramesScreen> {
  // The "instance variables" managed in this state
  var _isLoading = false;
  var _wifiNetworkName = '';
  var _wifiPassword = '';
  var _globePassword = '';

  // Finals used in this widget
  final _form = GlobalKey<FormState>();
  final _wifiPasswordFocusNode = FocusNode();
  final _globeUsernameFocusNode = FocusNode();
  final _globePasswordFocusNode = FocusNode();

  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  /// Helper Methods (for state object)
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////
  //
  ////////////////////////////////////////////////////////////////
  Future<void> _submitFormOverBluetooth() async {
    // Unfocus from any controls that may have focus to disengage the keyboard
    FocusScope.of(context).unfocus();

    // Validate the different form controls and return if validation issues...
    if (!_form.currentState!.validate()) return;

    // ...otherwise, save the form and display the loading icon
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    // Attempt to send authentication data to FRAMES via Bluetooth

    // Simulate action by taking dummy delay and hardcode result (pass/fail)
    await Future.delayed(Duration(seconds: 1));
    var bluetoothSuccess = true;

    // Check if bluetooth synced properly
    if (!bluetoothSuccess) {
      // Display snackbar with error status
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.bluetooth_disabled,
                color: Colors.white,
              ),
              Text('Failed to sync info to Frames via Bluetooth.'),
            ],
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else {
      // Data synced so clear from state
      _wifiNetworkName = '';
      _wifiPassword = '';
      _globePassword = '';

      // Display snackbar with success status
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.bluetooth,
                color: Colors.white,
              ),
              Text('Bluetooth sync succesful.'),
            ],
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }

    // Update the display by removing loading widget and pop the screen
    setState(() {
      _isLoading = false;
    });
    // Navigator.of(context).pop();
  }

  ////////////////////////////////////////////////////////////////
  // Primary Flutter method overriden which describes the layout
  // and bindings for this widget.
  ////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Finals used in this widget
    final user = FirebaseAuth.instance.currentUser;
    //final Future<String> _token = user!.getIdToken(true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Initialize Frames'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitFormOverBluetooth,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _wifiNetworkName,
                      decoration: InputDecoration(
                        labelText: 'WiFi Network Name',
                        hintText: 'YourWifiName',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      maxLength: 32,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_wifiPasswordFocusNode);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please provide a network name.';
                        if (value.length > 32)
                          return 'WiFi network name must be less than 32 characters';
                        return null;
                      },
                      onSaved: (value) {
                        _wifiNetworkName = value!.trim();
                      },
                    ),
                    TextFormField(
                      initialValue: _wifiPassword,
                      decoration: InputDecoration(
                        labelText: 'WiFi Password',
                        hintText: 'Leave blank if no WiFi password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      obscureText: true,
                      focusNode: _wifiPasswordFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_globePasswordFocusNode);
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty)
                      //     return 'Please provide a WiFi password.';
                      //   return null;
                      // },
                      onSaved: (value) {
                        _wifiPassword = value!.trim();
                      },
                    ),
                    // TextFormField(
                    //   initialValue: user!.email,
                    //   readOnly: true,
                    //   decoration: InputDecoration(
                    //     labelText: 'Globe User Email',
                    //   ),
                    //   focusNode: _globeUsernameFocusNode,
                    //   textInputAction: TextInputAction.next,
                    //   onFieldSubmitted: (_) {
                    //     FocusScope.of(context)
                    //         .requestFocus(_globePasswordFocusNode);
                    //   },
                    // ),
                    TextFormField(
                      initialValue: _globePassword,
                      decoration: InputDecoration(
                        labelText: 'Globe User Password',
                        hintText: 'YourGlobePassword',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      obscureText: true,
                      focusNode: _globePasswordFocusNode,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        _submitFormOverBluetooth();
                      },
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please provide a Globe User password.';
                        return null;
                      },
                      onSaved: (value) {
                        _globePassword = value!.trim();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
