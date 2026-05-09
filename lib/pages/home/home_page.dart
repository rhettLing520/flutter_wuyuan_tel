import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/diary_entry.dart';
import '../../services/diary_service.dart';
import '../message/diary_editor_page.dart';
import '../message/message_tab.dart';
import '../mine/mine_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // const HomeTab(),
    // const DiscoverTab(),
    const MessageTab(),
    const MinePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home_outlined),
          //   activeIcon: Icon(Icons.home),
          //   label: '首页',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.explore_outlined),
          //   activeIcon: Icon(Icons.explore),
          //   label: '发现',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message),
            label: '日记',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页'), centerTitle: true),
      body: const Center(child: Text('首页内容', style: TextStyle(fontSize: 24))),
    );
  }
}

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('发现'), centerTitle: true),
      body: const Center(child: Text('发现内容', style: TextStyle(fontSize: 24))),
    );
  }
}
