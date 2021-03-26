import 'package:flutter/material.dart';

class SliderModel {
  String imagePath;
  String title;
  String text;

  SliderModel(this.imagePath, this.title, this.text);

  static List<SliderModel> getSlides() {
    List<SliderModel> slides = new List<SliderModel>();
    SliderModel s1 = new SliderModel(
        "assets/images/Illustrations/il1.jpg",
        "Reserve por hora",
        "Caso tenha alguma emergÊncia você pode escolher os horários disponíveis. Deslise para a direita para mais opções ");
    SliderModel s2 = new SliderModel("assets/images/Illustrations/il2.jpg",
        "Reserve por sala", "Várias salas configuradas para sua especialidade");
    SliderModel s3 = new SliderModel(
        "assets/images/Illustrations/il3.jpg",
        "Sair do modo agendamento",
        "Deslize para direita para voltar para as opções ");
    slides.add(s1);
    slides.add(s2);
    slides.add(s3);
    return slides;
  }
}
