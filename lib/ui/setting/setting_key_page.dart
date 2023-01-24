import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:test/ui/qrcode/qrcode_password.dart';
import 'package:test/ui/widget/settingwidget/share_widget.dart';
import 'package:test/ui/widget/page_title_widget.dart';
import '../../Classes/localization/translation.dart';
import '../popup/popupError.dart';
import '../widget/settingwidget/setting_button.dart';

class SettingKeyPage extends StatefulWidget {
  const SettingKeyPage({Key? key}) : super(key: key);

  @override
  State<SettingKeyPage> createState() => _SettingKeyPage();
}

class _SettingKeyPage extends State<SettingKeyPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double w = size.width; //* MediaQuery.of(context).devicePixelRatio;
    double h = size.height; // * MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              child: Row(children: [
                PageTitleW(
                    title: LanguageTranslation.of(context)!
                        .text('key_setting_page_title')),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      const IconData(0xf141,
                          fontFamily: 'MaterialIcons',
                          matchTextDirection: true),
                      size: w * 0.06,
                    ))
              ]),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.02),
              decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                  borderRadius: BorderRadius.circular(w * 0.01)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showQrcodePassword(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(h * 0.02),
                            child: Row(children: [
                              Icon(
                                const IconData(0xe4f6,
                                    fontFamily: 'MaterialIcons'),
                                size: w * 0.08,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      LanguageTranslation.of(context)!
                                          .text('qrcode_title'),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: w * 0.05)),
                                  Text(
                                    LanguageTranslation.of(context)!
                                        .text('qrcode_decription'),
                                    style: TextStyle(
                                        fontSize: w * 0.02,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                const IconData(0xe355,
                                    fontFamily: 'MaterialIcons'),
                                size: w * 0.06,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            try {
                              await showShare(context);
                            } on FormatException catch (e) {
                              showAlertDialog(context, e.message);
                            } on PlatformException catch (e2) {
                              showAlertDialog(context, "Platform");
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(h * 0.02),
                            child: Row(children: [
                              Icon(
                                const IconData(0xf052b,
                                    fontFamily: 'MaterialIcons'),
                                size: w * 0.08,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      LanguageTranslation.of(context)!
                                          .text('file_title'),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: w * 0.05)),
                                  Text(
                                    LanguageTranslation.of(context)!
                                        .text('file_description'),
                                    style: TextStyle(
                                        fontSize: w * 0.02,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Icon(
                                const IconData(0xe355,
                                    fontFamily: 'MaterialIcons'),
                                size: w * 0.06,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: w * 0.02),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(w * 0.01)),
                child: SettingButtonWidget(
                  title: LanguageTranslation.of(context)!
                      .text('key_restore_title'),
                  content: LanguageTranslation.of(context)!
                      .text('key_restore_description'),
                  icon: const IconData(0xf052b, fontFamily: 'MaterialIcons'),
                  page: const SettingKeyPage(),
                )),
            SizedBox(
              height: h * 0.05,
            ),
          ],
        ))));
  }
}
