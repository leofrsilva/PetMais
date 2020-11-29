import 'package:brasil_fields/modelos/estados.dart';
import 'package:flutter/material.dart';

class EstadosRepository {
  static List<String> get estados => Estados.listaEstadosAbrv;

  static List<DropdownMenuItem<String>> getEstadosAbrv() {
    List<DropdownMenuItem<String>> result = [];
    for (String uf in Estados.listaEstadosAbrv) {
      DropdownMenuItem<String> item = DropdownMenuItem<String>(
        child: Text(uf),
        value: uf,
      );
      result.add(item);
    }
    return result;
  }
}