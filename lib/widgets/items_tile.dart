import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/constant/text.dart';
import 'package:tto_apps/pages/detail_picture.dart';
import 'package:tto_apps/widgets/radio_button.dart';

class ItemsListTile extends StatefulWidget {
  ItemsListTile({
    super.key,
    this.itemModel,
    this.changeCondition,
    this.showDialog,
  });

  Items? itemModel;
  Function? changeCondition;
  Function? showDialog;

  @override
  State<ItemsListTile> createState() => _ItemsListTileState();
}

class _ItemsListTileState extends State<ItemsListTile> {
  Uint8List? webImage = Uint8List(8);
  String selectedValue = '1';
  bool isCompleted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.itemModel!.isSame == "YES") {
      isCompleted = true;
    }
    if (widget.itemModel!.isSame == "NO") {
      isCompleted = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: platinum,
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              widget.itemModel!.url!,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          title: Text(
            widget.itemModel!.name!,
            style: helveticaText.copyWith(
              color: eerieBlack,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              '${widget.itemModel!.qty} ${widget.itemModel!.unit}',
              style: helveticaText.copyWith(
                color: eerieBlack,
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Checkbox(
            activeColor: eerieBlack,
            value: isCompleted,
            onChanged: (value) {
              setState(() {
                if (isCompleted) {
                  isCompleted = false;
                  widget.changeCondition!("NO", widget.itemModel);
                } else {
                  isCompleted = true;
                  widget.changeCondition!("YES", widget.itemModel);
                }
              });
            },
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => PictureDetail(
                image: webImage,
                urlImage: widget.itemModel!.url,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Items {
  Items({
    this.name = "",
    this.qty,
    this.unit,
    this.id,
    this.isSame,
    this.url = "",
  });

  String? name;
  int? qty;
  String? unit;
  int? id;
  String? isSame;
  String? url;

  Map<String, dynamic> toJson() =>
      {'"ItemID"': '"$id"', '"SameAsForm"': '"$isSame"'};

  @override
  String toString() {
    // TODO: implement toString
    return "{name: $name, isSame = $isSame}";
  }
}
