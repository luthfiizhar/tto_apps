import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/constant/constant.dart';
import 'package:tto_apps/constant/text.dart';
import 'package:tto_apps/pages/detail_picture.dart';
import 'package:tto_apps/widgets/items_tile.dart';
import 'package:http/http.dart' as http;

class HistoryDetailPage extends StatefulWidget {
  HistoryDetailPage({
    super.key,
    this.formId,
    this.status = "",
  });

  String? formId;
  String? status;
  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  String nip = "";
  String origin = "";
  String destination = "";
  String createdDate = "";
  String creatorNip = "";
  String creatorName = "";
  String approverNip = "";
  String approverName = "";
  String notes = "";
  String approvedNotes = "";
  String license = "";

  String securityApproveDate = "";

  String urlPhotoDriver = "";
  String urlIdCard = "";
  String urlSignature = "";
  String urlLicense = "";
  String urlItems = "";

  bool isLoading = false;

  List itemList = [];

  late Image _imageDriver = Image(image: NetworkImage(''));
  late Image _imageVehicle = Image(image: NetworkImage(''));
  late Image _imageVehicleSec = Image(image: NetworkImage(''));
  late Image _imageItems = Image(image: NetworkImage(''));
  late Image _imageSignature = Image(image: NetworkImage(''));

  bool imageDriverLoading = true;
  bool imageVehicleLoading = true;
  bool imageVehicleSecLoading = true;
  bool imageItemsLoading = true;
  bool imageSignatureLoading = true;

  List<ItemsListTile> tilesItem = [];
  Items item = Items();
  List<Items> _itemList = [];
  List carrier = [
    {'VehicleLicense': ''}
  ];

  Future getFormDetail(String id) async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.https(
        apiUrlGlobal, 'ExitPassHOBackend/public/api/form/security/detail/$id');
    Map<String, String> requestHeader = {"Content-Type": "application/json"};

