import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenProvider = Provider<String?>((ref) => GetIt.I<SharedPreferences>().getString("token"));
