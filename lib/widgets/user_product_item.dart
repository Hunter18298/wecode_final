import 'package:flutter/material.dart';
import 'package:wecode_final/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({Key? key, required this.imageUrl, required this.title})
      : super(key: key);
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
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              onPressed: () {},
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
