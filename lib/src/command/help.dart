// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub.command.help;

import 'dart:async' hide TimeoutException;

import '../command.dart';
import '../exit_codes.dart' as exit_codes;
import '../io.dart';
import '../log.dart' as log;

/// Handles the `help` pub command.
class HelpCommand extends PubCommand {
  String get description => "Display help information for Pub.";
  String get usage => "pub help [command]";
  bool get requiresEntrypoint => false;
  bool get takesArguments => true;

  Future onRun() {
    if (commandOptions.rest.isEmpty) {
      printUsage();
    } else {
      var name = commandOptions.rest[0];
      var command = PubCommand.commands[name];
      if (command == null) {
        log.error('Could not find a command named "$name".');
        log.error('Run "pub help" to see available commands.');
        return flushThenExit(exit_codes.USAGE);
      }

      command.printUsage();
    }
  }
}
