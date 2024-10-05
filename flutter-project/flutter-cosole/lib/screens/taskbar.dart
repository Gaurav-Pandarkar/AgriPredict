import 'package:flutter/material.dart';

class Taskbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Taskbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.green.shade100,
      items: [
        BottomNavigationBarItem(
          icon: Image.network(
            'https://th.bing.com/th/id/OIP.jUTH5tZ0E3r8MbVK0pH4EwHaHa?rs=1&pid=ImgDetMain',
            height: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.network(
            'https://i.pinimg.com/originals/80/37/b4/8037b419b8b1272e24712ff18162b2fa.png',
            height: 30,
          ),
          label: 'SelfNotes',
        ),
        BottomNavigationBarItem(
          icon: Image.network(
            'https://cdn0.iconfinder.com/data/icons/agriculture-147/64/12-_Agronomy_Farming_Grow_Growth_Nature-512.png',
            height: 30,
          ),
          label: 'Agronomist',
        ),
        BottomNavigationBarItem(
          icon: Image.network(
            'https://static-00.iconduck.com/assets.00/profile-circle-icon-1023x1024-ucnnjrj1.png',
            height: 30,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      onTap: (index) {
        onTap(index); // Call the passed function with the index
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home'); // Navigate to Home
            break;
          case 1:
            Navigator.pushNamed(
                context, '/self_notes'); // Navigate to SelfNotes
            break;
          case 2:
            Navigator.pushNamed(
                context, '/agronomist'); // Navigate to Agronomist
            break;
          case 3:
            Navigator.pushNamed(context, '/profile'); // Navigate to Profile
            break;
        }
      },
    );
  }
}
