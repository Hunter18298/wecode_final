import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecode_final/providers/product_provider.dart';
import 'package:wecode_final/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {Key? key, required this.imageUrl, required this.title, required this.id})
      : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          children: [
            IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              onPressed: () {
                Provider.of<Products>(context, listen: false).removeProduct(id);
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
