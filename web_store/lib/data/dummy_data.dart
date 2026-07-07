

import '../models/product.dart';
import '../models/category.dart';

final List<Category> categories = [
  Category(id: '2', name: 'ملابس',       icon: 'assets/images/clothes.png', colorValue: '0xff3F135D'),
  Category(id: '1', name: 'إلكترونيات', icon: 'assets/images/Elctronic.png' , colorValue: '0xFF6C63FF'),
  Category(id: '3', name: 'كتب',        icon: 'assets/images/Book.png', colorValue: '0xFF2196F3'),
  Category(id: '4', name: 'أثاث',       icon: 'assets/images/house.png', colorValue: '0xFFFFA726'),
  Category(id: '5', name: 'رياضة',      icon:'assets/images/ball.png', colorValue: '0xFF006B62'),
];

final List<Product> products = [
 
 Product(
     id: 'p1',
    name: 'هاتف Honor',
    price:200 ,
    description: 'هاتف رهيب جدا يحتوي على معالج قوي وبطارية ذات مدى طويل',
    imageUrl: 'assets/images/Phone1.jpg',
    categoryId: '1',
    categoryName: 'إلكترونيات',
    isPopular: true,
  ),



Product(
    id: 'p2',
    name: 'لابتوب Lenovo',
    price:400,
    description: 'لابتوب متميز في صناعة الجرافيكس',
    imageUrl: 'assets/images/Phone2.jpg',
    categoryId: '1',
    categoryName: 'إلكترونيات',
  ),

Product(
    id: 'p3',
    name: 'لابتوب HP',
    price:550 ,
    description: 'لابتوب سريع جدا وذا قدرة رهيبة على تصميم الأنظمة',
    imageUrl: 'assets/images/Phone3.jpg',
    categoryId: '1',
    categoryName: 'إلكترونيات',
  ),



Product(
    id: 'p4',
    name: 'هاتف samasung',
    price:650 ,
    description: 'هاتف جميل جدا وذا شاشة مقوسة وبطاريه بسعه 5000',
    imageUrl: 'assets/images/Phone4.jpg',
    categoryId: '1',
    categoryName: 'إلكترونيات',
  ),


Product(
    id: 'p5',
    name: 'هاتف samsung',
    price: 430 ,
    description: 'هاتف إصدار حديث ونظام متقدم ',
    imageUrl: 'assets/images/Phone5.jpg',
    categoryId: '1',
    categoryName: 'إلكترونيات',
    isPopular: true,
  ),







Product(
    id: 'p6',
    name: 'فستان ملكي',
    price: 340 ,
    description: 'فستان جميل جدا مناسب للمناسبات الرسمية مثل الزفاف وحفلات عيد الميلاد',
    imageUrl: 'assets/images/clothes1.jpg',
    categoryId: '2',
    categoryName: 'ملابس',
  ),
 Product(
    id: 'p7',
    name: 'بلوفر شبابي ',
    price:340 ,
    description: 'بلوفر شبابي جميل جدا وذو خامة رائعة',
    imageUrl: 'assets/images/clothes2.png',
    categoryId: '2',
    categoryName: 'ملابس',
  ),
Product(
    id: 'p8',
    name: 'بدلة رسمية ',
    price:620 ,
    description: 'بدلة جذابة مناسبة للحفلات الرسمية',
    imageUrl: 'assets/images/clothes3.jpg',
    categoryId: '2',
    categoryName: 'ملابس',
  ),
Product(
    id: 'p9',
    name: 'بدلة عرس',
    price:120 ,
    description: 'طقم جذاب جدا في حفلات الرقص',
    imageUrl: 'assets/images/clothes4.jpg',
    categoryId: '2',
    categoryName: 'ملابس',
  ),
Product(
    id: 'p10',
    name: 'فستان سهرات',
    price:80 ,
    description: 'مناسب للسهرات الرومانسية ',
    imageUrl: 'assets/images/clothes5.jpg',
    categoryId: '2',
    categoryName: 'ملابس',
  ),




Product(
    id: 'p11',
    name: 'كتاب أطفال',
    price:21 ,
    description: 'كتاب حكايات مناسب للأطفال يحكي عن كيفية تصرف الأطفال مع البيئة المحيطة',
    imageUrl: 'assets/images/Book1.jpg',
    categoryId: '3',
    categoryName: 'كتب',
  ),

Product(
    id: 'p12',
    name: 'كتاب فيزياء',
    price:12 ,
    description: 'كتاب يحكي عن الجاذبية والشمس والقمر',
    imageUrl: 'assets/images/Book2.jpg',
    categoryId: '3',
    categoryName: 'كتب',
  ),



Product(
    id: 'p13',
    name: 'كتاب وثائقي',
    price:24 ,
    description: 'يحكي عن الحروب العالمية الأولى و الثانية',
    imageUrl: 'assets/images/Book3.webp',
    categoryId: '3',
    categoryName: 'كتب',
  ),



Product(
    id: 'p14',
    name: 'كتاب روايات',
    price:33 ,
    description: 'يحكي عن بعض روايات الحب والعلاقات الرومنسية',
    imageUrl: 'assets/images/Book4.jpg',
    categoryId: '3',
    categoryName: 'كتب',
  ),



Product(
    id: 'p15',
    name: 'كتاب أغاني',
    price:22 ,
    description: 'يحكي عن بعض القصص التي أستلهمت منها بعض الأغاني',
    imageUrl: 'assets/images/Book5.jpg',
    categoryId: '3',
    categoryName: 'كتب',
  ),




Product(
    id: 'p16',
    name: 'اثاث مكتبي',
    price:320 ,
    description: ' كرسي وطاولة وكنب  رائع بالللون الأسود والبني',
    imageUrl: 'assets/images/house1.png',
    categoryId: '4',
    categoryName: 'أثاث',
  ),


Product(
    id: 'p17',
    name: 'كنب منزلي',
    price: 666,
    description: 'كنب رائع جدا وذو منظهر مباهر مناسب لوضعه في الصالة',
    imageUrl: 'assets/images/house2.png',
    categoryId: '4',
    categoryName: 'أثاث',
  ),

Product(
    id: 'p18',
    name: 'كنب منزلي وستائر',
    price:449 ,
    description: 'اثاث مناسب للمجالس التي في الطوابق العالية',
    imageUrl: 'assets/images/house3.jpg',
    categoryId: '4',
    categoryName: 'أثاث',
  ),

Product(
    id: 'p19',
    name: 'طاولة طعام',
    price:222 ,
    description: 'طاولة ذات لون بني وكراسي باللون الأبيض',
    imageUrl: 'assets/images/house4.jpg',
    categoryId: '4',
    categoryName: 'أثاث',
  ),

Product(
    id: 'p20',
    name: 'مجلس عربي',
    price:999 ,
    description: 'من المجالس المميزة والرائعه للمناسبات العامة',
    imageUrl: 'assets/images/house5.jpg',
    categoryId: '4',
    categoryName: 'أثاث',
  ),







Product(
    id: 'p21',
    name: 'كرت السلة',
    price:500 ,
    description: 'كرت نهائي كأس العالم بين ألمانيا واليمن',
    imageUrl: 'assets/images/Ball1.png',
    categoryId: '5',
    categoryName: 'رياضة',
  ),

Product(
    id: 'p22',
    name: 'أدوات كرة قدم ',
    price:200 ,
    description: 'أدوات متكاملة للاعبين وطاقم التحكيم',
    imageUrl: 'assets/images/Ball2.png',
    categoryId: '5',
    categoryName: 'رياضة',
  ),

Product(
    id: 'p23',
    name: 'كرة أديداس',
    price:433 ,
    description: 'كرة ذات قدرة مقاومة عالية',
    imageUrl: 'assets/images/Ball3.png',
    categoryId: '5',
    categoryName: 'رياضة',
  ),


Product(
    id: 'p24',
    name: 'ملعب الكامب نو',
    price:4555 ,
    description: 'ملعب عالمي وتم عرضة لك مستخدم تطبيقي',
    imageUrl: 'assets/images/Ball4.jpg',
    categoryId: '5',
    categoryName: 'رياضة',
  ),
Product(
    id: 'p25',
    name: 'ملعب الإمارات',
    price:999999 ,
    description: 'ملعب موجود في بريطانيا رهيب جدا وذا حضور قوي',
    imageUrl: 'assets/images/Ball5.jpg',
    categoryId: '5',
    categoryName: 'رياضة',
  ),


];