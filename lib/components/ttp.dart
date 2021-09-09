import 'package:shop_app/models/Product.dart';

double ttp = 0;
var pname = '';
var ppt = '';
var pimage = '';
var txt;
double tst;
void addproduct(Product product) {
  tst = 1;
  ppt = product.price;
  ttp += double.parse('$ppt ');
  pname = product.title;
  pimage = product.image;
  txt = '$pname ajouté';
}

void dellproduct() {
  if (tst == 1) {
    ttp -= double.parse('$ppt ');
    tst = 0;
    txt = '$pname supprimé ';
  }
}
