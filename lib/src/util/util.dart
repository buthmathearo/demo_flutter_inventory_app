import 'package:demo_flutter_inventory_app/src/model/item.dart';

const ASSET_PATH = 'assets/';

String getAsset(String name) {
  return ASSET_PATH + name;
}

bool isAsset(String path) {
  return path.startsWith(ASSET_PATH);
}

List<Item> generateSampleListItems() {
  return [
    Item(
        productName: 'Coca Cola',
        price: 0.5,
        quantity: 5,
        supplierName: 'Coca Shop Phnom Penh',
        supplierPhone: '010339939',
        supplierEmail: 'coca@phnompenh.com',
        imagePath: getAsset('img_coca_cola_can.png')),
    Item(
        productName: 'Pepsi',
        price: 0.4,
        quantity: 1,
        supplierName: 'Pepi Shop Cambodia',
        supplierPhone: '0123300939',
        supplierEmail: 'pepsi@phnompenh.com',
        imagePath: getAsset('img_pepsi_can.png')),
  ];
}
