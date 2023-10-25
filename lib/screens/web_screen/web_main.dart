import 'package:ecommerce/screens/web_screen/add_product.dart';
import 'package:ecommerce/screens/web_screen/dashboardscreen.dart';
import 'package:ecommerce/screens/web_screen/delete_screen.dart';
import 'package:ecommerce/screens/web_screen/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class Web_Main extends StatefulWidget {
  static const String id = 'web_main';

  const Web_Main({super.key});

  @override
  State<Web_Main> createState() => _Web_MainState();
}

class _Web_MainState extends State<Web_Main> {
  Widget selectedscreen = const DashBoard();

  void chooseScreen(item) {
    switch (item) {
      // Use 'item.route' instead of 'item.routes'
      case DashBoard.id:
        setState(() {
          selectedscreen = const DashBoard();
        });
        break;
      case Add_Product_Screen.id:
        setState(() {
          selectedscreen = const Add_Product_Screen();
        });
        break;
      case Update_Product_Screen.id:
        setState(() {
          selectedscreen = const Update_Product_Screen();
        });
        break;
      case Delete_Product_Screen.id:
        setState(() {
          selectedscreen = const Delete_Product_Screen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          title: const Text("admin Pannel"),
        ),
        sideBar: SideBar(
            onSelected: (item) {
              chooseScreen(item.route);
              //  Navigator.of(context).pushNamed(item.route!);
            },
            items: const [
              AdminMenuItem(
                title: 'Dashboard',
                icon: Icons.dashboard_customize_outlined,
                route: DashBoard.id,
              ),
              AdminMenuItem(
                title: 'Add Products',
                icon: Icons.add,
                route: Add_Product_Screen.id,
              ),
              AdminMenuItem(
                title: 'update products',
                icon: Icons.update,
                route: Update_Product_Screen.id,
              ),
              AdminMenuItem(
                title: 'delete ites',
                icon: Icons.delete,
                route: Delete_Product_Screen.id,
              )
            ],
            selectedRoute: Web_Main.id),
        body: selectedscreen);
  }
}