    try {
      var response = await http.get(url, headers: requestHeader);

      var data = json.decode(response.body);

      return data;
    } on Error catch (e) {
      return e;
    }
  }

  showPhoto(String urlPhoto) {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getFormDetail(widget.formId!).then((value) {
      print(value);
      setState(() {
        isLoading = false;
        origin = value['Data']['ItemOrigin'];
        destination = value['Data']['ItemDestination'];
        creatorName = value['Data']['CreatorName'];
        creatorNip = value['Data']['FormCreator'];
        createdDate = value['Data']['CreatedDate'];
        approverName = value['Data']['ApprovedName'];
        approverNip = value['Data']['ApprovedBy'];
        notes = value['Data']['ApprovedNotes'];
        itemList = value['Data']['Items'];
        carrier = value['Data']['Carriers'];
        nip = value['Data']['SecurityApprove'] ?? "";

        securityApproveDate = value['Data']['SecurityApproveDate'] ?? "";
        approvedNotes = value['Data']['SecurityNotes'] ?? "";
        urlSignature = value['Data']['SecuritySignature'] ?? "";
        urlLicense = value['Data']['SecurityPhotoVehicle'] ?? "";
        urlItems = value['Data']['SecurityPhotoGoods'] ?? "";
        // license = value['Data']['VehicleLicense'];
        _imageDriver = Image.network(carrier.first['FacePhoto']);
        _imageVehicle = Image.network(carrier.first['VehiclePhoto']);
        _imageVehicleSec =
            Image.network(value['Data']['SecurityPhotoVehicle'] ?? "");
        _imageItems = Image.network(value['Data']['SecurityPhotoGoods'] ?? "");
        _imageSignature =
            Image.network(value['Data']['SecuritySignature'] ?? "");

        print(carrier);
        var index = 0;
        for (var element in itemList) {
          // item.id = element['ItemID'];
          // item.name = element['ItemName'];
          // item.qty = int.parse(element['Quantity']);
          // item.unit = element['UnitName'];
          _itemList.add(Items(
            id: element['ItemID'],
            isSame: element['SameAsForm'],
            name: element['ItemName'],
            qty: int.parse(element['Quantity']),
            unit: element['UnitName'],
            url: element['Photo'],
          ));
          // tilesItem.add(ItemsListTile(
          //   itemModel: item,
          //   changeCondition: onChangeCondition,
          //   showDialog: showPhoto,
          // ));
          tilesItem.add(ItemsListTile(
            itemModel: _itemList[index],
            changeCondition: () {},
            showDialog: showPhoto,
          ));
          index++;
        }
        _imageDriver.image
            .resolve(ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          if (mounted) {
            setState(() {
              imageDriverLoading = false;
            });
          }
        }));

        _imageVehicle.image
            .resolve(ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          if (mounted) {
            setState(() {
              imageVehicleLoading = false;
            });
          }
        }));

        _imageVehicleSec.image
            .resolve(ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          if (mounted) {
            setState(() {
              imageVehicleSecLoading = false;
            });
          }
        }));

        _imageItems.image
            .resolve(ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          if (mounted) {
            setState(() {
              imageItemsLoading = false;
            });
          }
        }));

        _imageSignature.image
            .resolve(ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          if (mounted) {
            setState(() {
              imageSignatureLoading = false;
            });
          }
        }));
        // for (var element in _itemList) {
        //   tilesItem.add(ItemsListTile(
        //     itemModel: element,
        //     changeCondition: () {},
        //     showDialog: showPhoto,
        //   ));
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: eerieBlack,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      carrier != [] ? carrier.first['VehicleLicense'] : "",
                      style: helveticaText.copyWith(
                        fontSize: 22,
                        color: eerieBlack,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    detailSection(),
                    const SizedBox(
                      height: 30,
                    ),
                    listItemSection(),
                    const SizedBox(
                      height: 30,
                    ),
                    widget.status == "VERIFIED" || widget.status == "DECLINED"
                        ? formSection()
                        : SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  detailSection() {
    return Column(
      children: [
        detailRow('Form ID', widget.formId!),
        const SizedBox(
          height: 15,
        ),
        detailRowStatus('Status', widget.status!),
        const SizedBox(
          height: 15,
        ),
        detailRow('Lokasi Asal', origin),
        const SizedBox(
          height: 15,
        ),
        detailRow('Tujuan', destination),
        const SizedBox(
          height: 15,
        ),
        detailRow('Pembuat', '$creatorNip - $creatorName'),
        const SizedBox(
          height: 15,
        ),
        detailRow('Tanggal Dibuat', createdDate),
        const SizedBox(
          height: 15,
        ),
        detailRow('Disetujui Oleh', '$approverNip - $approverName'),
        const SizedBox(
          height: 15,
        ),
        detailRow('Catatan', notes),
        const SizedBox(
          height: 15,
        ),
        // detailRowList('Items', 'Tap to show items'),
        // const SizedBox(
        //   height: 15,
        // ),
        detailRow('No. Kendaraan', carrier.first['VehicleLicense']),
        const SizedBox(
          height: 15,
        ),
        detailRowList('', carrier.first['VehiclePhoto'], _imageVehicle,
            imageVehicleLoading),
        const SizedBox(
          height: 15,
        ),
        detailRow('Supir', carrier.first['Name']),
        const SizedBox(
          height: 15,
        ),
        detailRowList(
            '', carrier.first['FacePhoto'], _imageDriver, imageDriverLoading),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  detailRowStatus(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 135,
          child: Text(
            title,
            style: helveticaText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: eerieBlack,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            content,
            maxLines: 3,
            style: helveticaText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: widget.status! == 'VERIFIED' || widget.status == 'APPROVED'
                  ? greenAcent
                  : orangeAccent,
            ),
          ),
        ),
      ],
    );
  }

  detailRow(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 135,
          child: Text(
            title,
            style: helveticaText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: eerieBlack,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            content,
            maxLines: 3,
            style: helveticaText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: eerieBlack,
            ),
          ),
        ),
      ],
    );
  }

  detailRowList(String title, String url, Image image, bool loading) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 135,
          child: Text(
            title,
            style: helveticaText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: eerieBlack,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => PictureDetail(
                  urlImage: url,
                ),
              );
            },
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: platinum,
                // image: DecorationImage(
                //   image: image.image,
                //   // image: NetworkImage(
                //   //   url,
                //   // ),
                //   // image: Image.network(
                //   //   url,
                //   //   loadingBuilder: (context, child, loadingProgress) {
                //   //     return Center(
                //   //       child: CircularProgressIndicator(
                //   //         color: eerieBlack,
                //   //         value: loadingProgress!.expectedTotalBytes != null
                //   //             ? loadingProgress.cumulativeBytesLoaded /
                //   //                 loadingProgress.expectedTotalBytes!
                //   //             : null,
                //   //       ),
                //   //     );
                //   //   },
                //   // ).image,
                //   fit: BoxFit.contain,
                // ),
              ),
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: eerieBlack,
                      ),
                    )
                  : image,
            ),
          ),
        ),
        // Expanded(
        //   child: GestureDetector(
        //     onTap: () {
        //       showDialog(
        //         context: context,
        //         builder: (context) => VehicleDetailDialog(
        //           vehicleLicense: carrier.first['VehicleLicense'],
        //           urlImageDriver: carrier.first['FacePhoto'],
        //           urlImageIdCard: carrier.first['VehiclePhoto'],
        //         ),
        //       );
        //     },
        //     child: Text(
        //       url,
        //       style: helveticaText.copyWith(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w400,
        //         color: onyxBlack,
        //         decoration: TextDecoration.underline,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  listItemSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Barang',
          style: helveticaText.copyWith(
            fontSize: 22,
            color: eerieBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: tilesItem.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return tilesItem[index];
            // return Padding(
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 10,
            //   ),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: platinum,
            //     ),
            //     child: ListTile(
            //       contentPadding: const EdgeInsets.symmetric(
            //         horizontal: 16,
            //         vertical: 10,
            //       ),
            //       title: Text(
            //         itemList[index]['ItemName'],
            //         style: helveticaText.copyWith(
            //           color: eerieBlack,
            //           fontWeight: FontWeight.w700,
            //           fontSize: 20,
            //         ),
            //       ),
            //       subtitle: Padding(
            //         padding: const EdgeInsets.only(
            //           top: 10,
            //         ),
            //         child: Text(
            //           '${itemList[index]['Quantity']} ${itemList[index]['UnitName']}',
            //           style: helveticaText.copyWith(
            //             color: eerieBlack,
            //             fontWeight: FontWeight.w300,
            //             fontSize: 18,
            //           ),
            //         ),
            //       ),
            //       trailing: const Icon(
            //         Icons.photo_library_outlined,
            //         color: eerieBlack,
            //       ),
            //       onTap: () {},
            //     ),
            //   ),
            // );
          },
        )
      ],
    );
  }

  formSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Pengecekan',
          style: helveticaText.copyWith(
            fontSize: 22,
            color: eerieBlack,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        detailRow('NIP', nip),
        const SizedBox(
          height: 15,
        ),
        detailRow('Tanggal Pengecekan', securityApproveDate),
        const SizedBox(
          height: 15,
        ),
        detailRow('Catatan', approvedNotes),
        const SizedBox(
          height: 15,
        ),
        detailRowList('Foto Kendaraan', urlLicense, _imageVehicleSec,
            imageVehicleSecLoading),
        const SizedBox(
          height: 15,
        ),
        detailRowList('Foto Barang', urlItems, _imageItems, imageItemsLoading),
        const SizedBox(
          height: 15,
        ),
        detailRowList('Tanda Tangan', urlSignature, _imageSignature,
            imageSignatureLoading),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
