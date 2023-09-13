import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'const_widgets.dart';



class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String selectedLanguage;
  bool isDropdownOpened = false;
  List<String> listLang = ["English", "Portuguese"];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    selectedLanguage = 'English';

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.locale == const Locale('en')) {
      //if (context.locale == const Locale('es')) {}
      selectedLanguage = 'English';
    } else {
      selectedLanguage = 'Portuguese';
    }
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                toggleDropdown();
              },
              child: Container(
                width: 200.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language,color: Colors.black),
                      onPressed: toggleDropdown,
                    ),
                    sizedBox10(),
                    Text(
                      selectedLanguage,
                      style: const TextStyle(fontSize: 16.0,color: Colors.black),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(isDropdownOpened
                          ? Icons.arrow_drop_down
                          : Icons.arrow_left_outlined,color: Colors.black,size: 20,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isDropdownOpened)
            Positioned(
              top: 45.0,
              left: 0,
              right: 0,
              child: Container(
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listLang.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(listLang[index],style: const TextStyle(color: Colors.black),),
                    onTap: () {
                      if (listLang[index] == "English") {
                        context.setLocale(const Locale('en'));
                      } else {
                        context.setLocale(const Locale('es'));
                      }
                      setState(() {
                        selectedLanguage = listLang[index];
                        isDropdownOpened = false;

                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpened = !isDropdownOpened;
    });
  }
}
