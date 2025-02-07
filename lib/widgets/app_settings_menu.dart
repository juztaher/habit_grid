import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_grid/utils/constants.dart';

class AppSettingsMenu extends StatelessWidget {
  final VoidCallback onClearAllData;
  final VoidCallback onLogout;

  const AppSettingsMenu({
    super.key,
    required this.onClearAllData,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text(
                  "CLEAR ALL DATA",
                  style: kAppSettingTextStyle,
                ),
                onTap: onClearAllData, // Call the provided callback
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 60, 0),
                child: Divider(
                  // Add the Divider below the ListTile
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: const Text(
                  "LOGOUT",
                  style: kAppSettingTextStyle,
                ),
                onTap: onLogout, // Call the provided callback
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 60, 0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -60,
          right: 20,
          child: FloatingActionButton(
            onPressed: () => Get.back(),
            backgroundColor: Colors.white,
            elevation: 4,
            mini: true,
            shape: const CircleBorder(),
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
