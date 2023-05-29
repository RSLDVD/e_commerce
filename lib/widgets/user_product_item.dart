import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
//
import '../providers/products.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String image;
  final String id;
  //
  // ignore: use_key_in_widget_constructors
  const UserProductItem(this.id, this.title, this.image);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(2.5),
          child: Image.asset(image),
        ),
      ),
      trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                  onPressed: (() {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.routeName, arguments: id);
                  }),
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff12cad6),
                  )),
              IconButton(
                  onPressed: (() {
                    Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  }),
                  icon: SvgPicture.asset(
                    "assets/icons/delete.svg",
                    colorBlendMode: BlendMode.color,
                    height: 30,
                  ))
            ],
          )),
    );
  }
}
