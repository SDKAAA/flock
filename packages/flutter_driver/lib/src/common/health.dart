// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:flutter_driver/flutter_driver.dart';
library;

import 'enum_util.dart';
import 'message.dart';

/// A Flutter Driver command that requests an application health check.
class GetHealth extends Command {
  /// Create a health check command.
  const GetHealth({super.timeout});

  /// Deserializes this command from the value generated by [serialize].
  GetHealth.deserialize(super.json) : super.deserialize();

  @override
  String get kind => 'get_health';

  @override
  bool get requiresRootWidgetAttached => false;
}

/// A description of application state.
enum HealthStatus {
  /// Application is known to be in a good shape and should be able to respond.
  ok,

  /// Application is not known to be in a good shape and may be unresponsive.
  bad,
}

final EnumIndex<HealthStatus> _healthStatusIndex = EnumIndex<HealthStatus>(HealthStatus.values);

/// A description of the application state, as provided in response to a
/// [FlutterDriver.checkHealth] test.
class Health extends Result {
  /// Creates a [Health] object with the given [status].
  const Health(this.status);

  /// The status represented by this object.
  ///
  /// If the application responded, this will be [HealthStatus.ok].
  final HealthStatus status;

  /// Deserializes the result from JSON.
  static Health fromJson(Map<String, dynamic> json) {
    return Health(_healthStatusIndex.lookupBySimpleName(json['status'] as String));
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'status': _healthStatusIndex.toSimpleName(status),
  };
}
