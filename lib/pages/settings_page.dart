import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../customicon/custom_icons.dart';
import '../providers/locale_provider.dart';
import '../providers/notification_provider.dart';
import '../providers/theme_provider.dart';
import '../utilities/constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Provider.of<ThemeProvider>(context).darkTheme;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.generalSettings,
                ),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.notfication),
                value:
                    Provider.of<NotificationProvider>(context).checkNotfication,
                secondary: const IconWidget(
                  icon: Icons.notifications_none,
                  color: Colors.green,
                ),
                onChanged: (value) {
                  Provider.of<NotificationProvider>(context, listen: false)
                      .toggleNotfication();
                },
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.darkMode,
                ),
                value: isDarkTheme,
                secondary: const IconWidget(
                  icon: Icons.dark_mode,
                  color: Color(0xFF7F38EC),
                ),
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(AppLocalizations.of(context)!.changeLanguge),
                leading: const IconWidget(
                  icon: CustomIcon.globe,
                  color: Color(0xFF1A8483),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: isDarkTheme
                              ? Colors.black.withOpacity(.80)
                              : const Color(0xFF737373),
                          child: Container(
                            decoration: BoxDecoration(
                                color: isDarkTheme
                                    ? kSecondaryColor
                                    : Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView(
                                children: [
                                  const Divider(
                                    thickness: 3,
                                    indent: 100,
                                    endIndent: 100,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Text(
                                          "Choose Language",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.cancel_presentation_rounded),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("English"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('en', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("বাংলা"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('bn', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("عربى"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('ar', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("Español"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('es', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("Deutsch"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('de', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      title: const Text("हिन्दी"),
                                      leading: const Icon(Icons.flag),
                                      onTap: () {
                                        Provider.of<LocaleProvider>(context,
                                                listen: false)
                                            .setLocale(const Locale('hi', ''));
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  const ListTileDivider(),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(AppLocalizations.of(context)!.about),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.termsAndConditions),
                leading: const IconWidget(
                  icon: CustomIcon.note,
                  color: Colors.red,
                ),
                onTap: () async {
                  await launchUrl(Uri.parse(
                      "https://newspro.abdulmomin.com/privacy-policy"));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(AppLocalizations.of(context)!.about),
                leading: const IconWidget(
                  icon: CustomIcon.note,
                  color: Color.fromARGB(255, 63, 63, 63),
                ),
                onTap: () async {
                  await launchUrl(Uri.parse(
                      "https://newspro.abdulmomin.com/privacy-policy"));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(AppLocalizations.of(context)!.privacyPolicy),
                leading: const IconWidget(
                  icon: Icons.lock_outline,
                  color: Colors.green,
                ),
                onTap: () async {
                  await launchUrl(Uri.parse(
                      "https://newspro.abdulmomin.com/privacy-policy"));
                },
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(AppLocalizations.of(context)!.rateThisApp),
                leading: const IconWidget(
                  icon: Icons.star_outline,
                  color: Colors.blue,
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.social,
                ),
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.contactUs),
                leading: const IconWidget(
                  icon: Icons.contact_mail,
                  color: Color.fromARGB(255, 63, 63, 63),
                ),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              ListTile(
                title: Text(AppLocalizations.of(context)!.website),
                leading: const IconWidget(
                  icon: CustomIcon.world,
                  color: Colors.green,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class ListTileDivider extends StatelessWidget {
  const ListTileDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1,
      indent: 10,
      endIndent: 10,
      color: Colors.grey.withOpacity(0.20),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({Key? key, this.icon, this.color}) : super(key: key);

  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
