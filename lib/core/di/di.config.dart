// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'provide_firebase.dart' as _i743;
import 'provide_sharedPreferences.dart' as _i1041;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final provideFirebase = _$ProvideFirebase();
    final provideSharedPreferences = _$ProvideSharedPreferences();
    gh.factory<_i974.CollectionReference<InvalidType>>(
      () => provideFirebase.eventFirebase(),
    );
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => provideSharedPreferences.provideShared(),
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => provideFirebase.firebaseAuth());
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => provideFirebase.firebaseFirestore(),
    );
    return this;
  }
}

class _$ProvideFirebase extends _i743.ProvideFirebase {}

class _$ProvideSharedPreferences extends _i1041.ProvideSharedPreferences {}
