// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [FluentQuery] interface.
library dogma.mapper.fluent_query;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_connection/query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Interface for creating a [Query] in a domain specific way.
///
/// Classes implementing [FluentQuery] should provide an interface that
/// abstracts away the creating of the raw [Query].
abstract class FluentQuery<Model> {
  /// The query built by interacting with a [FluentQuery].
  Query get query;
}
