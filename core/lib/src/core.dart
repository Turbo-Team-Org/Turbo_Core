/// Este archivo puede usarse para documentación o utilidades internas del core.
/// Si no es necesario, puede dejarse vacío o eliminarse.

/// {@template core}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
library core;

export 'dependency_inyection/init_config.dart';
export 'monorepo_utils/environments.dart';
export 'turbo_core_repositories/turbo_core_repositories.dart';

class Core {
  /// {@macro core}
  const Core();
}
