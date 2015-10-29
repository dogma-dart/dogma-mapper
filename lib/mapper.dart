// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Mapper] class.
library dogma_mapper.mapper;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_connection/connection.dart';
import 'package:dogma_convert/convert.dart';
import 'package:dogma_mapper/fluent_query.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Handles mapping data between a [Connection].
///
/// The [Mapper] class serializes and deserializes data when communicating with
/// a [Connection]. This allows the developer to interact with Plain Old Dart
/// Objects (PODOs) rather than the Map data that is returned and passed to
/// the connection.
///
/// It is used in conjunction with a [FluentQuery] which provides a domain
/// specific method of querying the connection.
class Mapper<Model> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The data connection.
  final Connection connection;
  /// Serializes the [Model] data.
  final ModelDecoder<Model> decoder;
  /// Deserializes the [Model] data.
  final ModelEncoder<Model> encoder;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Mapper] class that interfaces with the [connection].
  ///
  /// Mapping the [Model] data to and from its serialized form are handled by
  /// the [encoder] and [decoder] respectively.
  Mapper(this.connection, {this.decoder, this.encoder});

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Performs the [query] on the data [connection] returning a single value.
  ///
  /// Returns a [Future] containing the model data. The query method uses the
  /// [decoder] to transform the contents of the query into the [Model].
  Future<Model> query(FluentQuery<Model> query) async {
    var value = await connection.query(query.query);

    return decoder.convert(value);
  }

  /// Performs the [query] on the data [connection] returning all values.
  ///
  /// Returns a [Stream] containing the model data. The query method uses the
  /// [decoder] to transform the contents of the stream into the [Model].
  Stream<Model> queryAll(FluentQuery<Model> query) {
    // \TODO Remove cast when generic methods are implemented
    return connection.queryAll(query.query).map(
        (value)=> decoder.convert(value)) as Stream<Model>;
  }
}
