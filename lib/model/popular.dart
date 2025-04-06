import 'package:cloud_firestore/cloud_firestore.dart';

class PopularCategory {
  final String category;
  final String id;

  PopularCategory({this.category = '', this.id = ''});
}

class Product {
  String title;
  double star;
  int sold; 
  double price;
  String icon;
  String pid;
  String category;
  String cid;
  List<dynamic> detail;
  List<dynamic> images;
  int inStock = 10;
  String lastDescr;
  Map<String,dynamic> offer;  
  String provider;
  String sid;
  Map<String,dynamic> size;
  int rateCount=0;
  List<dynamic> ratedBy = [];
  int buyQty=1;
  List<dynamic> variant = [];
  

  Product({
    this.title = '', 
    this.star = 0.0, 
    this.sold = 0, 
    this.price = 0.0, 
    this.icon = '', 
    this.pid = '0',
    this.category="",
    this.cid="",
    this.detail=const[],
    this.images=const[],
    this.lastDescr="",
    this.offer=const{},
    this.provider="", 
    this.sid="",
    this.size=const{},
    this.buyQty=0,
    this.rateCount=0,
    this.inStock=0,
    this.ratedBy=const[],
    this.variant=const[],
  });


  // Product.empty({
  //   this.category="",
  //   this.buyQty=1,
  //   this.detail = const[],
  //   this.images=const[],
  //   this.lastDescr="",
  //   this.offer=const{},
  //   this.price=const{},
  //   this.productId="",
  //   this.productName="",
  //   this.providerName="",
  //   this.rateCount="",
  //   this.ratedBy=const[],
  //   this.rating="", 
  //   this.size=const{},
  //   this.variants=const[],
  //   this.avalibalStock=0,
  //   this.soldStock=0,
  //   this.total=0,
  //   this.sellId="",
  //   this.comId="",
  // });

  factory Product.fromMap(Map<String,dynamic> data) => Product(
    buyQty: data["buy_qty"],
    pid: data['pid'],
    category: data['category'],
    detail: data['detail'] ?? const[],
    images: data['images'],
    lastDescr: data['last_descr'],
    title: data['name'],
    offer: data['offer'],
    price: data['price']["new"],
    rateCount: int.tryParse(data['rate_count'].toString()) ?? 0,
    ratedBy: data['rated_by'] ?? [],
    star: double.tryParse(data['rating'].toString()) ?? 0,
    size: data['size'],
    variant: data['variants'] ?? const[],
    provider: data['provider'] ?? "",
    inStock: data['in_stock'] ?? 0,
    sold: data['sold_stock'] ?? 0,
    // : data['total_stock'] ?? 0,
    sid: data['sid'],
    cid: data['cid'],
  );

  Map<String,dynamic> toMap() => {
    
    "pid": pid,
    "category": category,
    "buy_qty": 1,
    "detail": detail,
    "images": images,
    "last_descr": lastDescr,
    "name": title,
    "offer": offer,
    "price": {
      "new": price,
      "old": 0,
    },
    "rate_count": rateCount,
    "rated_by": ratedBy,
    "rating": star,
    "size": size,
    "variants": [],
    "provider": "",
    "in_stock": inStock,
    "sold_stock": 0,
    "total_stock": inStock,
    "sid": sid,
    "cid": cid,
  };


  factory Product.fromSnap(DocumentSnapshot snapshot) => Product(
    buyQty: snapshot.get('buy_qty') ?? 1,
    pid: snapshot.get('pid'),
    category: snapshot.get('category'),
    detail: snapshot.get('detail') ?? [],
    images: snapshot.get('images') ?? [], 
    lastDescr: snapshot.get('last_descr'),
    title: snapshot.get('name'),
    offer: snapshot.get('offer'),
    price: double.tryParse(snapshot.get('price')["new"].toString()) ?? 0,
    rateCount: int.tryParse(snapshot.get('rate_count').toString()) ??0,
    ratedBy: snapshot.get('rated_by') ?? [],
    star: double.tryParse(snapshot.get('rating').toString()) ?? 0,
    size: snapshot.get('size'),
    variant: snapshot.get('variants') ?? [],
    provider: snapshot.get('provider'),
    inStock: snapshot.get('in_stock'),
    sold: snapshot.get('sold_stock'),
    sid: snapshot.get('sid'),
    cid: snapshot.get('cid'),
  );

}

final homePopularCategories = [
  PopularCategory(category: 'All', id: '1'),
  PopularCategory(category: 'Chair', id: '2'),
  PopularCategory(category: 'Kitchen', id: '3'),
  PopularCategory(category: 'Table', id: '4'),
  PopularCategory(category: 'Lamp', id: '5'),
  PopularCategory(category: 'Cupboard', id: '6'),
  PopularCategory(category: 'Vase', id: '7'),
  PopularCategory(category: 'Others', id: '8'),
];

final homePopularProducts = [
  Product(
    title: 'Foam Padded Chair',
    star: 4.5,
    sold: 8374,
    price: 120.00,
    icon: 'assets/icons/products/foam_padded_chair@2x.png',
  ),
  Product(
    title: 'Small Bookcase',
    star: 4.7,
    sold: 7483,
    price: 145.40,
    icon: 'assets/icons/products/book_case@2x.png',
  ),
  Product(
    title: 'Glass Lamp',
    star: 4.3,
    sold: 6937,
    price: 40.00,
    icon: 'assets/icons/products/lamp.png',
  ),
  Product(
    title: 'Glass Package',
    star: 4.9,
    sold: 8174,
    price: 55.00,
    icon: 'assets/icons/products/class_package@2x.png',
  ),
  Product(
    title: 'Plastic Chair',
    star: 4.6,
    sold: 6843,
    price: 65.00,
    icon: 'assets/icons/products/plastic_chair@2x.png',
  ),
  Product(
    title: 'Wooden Chairs',
    star: 4.5,
    sold: 7758,
    price: 69.00,
    icon: 'assets/icons/products/wooden_chairs.png',
  ),
];
