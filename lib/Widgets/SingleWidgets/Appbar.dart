import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Set leading property to IconButton with your asset icon
      leading: IconButton(
        icon: Image.asset(
            'Assets/BackArrow.png',width: 22,height: 22,), // Replace 'your_icon.png' with your asset path
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
   @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
