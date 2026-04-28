import 'package:flutter/material.dart';
import 'package:route/home/tabs/fav/fav.dart';
import 'package:route/home/tabs/home/home_tab.dart';
import 'package:route/home/tabs/map/map.dart';
import 'package:route/home/tabs/profile/profile_tab.dart';
import 'package:route/utils/app_assets.dart';
import 'package:route/utils/app_colors.dart';
import 'package:route/l10n/app_localizations.dart';

import '../utils/app_routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;
  List tabs = [HomeTab(), MapTab(), FavTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo: add event
          Navigator.pushNamed(context, AppRoutes.addEventRouteName);
        },
        child: Icon(Icons.add, color: AppColors.whiteColor),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          builtBottomNavigationBarItem(
            selectedIcon: AppAssets.selectedHomeIcon,
            index: 0,
            unSelectedIcon: AppAssets.homeIcon,
            label: AppLocalizations.of(context)!.home,
          ),
          builtBottomNavigationBarItem(
            selectedIcon: AppAssets.selectedMapIcon,
            index: 1,
            unSelectedIcon: AppAssets.mapIcon,
            label: AppLocalizations.of(context)!.map,
          ),
          builtBottomNavigationBarItem(
            selectedIcon: AppAssets.selectedFavIcon,
            index: 2,
            unSelectedIcon: AppAssets.favIcon,
            label: AppLocalizations.of(context)!.fav,
          ),
          builtBottomNavigationBarItem(
            selectedIcon: AppAssets.selectedProfileIcon,
            index: 3,
            unSelectedIcon: AppAssets.profileIcon,
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String selectedIcon,
    required int index,
    required String unSelectedIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(selectedIndex == index ? selectedIcon : unSelectedIcon),
      ),
      label: label,
    );
  }
}
