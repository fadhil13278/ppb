// helpers/drawer_navigation.dart
import 'package:flutter/material.dart';
import 'package:fluttertodolistsqfliteapp/screens/categories_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/home_screen.dart';
import 'package:fluttertodolistsqfliteapp/screens/todos_by_category.dart';
import 'package:fluttertodolistsqfliteapp/services/category_service.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>.empty(growable: true);  // Updated initialization

  CategoryService _categoryService = CategoryService();

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();
    List<Widget> tempList = [];  // Temporary list to hold widgets

    categories.forEach((category) {
      tempList.add(InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodosByCategory(category: category['name']))),
        child: ListTile(
          title: Text(category['name']),
        ),
      ));
    });

    if (mounted) {  // Check if the widget is still in the widget tree
      setState(() {
        _categoryList = tempList;  // Update the category list once
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://img.mbizmarket.co.id/company/thumbs/343x343/2022/09/12/762f3757bf5ac71316d40ae9f3460e3a.jpg'),
            ),
            accountName: Text('Muhammad Fadhil Wijanarko'),
            accountEmail: Text('mfadhilwij@gmail.com'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Beranda'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('Kategori'),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CategoriesScreen())),
          ),
          Divider(),
          ..._categoryList,  // Use spread operator to insert all items as individual children
        ],
      ),
    );
  }
}
