import 'package:sub_locacoes/clone/Model/Property.dart';
import 'package:sub_locacoes/clone/Model/Address.dart';

class NewRoom extends Property {
  bool sanitairePrive;
  bool chambrePartage;
  bool equipe;

  NewRoom(
    String titre,
    List<String> images,
    int prix,
    Address address,
    String descreption,
    double raiting,
    Commodite commodite,
    this.sanitairePrive,
    this.chambrePartage,
    this.equipe,
  ) : super(titre, images, prix, address, descreption, raiting, commodite);
}
