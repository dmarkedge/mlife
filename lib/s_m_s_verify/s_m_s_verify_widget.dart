import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SMSVerifyWidget extends StatefulWidget {
  SMSVerifyWidget({Key key}) : super(key: key);

  @override
  _SMSVerifyWidgetState createState() => _SMSVerifyWidgetState();
}

class _SMSVerifyWidgetState extends State<SMSVerifyWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        width: 330,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: TextFormField(
                            controller: textController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Verify SMS Code',
                              labelStyle: FlutterFlowTheme.bodyText2.override(
                                fontFamily: 'Montserrat',
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w500,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                            ),
                            style: FlutterFlowTheme.bodyText2.override(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF8B97A2),
                              fontWeight: FontWeight.w500,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0.95, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (textController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter SMS verification code.'),
                          ),
                        );
                        return;
                      }
                      final phoneVerifiedUser = await verifySmsCode(
                        context: context,
                        smsCode: textController.text,
                      );
                      if (phoneVerifiedUser == null) {
                        return;
                      }
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavBarPage(initialPage: 'HomePage'),
                        ),
                        (r) => false,
                      );
                    },
                    text: 'Continue',
                    options: FFButtonOptions(
                      width: 140,
                      height: 60,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      elevation: 2,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: 8,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
