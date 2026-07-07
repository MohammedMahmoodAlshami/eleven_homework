
/*
colorScheme
textTheme
1- fold
int get itemCount => _items.values.fold(0 , (sum, item) => sum + item.quantity);
fold(initialValue, (previous, element) {
  return result;   });

  THis part always duplicate
  (sum, item) => sum + item.quantity)

  خذ جميع القيم الموجودة داخل _items،
وابدأ بمجموع قيمته 0،
ثم مر على كل عنصر،
وأضف quantity الخاصة به إلى المجموع الحالي،
ثم أرجع الناتج النهائي بعد انتهاء المرور على جميع العناصر.


2-  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     childAspectRatio: 0.7,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10,
                  ),



 clipBehavior: Clip.antiAlias,
 كيف يتعامل Flutter مع أي جزء يخرج خارج حدود العنصر.
أي أنه يقوم بقص المحتوى مع تحسين شكل الحواف بصريًا.




InkWell
جعل العنصر قابلًا للضغط مع ظهور تأثير بصري جميل عند اللمس.
عندما يضغط المستخدم على العنصر:

ينفذ حدث مثل onTap
ويظهر تأثير مائي Ripple Effect

وهو تأثير الانتشار الدائري الذي تراه في تطبيقات Android.


AspectRatio
نسبة العرض إلى الطول للمحافظة على الشكل المثالي للصورة في كل الأجهزة

width: double.infinity,
جعل عرض الصورة يأخذ كل المساحة الأفقية المتاحة.

fit: BoxFit.cover,
جعل الصورة تملأ المساحة بالكامل مع قص الأجزاء الزائدة إذا لزم الأمر.



ClipRRect
Clip Rounded Rectangle
يتم قص الشكل الخارجي للصندوق
الزوايا السفلية تصبح دائرية
أي جزء خارج الشكل يتم حذفه نهائيًا


Expanded
جعل العنصر يأخذ المساحة الفارغة المتبقية داخل Row أو Column أو Flex.

  automaticallyImplyLeading: false,
❌ امنع Flutter من إضافة أي زر تلقائي في بداية الـ AppBar
النتيجة:
لا يظهر زر الرجوع تلقائياً





    Spacer(),
فراغ ذكي يوزع العناصر ويدفعها لأطراف الشاشة

    physics: const BouncingScrollPhysics(),
➡️ يجعل التمرير ناعم + فيه ارتداد عند الأطراف 👍



Color.lerp
كلمة lerp اختصار لـ:

Linear Interpolation

أي:

مزج تدريجي بين لونين.









*/ 
