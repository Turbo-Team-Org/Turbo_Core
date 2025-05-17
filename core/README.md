# Turbo Core

Turbo Core es el paquete base del monorepo Turbo, diseñado para centralizar la lógica de negocio, entidades, servicios y utilidades compartidas entre los diferentes módulos de la plataforma Turbo.

## 🚀 ¿Qué es Turbo Core?

Turbo Core es el núcleo de la arquitectura de la plataforma Turbo. Aquí se definen los modelos, repositorios, servicios y utilidades que pueden ser reutilizados por otros paquetes y aplicaciones dentro del monorepo. El objetivo es garantizar consistencia, escalabilidad y mantenibilidad en todos los proyectos Turbo.

## 🏗️ Arquitectura

Este paquete sigue los principios de **Clean Architecture** y **SOLID**, organizando el código en capas:

- **Domain:** Entidades, repositorios abstractos y casos de uso.
- **Data:** Implementaciones concretas, modelos y servicios de acceso a datos (ej. Firebase).
- **Presentation:** (Opcional) Widgets o utilidades de UI compartidas.

Además, se utiliza el enfoque **feature-first** para facilitar la escalabilidad y modularidad.

## 📦 Dependencias principales

- [freezed](https://pub.dev/packages/freezed) para modelos inmutables y generación de código.
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) para integración con Firebase.
- [firebase_auth](https://pub.dev/packages/firebase_auth) para autenticación.
- [get_it](https://pub.dev/packages/get_it) para inyección de dependencias.
- [dartz](https://pub.dev/packages/dartz) para programación funcional.
- [json_serializable](https://pub.dev/packages/json_serializable) para serialización JSON.

## 📁 Estructura del paquete

```
lib/
  src/
    authentication_repository/
    event_repository/
    place_repository/
    review_repository/
    monorepo_utils/
  core.dart
```

## 🛠️ Cómo usar

1. Añade Turbo Core como dependencia en tu `pubspec.yaml` de otro paquete o app dentro del monorepo.
2. Importa los modelos, repositorios o servicios que necesites:
   ```dart
   import 'package:core/core.dart';
   import 'package:core/src/event_repository/models/event.dart';
   ```
3. Sigue la arquitectura y patrones definidos para mantener la coherencia.

## 🤝 Contribuir

- Sigue las buenas prácticas de Clean Architecture y SOLID.
- Documenta tus clases y métodos públicos.
- Añade pruebas unitarias para nuevas funcionalidades.
- Mantén las dependencias y el código actualizado.

## 📄 Licencia

Este proyecto está bajo la licencia MIT.

---

¿Dudas o sugerencias? ¡Abre un issue o contacta al equipo de Turbo!
