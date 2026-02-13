import 'package:flutter/material.dart';
import 'package:material/widgets/boton_color.dart';
import 'package:material/widgets/boton_modo.dart';
import 'package:material/models/tarea.dart';
import 'package:material/core/colores.dart';
import 'package:material/screens/theme_provider.dart';
import 'package:material/routes/rutas.dart';
import 'package:material/widgets/logo.dart';
import 'package:material/widgets/sin_tareas.dart';
import 'package:material/widgets/tarjeta_tarea.dart';
import 'package:provider/provider.dart';

/// Pantalla principal de la aplicación que muestra el listado de tareas.
///
/// Permite filtrar, agregar, editar, eliminar y reordenar las tareas.
class PaginaPpal extends StatefulWidget {
  const PaginaPpal({super.key});

  @override
  State<PaginaPpal> createState() => _PaginaPpalState();
}

class _PaginaPpalState extends State<PaginaPpal> {
  List<Tarea> _tareas = [];
  CategoriaTarea? _filtroCategoria;
  bool? _filtroCompletada;

  /// Retorna la lista de tareas filtrada según la categoría y el estado seleccionados.
  ///
  /// Si los filtros son `null`, se incluyen todas las tareas.
  List<Tarea> get _tareasFiltradas {
    return _tareas.where((tarea) {
      final coincideCategoria =
          _filtroCategoria == null || tarea.categoria == _filtroCategoria;
      final coincideCompletada =
          _filtroCompletada == null || tarea.completada == _filtroCompletada;
      return coincideCategoria && coincideCompletada;
    }).toList();
  }

  /// Agrega una nueva tarea a la lista local.
  void _agregarTarea(Tarea tarea) {
    setState(() {
      _tareas.add(tarea);
    });
  }

  /// Elimina una tarea de la lista y muestra un SnackBar para deshacer la acción.
  void _eliminarTarea(Tarea tarea) {
    final index = _tareas.indexOf(tarea);
    if (index == -1) return;

    setState(() {
      _tareas.removeAt(index);
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Tarea eliminada'),
        action: SnackBarAction(
          label: 'DESHACER',
          onPressed: () {
            setState(() {
              _tareas.insert(index, tarea);
            });
          },
        ),
      ),
    );
  }

  /// Cambia el estado de completado de una tarea.
  void _cambiarEstadoTarea(Tarea tarea) {
    final index = _tareas.indexOf(tarea);
    if (index == -1) return;
    setState(() {
      _tareas[index].completada = !_tareas[index].completada;
    });
  }

  /// Navega a la pantalla de edición y actualiza la tarea si se guardan cambios.
  void _editarTarea(Tarea tarea) async {
    final tareaActualizada = await Navigator.pushNamed(
      context,
      Rutas.pagAgregarTarea,
      arguments: tarea,
    );

    if (tareaActualizada != null && tareaActualizada is Tarea) {
      final index = _tareas.indexOf(tarea);
      if (index != -1) {
        setState(() {
          _tareas[index] = tareaActualizada;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Colores colorElegido = Colores.values.firstWhere(
      (c) => c.color.value == themeProvider.primaryColor.value,
      orElse: () => Colores.azul,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        actions: [
          BotonModo(
            cambiarModo: () => Provider.of<ThemeProvider>(
              context,
              listen: false,
            ).toggleTheme(),
          ),
          BotonColor(
            colorElegido: colorElegido,
            cambiarColor: (index) {
              final color = Colores.values[index];
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).setPrimaryColor(color.color);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFiltros(),
          Expanded(
            child: _tareasFiltradas.isEmpty
                ? const SinTareas()
                : ReorderableListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _tareasFiltradas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareasFiltradas[index];
                      return Dismissible(
                        key: ValueKey(tarea),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          _eliminarTarea(tarea);
                        },
                        child: TarjetaTarea(
                          key: ValueKey(
                            tarea,
                          ), // Clave para ReorderableListView
                          tarea: tarea,
                          onEliminar: () => _eliminarTarea(tarea),
                          onCambiarEstado: () => _cambiarEstadoTarea(tarea),
                          onEditar: () => _editarTarea(tarea),
                        ),
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      final currentFilteredList = _tareasFiltradas;
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        final Tarea item = currentFilteredList[oldIndex];
                        _tareas.remove(item);

                        if (newIndex < currentFilteredList.length - 1) {
                          final Tarea target = currentFilteredList[newIndex];
                          final targetIndex = _tareas.indexOf(target);
                          if (targetIndex != -1) {
                            _tareas.insert(targetIndex, item);
                          } else {
                            _tareas.add(item); // Fallback
                          }
                        } else {
                          _tareas.add(item);
                        }
                      });
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final nuevaTarea = await Navigator.pushNamed(
            context,
            Rutas.pagAgregarTarea,
          );
          if (nuevaTarea != null) {
            _agregarTarea(nuevaTarea as Tarea);
          }
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add_circle),
      ),
    );
  }

  /// Construye la fila de filtros para Categoría y Estado.
  Widget _buildFiltros() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DropdownButton<CategoriaTarea?>(
            value: _filtroCategoria,
            hint: const Text('Categoría'),
            onChanged: (value) {
              setState(() {
                _filtroCategoria = value;
              });
            },
            items: [
              const DropdownMenuItem(value: null, child: Text('Todas')),
              ...CategoriaTarea.values.map((categoria) {
                return DropdownMenuItem(
                  value: categoria,
                  child: Text(categoria.name),
                );
              }),
            ],
          ),
          DropdownButton<bool?>(
            value: _filtroCompletada,
            hint: const Text('Estado'),
            onChanged: (value) {
              setState(() {
                _filtroCompletada = value;
              });
            },
            items: const [
              DropdownMenuItem(value: null, child: Text('Todos')),
              DropdownMenuItem(value: true, child: Text('Completadas')),
              DropdownMenuItem(value: false, child: Text('Pendientes')),
            ],
          ),
        ],
      ),
    );
  }
}
