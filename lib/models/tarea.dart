enum CategoriaTarea { Personal, Trabajo, Otro }

extension CategoriaTareaExtension on CategoriaTarea {
  String get name {
    switch (this) {
      case CategoriaTarea.Personal:
        return 'Personal';
      case CategoriaTarea.Trabajo:
        return 'Trabajo';
      case CategoriaTarea.Otro:
        return 'Otro';
    }
  }
}

class Tarea {
  String titulo;
  String descripcion;
  bool completada;
  CategoriaTarea categoria;

  Tarea({
    required this.titulo,
    required this.descripcion,
    this.completada = false,
    this.categoria = CategoriaTarea.Personal,
  });
}
