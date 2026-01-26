import 'package:flutter/material.dart';
import 'package:material/models/tarea.dart';

class PaginaAgregarTarea extends StatefulWidget {
  const PaginaAgregarTarea({super.key});

  @override
  State<PaginaAgregarTarea> createState() => _PaginaAgregarTareaState();
}

class _PaginaAgregarTareaState extends State<PaginaAgregarTarea> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  CategoriaTarea _categoriaSeleccionada = CategoriaTarea.Personal;

  bool _isEditing = false;
  Tarea? _tareaOriginal;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtenemos la tarea pasada como argumento para editarla
    if (!_isInitialized) {
      final tarea = ModalRoute.of(context)?.settings.arguments as Tarea?;
      if (tarea != null) {
        _isEditing = true;
        _tareaOriginal = tarea;
        _tituloController.text = tarea.titulo;
        _descripcionController.text = tarea.descripcion;
        _categoriaSeleccionada = tarea.categoria;
      }
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardarTarea() {
    if (_formKey.currentState!.validate()) {
      final tareaResultante = Tarea(
        titulo: _tituloController.text,
        descripcion: _descripcionController.text,
        categoria: _categoriaSeleccionada,
        // Mantenemos el estado 'completada' si estamos editando
        completada: _isEditing ? _tareaOriginal!.completada : false,
      );
      Navigator.of(context).pop(tareaResultante);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Tarea' : 'Agregar Tarea'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Ingrese un título'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Ingrese una descripción'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<CategoriaTarea>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                onChanged: (CategoriaTarea? newValue) => setState(
                  () => _categoriaSeleccionada =
                      newValue ?? CategoriaTarea.Personal,
                ),
                items: CategoriaTarea.values
                    .map(
                      (cat) =>
                          DropdownMenuItem(value: cat, child: Text(cat.name)),
                    )
                    .toList(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _guardarTarea,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(_isEditing ? 'Guardar Cambios' : 'Agregar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
