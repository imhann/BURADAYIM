class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    _instance ??= _instance = ImageConstants._init();
    return _instance!;
  }

  ImageConstants._init();
  String get arkaPlan => toPng('arkaplan');
  String get barinma => toPng('ic_barinma');
  String get cocuk => toPng('ic_cocuk');
  String get elbise => toPng('ic_elbise');
  String get gida => toPng('ic_gida');
  String get hijyen => toPng('ic_hijyen');
  String get saglik => toPng('ic_saglik');
  String get nt1 => toPng('nt1');
  String get nt2 => toPng('nt2');
  String get nt3 => toPng('nk3');
  String get nt4 => toPng('nt4');
  String get nt5 => toPng('nt5');

  //!
  //? Üste belittiğim arkaplan içerisine png dosya adımı yazım 'rakaplan_resmi'
  //? Alt tarafdayazdığım değeri yoluma $ işareti ile belirtip sonuna .png yazdım
  String toPng(value) => 'asset/image/$value.png';
}

// ÖRENEK KULLANIM
// Image.asset(ImageConstants.instance.arkaPlan);

//!
//!
//!
//!
//! YUKARIDAKİNİNİ SVG OLANI. UZANTISI SVG OLANLAR İÇİN

class SvgConstants {
  static SvgConstants? _instance;
  static SvgConstants get instance {
    _instance ??= _instance = SvgConstants._init();
    return _instance!;
  }

  SvgConstants._init();

  String get item01 => toSvg("item-01");
  String get item02 => toSvg("item-02");
  String get item03 => toSvg("item-03");
  String get item04 => toSvg("item-04");
  String get item05 => toSvg("item-05");

  String toSvg(String value) => 'assets/svg/$value.svg';
}
