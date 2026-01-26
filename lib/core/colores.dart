import 'package:flutter/material.dart';

enum Colores {
  purpuraOscuro('Púrpura Oscuro', Colors.deepPurple),
  purpura('Púrpura', Colors.purple),
  anyil('Añil', Colors.indigo),
  azul('Azul', Colors.blue),
  celeste('Celeste', Colors.lightBlue),
  verdeAzulado('Verde Azulado', Colors.teal),
  verde('Verde', Colors.green),
  verdeClaro('Verde Claro', Colors.lightGreen),
  lima('Lima', Colors.lime),
  amarillo('Amarillo', Colors.yellow),
  ambar('Ámbar', Colors.amber),
  naranja('Naranja', Colors.orange),
  naranjaOscuro('Naranja Oscuro', Colors.deepOrange),
  rojo('Rojo', Colors.red),
  rojoOscuro('Rojo Oscuro', Colors.redAccent),
  rosa('Rosa', Colors.pink),
  rosaOscuro('Rosa Oscuro', Colors.pinkAccent),
  marron('Marrón', Colors.brown),
  gris('Gris', Colors.grey),
  grisOscuro('Gris Oscuro', Colors.black),
  azulGrisaceo('Azul Grisáceo', Colors.blueGrey);

  const Colores(this.etiqueta, this.color);

  final String etiqueta;
  final Color color;
}
