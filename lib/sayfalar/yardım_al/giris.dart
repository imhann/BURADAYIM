import 'package:buradayim/db/kisi_model.dart';
import 'package:buradayim/db/tek_siparis.dart';
import 'package:buradayim/db/urunler.dart';
import 'package:buradayim/giris_sayfasi.dart';
import 'package:buradayim/sabitler/renk.dart';
import 'package:buradayim/sabitler/resimyolu.dart';
import 'package:buradayim/sabitler/sbt_kart.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/ihtitaclarim.dart';
import 'package:buradayim/sayfalar/yard%C4%B1m_al/listeleme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../controller/konum.dart';
import '../../db/sp.dart';
import 'listem.dart';

// ignore: must_be_immutable
class YrdAlGirisSayfasi extends StatefulWidget {
  KisiModel kisiModel;
  List<String>? tumListe;
  DateTime? siparisYapildimi;
  List<Urunler>? listeUrun;

  YrdAlGirisSayfasi({
    super.key,
    required this.kisiModel,
    this.tumListe,
    required this.siparisYapildimi,
    this.listeUrun,
  });

  @override
  State<YrdAlGirisSayfasi> createState() => _YrdAlGirisSayfasiState();
}

class _YrdAlGirisSayfasiState extends State<YrdAlGirisSayfasi> {
  //Veri tabanını çağır
  var boxGecici = Hive.box<Urunler>('urunDBX');
  //var boxGeciciUrun = Hive.box<Urunler>('urunDBX');
  var boxKisiler = Hive.box<KisiModel>('kisiDB');
  late KisiModel varOlanKisi;

  var boxListDB = Hive.box('listDB');

  var boxSiparisler = Hive.box<SiparisModel>('siparisDB');
  var boxUrunler = Hive.box<Urunler>('urunDB');
  List<Urunler> allUrunler = [];
  List<Urunler> gidenUrun = [];
  List<Urunler>? listeUrun = [];

  //Doldurulacak listem
  List<Urunler> tumListem = [];
//Enlem ve boylam bilgileri
  String lat = '0';
  String lan = '0';
  //
  List listCocuk = [
    'Süt',
    'Çocuk Bezi',
    'Mama',
    'Mont',
    'Çorap',
    'Ayakkabı',
  ];
  List listBarinma = [
    'Çadır',
    'Battaniye ',
    'Yastık',
    'Isıtıcı',
    'Sünger Yatak',
    'El Feneri',
    'Nevresim',
    'PowerBank'
  ];
  List listGiyim = [
    'Çorap',
    'Ayakkabı',
    'İçlik(Kadın)',
    'İçlik(Erkek)',
    'Uyku Tulumu',
    'Mont(Kadın)',
    'Mont(Erkek)',
    'Atkı',
    'Bere',
    'Eldiven'
  ];
  List listGida = [
    'Su',
    'Konserve Gıda',
    'Bisküvi',
    'Kek',
    'Meyvesuyu',
    'Süt',
    'Makarna',
    'Pirinç',
    'Bulgur',
    'Ekmek',
    'Sıvı Yağ',
    'Tuz',
    'Şeker',
    'Çay'
  ];
  List listHijyen = [
    'Sabun',
    'Şampuan',
    'Diş Macunu',
    'Diş Fırçası',
    'Tuvalet Kağıdı',
    'Hijyenik Ped',
    'Islak Mendil',
    'Bulaşık Süngeri',
    'Deterjan',
    'Dezenfektan'
  ];
  List listSaglik = [
    'Ağrı Kesici',
    'Antibiyotik',
    'Yara Bandı',
    'Yara Bakım Malzemeleri',
    'Gazlı Bez',
    'Isı Ölçer'
  ];

  DateTime suankiTarih = DateTime.now();

  tarihDegistirme(DateTime date) {
    var tarih = DateFormat.yMMMd('tr').format(date).toString();
    return tarih;
  }

  // Initial Selected Value
  String dropdownvalue = 'Kahramanmaraş';

  // List of items in our dropdown menu
  var items = [
    'Kahramanmaraş',
    'Hatay',
    'Gaziantep',
    'Osmaniye',
    'Malatya',
    'Adana',
    'Diyarbakır',
    'Şanlıurfa',
    'Adıyaman',
    'Kilis',
  ];
  String secilenIl = 'Kahramanmaraş';
//Konum paketi çağırma
  LocationHelper? locationData;

//Konum bilgisini aldığımız alan
  Future<void> getirDatayi() async {
    locationData = LocationHelper();
    await locationData?.getLocation();

    if (locationData!.lan == null || locationData!.lat == null) {
      debugPrint('Konum bilgisi gelmiyor');
    } else {
      debugPrint('lan');
      setState(() {});
      lat = locationData!.lan.toString();
      lan = locationData!.lat.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    listeUrun = widget.listeUrun;
    getirDatayi();
    for (var element in boxKisiler.values) {
      if (element.id == widget.kisiModel.id) {
        varOlanKisi = element;
      }
    }
    for (var element in boxGecici.values) {
      tumListem.add(element);
    }
    urunKontrol();

    debugPrint(widget.siparisYapildimi.toString());
  }

  List<TekSiparis> allTekList = [];

  // Bir günde sadece bir işlem gerçekleştirme
  DateTime? lastActionTime;
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          UstBilgiKart(),
          //Kategorilerin olduğu alan
          SizedBox(
            width: Get.size.width,
            height: Get.size.width / 3,
            child: Kategoriler(),
          ),
          illerinSecildiAlan(),
          const Divider(
            color: SbtRenkler.mavi,
            height: 15,
            thickness: 1,
            endIndent: 80,
            indent: 80,
          ),
          listeUrun!.isNotEmpty
              ? Consumer<ListProvider>(
                  builder: (context, provider, child) {
                    listeUrun = provider.listem();
                    return Expanded(
                      // Çekilen listeyi gösterme
                      child: ListView.builder(
                        itemCount: provider.listem().length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Text((index + 1).toString()),
                              title: Text(provider.listem()[index].urunAdi),
                              subtitle: Text(
                                'Adet: ${provider.listem()[index].girilenUrunMiktari}',
                              ),
                              trailing: IconButton(
                                  onPressed: () async {
                                    setState(() {});
                                    //Silme butonuna basıca listeden çıkarıyoruz
                                    provider
                                        .listem()[index]
                                        .girilenUrunMiktari = provider
                                            .listem()[index]
                                            .girilenUrunMiktari -
                                        1;
                                    if (provider
                                            .listem()[index]
                                            .girilenUrunMiktari ==
                                        0) {
                                      provider
                                          .removeItem(provider.listem()[index]);
                                    }
                                    tumListem.removeAt(index);

                                    for (var element in tumListem) {
                                      await boxGecici.add(element);
                                    }
                                    await boxGecici.clear();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: SbtRenkler.mavi,
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Container()
        ],
      ),
      floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: SbtRenkler.mavi,
          onPressed: performAction,
          child: const Icon(Icons.check)),
    );
  }

  void performAction() {
    // Eğer lastActionTime null ise veya geçmişteki bir gün ise işlemi gerçekleştir
    if (varOlanKisi.gunlukIstem == null ||
        now.day != varOlanKisi.gunlukIstem!.day) {
      showAlertDialog(context);
    } else {
      Get.snackbar(
        'Uyarı',
        'Günde sadece bir ihtiyaç talebinde bulunabilirsiniz.',
        backgroundColor: Colors.orange,
      );
    }
  }

  AppBar appbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Depremzede',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        alisverisSepeti(),
        // Giriş ekranına gitme
        IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const GirisSayfasi(),
                  ),
                  (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: SbtRenkler.mavi,
            )),
      ],
    );
  }

  Padding alisverisSepeti() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => IhtiyaclarimSayfasi(
                    kisiModel: widget.kisiModel,
                  ),
                ));
              },
              child: const Text('İHTİYAÇLARIM'))),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Uyarı"),
      content: const Text(
          "İHTİYAÇLARINIZ ALINMIŞTIR. SÜRECİ “İHTİYAÇLARIM” MENÜSÜNDEN TAKİP EDEBİLİRSİNİZ.GEÇMİŞ OLSUN…."),
      actions: [
        ElevatedButton(
          child: const Text('İhtiyaç oluştur'),
          onPressed: () async {
            var siparisID = const Uuid().v1();

            if (listeUrun!.isNotEmpty) {
              final now = DateTime.now();

              var kisiGuncelle = KisiModel(
                id: widget.kisiModel.id,
                adSoyad: widget.kisiModel.adSoyad,
                tel: widget.kisiModel.tel,
                yardimAlan: widget.kisiModel.yardimAlan,
                sifre: widget.kisiModel.sifre,
                gunlukIstem: now,
              );
              await boxKisiler.put(widget.kisiModel.id, kisiGuncelle);

              for (var element in listeUrun!) {
                var id = const Uuid().v1();
                var ekleTek = TekSiparis(
                  girilenUrunMiktari: element.girilenUrunMiktari,
                  id: id,
                  siparis: element.urunAdi,
                );
                allTekList.add(ekleTek);
              }

              var eklenecekSiparis = SiparisModel(
                  siparisID: siparisID,
                  tc: widget.kisiModel.id,
                  dateTime: suankiTarih,
                  sehir: secilenIl,
                  enlemLat: lan,
                  boylamLan: lat,
                  mapList: allTekList,
                  yardimAl: true);
              await boxSiparisler.put(siparisID, eklenecekSiparis);
              await boxGecici.clear();
              listeUrun?.clear();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => YrdAlGirisSayfasi(
                      kisiModel: widget.kisiModel,
                      siparisYapildimi: now,
                      listeUrun: const [],
                      tumListe: const [],
                    ),
                  ),
                  (route) => false);
              //!!

              ///   Get.to(DenemelerSil());
            } else {
              Get.snackbar('Uyarı', 'Herhangi birşey seçmediniz');
            }
          },
        ),
        ElevatedButton(
          child: const Text('İptal'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Row illerinSecildiAlan() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DropdownButton(
          // Initial Value
          value: dropdownvalue,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: const TextStyle(color: SbtRenkler.mavi, fontSize: 20),
              ),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
              secilenIl = newValue;
            });
          },
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  ListView Kategoriler() {
    return ListView(
      // Listenin yatayda ilerlemesini sağlar
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  //Listeyi doldurma MİKTAR
                  listyeGoreDoldur(listCocuk);
                  //İlgili sayfaya yönlendirme
                  Get.to(ListelemeAl(
                    listUrunler: gidenUrun,
                    gelenListem: listCocuk,
                    baslik: 'Çocuk',
                    kisiModel: widget.kisiModel,
                  ));
                },
                resimYolu: ImageConstants.instance.cocuk,
                baslik: 'Çocuk')),
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  listyeGoreDoldur(listBarinma);
                  Get.to(ListelemeAl(
                    listUrunler: gidenUrun,
                    kisiModel: widget.kisiModel,
                    gelenListem: listBarinma,
                    baslik: 'Barınma',
                  ));
                },
                resimYolu: ImageConstants.instance.barinma,
                baslik: 'Barınma')),
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  listyeGoreDoldur(listGiyim);
                  Get.to(ListelemeAl(
                    listUrunler: gidenUrun,
                    kisiModel: widget.kisiModel,
                    gelenListem: listGiyim,
                    baslik: 'Giyim',
                  ));
                },
                resimYolu: ImageConstants.instance.elbise,
                baslik: 'Giyim')),
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  listyeGoreDoldur(listGida);

                  Get.to(ListelemeAl(
                    listUrunler: gidenUrun,
                    kisiModel: widget.kisiModel,
                    gelenListem: listGida,
                    baslik: 'Gıda',
                  ));
                },
                resimYolu: ImageConstants.instance.gida,
                baslik: 'Gıda')),
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  listyeGoreDoldur(listHijyen);

                  Get.to(ListelemeAl(
                    kisiModel: widget.kisiModel,
                    listUrunler: gidenUrun,
                    gelenListem: listHijyen,
                    baslik: 'Hijyen',
                  ));
                },
                resimYolu: ImageConstants.instance.hijyen,
                baslik: 'Hiijyen')),
        SizedBox(
            width: Get.size.width / 3,
            height: Get.size.width / 3,
            child: SbtKart(
                onTop: () {
                  listyeGoreDoldur(listSaglik);

                  Get.to(ListelemeAl(
                    listUrunler: gidenUrun,
                    kisiModel: widget.kisiModel,
                    gelenListem: listSaglik,
                    baslik: 'Sağlık',
                  ));
                },
                resimYolu: ImageConstants.instance.saglik,
                baslik: 'Sağlık')),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Card UstBilgiKart() {
    return Card(
      child: ListTile(
        title: Text(widget.kisiModel.adSoyad),
        subtitle: Text(widget.kisiModel.tel),
        leading: const Icon(
          Icons.person,
          color: SbtRenkler.mavi,
        ),
      ),
    );
  }

  urunleriEkleListele() async {
    for (var element in listCocuk) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
    for (var element in listBarinma) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
    for (var element in listGiyim) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
    for (var element in listHijyen) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
    for (var element in listSaglik) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
    for (var element in listGida) {
      var eklenecek = Urunler(
        yardimAlanmi: true,
        urunAdi: element,
        urunAdet: 10,
        girilenUrunMiktari: 0,
      );
      await boxUrunler.put(element, eklenecek);
    }
  }

  urunlerlGetir() {
    for (var element in boxUrunler.values) {
      allUrunler.add(element);
    }
  }

  urunKontrol() async {
    if (boxUrunler.isEmpty) {
      await urunleriEkleListele();
      await urunlerlGetir();
    } else {
      await urunlerlGetir();
    }
  }

  listyeGoreDoldur(List secilenList) {
    for (var element in allUrunler) {
      for (var kap in secilenList) {
        if (element.urunAdi == kap) {
          gidenUrun.add(element);
        }
      }
    }
  }

  Future<void> urunMiktariniAyarlama() async {
    gidenUrun.clear();
    debugPrint('Öncekiiii');
    for (var element in tumListem) {
      for (var i = 0; i < allUrunler.length; i++) {
        if (element.urunAdi ==
            '${allUrunler[i].urunAdi}=${allUrunler[i].urunAdet}') {
          var guncelle = Urunler(
              yardimAlanmi: true,
              urunAdi: allUrunler[i].urunAdi,
              urunAdet: allUrunler[i].urunAdet - 1,
              girilenUrunMiktari: allUrunler[i].girilenUrunMiktari);
          allUrunler[i] = guncelle;

          boxUrunler.put(allUrunler[i].urunAdi, guncelle);
        }
      }
    }

    //var ff in allUrunler
  }
}
