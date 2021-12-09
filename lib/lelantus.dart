import 'dart:async';

import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:ffi/ffi.dart' as pkgffi;

class Lelantus {
  static const MethodChannel _channel = MethodChannel('lelantus');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open('libmobileliblelantus.so')
    : DynamicLibrary.process();

class LelantusEntry extends Struct {
  @Int8()
  external int isUsed;
  @Int32()
  external int height;
  @Int32()
  external int anonymitySetId;
  @Int64()
  external int amount;
  @Uint32()
  external int index;
  external Pointer<Utf8> keydata;
}

// final Pointer<Utf8> Function(Pointer<Utf8>) _hex2Bin = nativeAddLib
//     .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>('H2B')
//     .asFunction();
//
// String hex2Bin(String hex) => _hex2Bin(hex.toNativeUtf8()).toDartString();
//
// final Pointer<Utf8> Function(Pointer<Utf8>, int) _bin2Hex = nativeAddLib
//     .lookup<NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>, Uint64)>>(
//         'B2H')
//     .asFunction();
//
// String bin2Hex(String bin) =>
//     _bin2Hex(bin.toNativeUtf8(), bin.length).toDartString();

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  Pointer<Utf8>, // seedID
) _getMintScript = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Pointer<Utf8>, // seedID
    )>>('CMS')
    .asFunction();

String getMintScript(
  int value,
  String keydata,
  int index,
  String seedID,
) =>
    _getMintScript(
      value,
      keydata.toNativeUtf8(),
      index,
      seedID.toNativeUtf8(),
    ).toDartString();

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, //keydata
  int, //index
) _getPublicCoin = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
    )>>('GPC')
    .asFunction();

String getPublicCoin(
  int value,
  String keydata,
  int index,
) =>
    _getPublicCoin(
      value,
      keydata.toNativeUtf8(),
      index,
    ).toDartString();

final int Function(
  int, // spendAmount
  int, // subtractFeeFromAmount
  Pointer<Pointer<LelantusEntry>>, // coins
  int, // coins_length
  int, // changeToMint
  Pointer<Int32>, // spendCoinIndexes
  int, // spendCoinIndexes_length
) _estimateFee = nativeAddLib
    .lookup<
        NativeFunction<
            Uint64 Function(
      Uint64, // spendAmount
      Int8, // subtractFeeFromAmount
      Pointer<Pointer<LelantusEntry>>, // coins
      Int32, // coins_length
      Uint64, // changeToMint
      Pointer<Int32>, // spendCoinIndexes
      Int32, // spendCoinIndexes_length
    )>>('EF')
    .asFunction();

int estimateFee(
  int spendAmount,
  bool subtractFeeFromAmount,
  List<Pointer<LelantusEntry>> coins,
  int changeToMint,
  List<int> spendCoinIndexes,
) {
  var memory_coins =
      pkgffi.malloc.allocate<Pointer<LelantusEntry>>(coins.length);
  for (int i = 0; i < coins.length; i++) {
    memory_coins[i] = coins[i];
  }

  var memory_spendCoinIndexes =
      pkgffi.malloc.allocate<Int32>(spendCoinIndexes.length);
  for (int i = 0; i < spendCoinIndexes.length; i++) {
    memory_spendCoinIndexes[i] = spendCoinIndexes[i];
  }
  int result = _estimateFee(
    spendAmount,
    subtractFeeFromAmount ? 1 : 0,
    memory_coins,
    coins.length,
    changeToMint,
    memory_spendCoinIndexes,
    spendCoinIndexes.length,
  );

  pkgffi.malloc.free(memory_coins);
  pkgffi.malloc.free(memory_spendCoinIndexes);
  return result;
}

final int Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
) _getMintKeyPath = nativeAddLib
    .lookup<
        NativeFunction<
            Uint32 Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, //index
    )>>('GMKP')
    .asFunction();

int getMintKeyPath(
  int value,
  String keydata,
  int index,
) =>
    _getMintKeyPath(
      value,
      keydata.toNativeUtf8(),
      index,
    );

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  Pointer<Utf8>, // seedID
  Pointer<Utf8>, // AESkeydata
) _createJMintScript = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Pointer<Utf8>, // seedID
      Pointer<Utf8>, // AESkeydata
    )>>('CJMS')
    .asFunction();

String createJMintScript(
  int value,
  String keydata,
  int index,
  String seedID,
  String AESkeydata,
) =>
    _createJMintScript(
      value,
      keydata.toNativeUtf8(),
      index,
      seedID.toNativeUtf8(),
      AESkeydata.toNativeUtf8(),
    ).toDartString();

final Pointer<Utf8> Function(
  Pointer<Utf8>,
  int,
  int,
  Pointer<Utf8>,
  int,
  Pointer<Pointer<LelantusEntry>>,
  int,
  Pointer<Uint32>,
  int,
  Pointer<Pointer<Pointer<Utf8>>>,
  Pointer<Int32>,
  int,
  Pointer<Pointer<Utf8>>,
  int,
  Pointer<Pointer<Utf8>>,
  int,
) _createJoinSplitScript = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Pointer<Utf8>, // txhash
      Uint64, // spendAmount
      Int8, // subtractFeeFromAmount
      Pointer<Utf8>, //keydata
      Uint32, // index
      Pointer<Pointer<LelantusEntry>>, //coins
      Int32, //coins length
      Pointer<Uint32>, // setIds
      Int32, // setIds length
      Pointer<Pointer<Pointer<Utf8>>>, // anonymitySets
      Pointer<Int32>, // anonymitySets_lengths
      Int32, // anonymitySets_length
      Pointer<Pointer<Utf8>>, // anonymitySetHashes
      Int32, // anonymitySetHashes_length
      Pointer<Pointer<Utf8>>, // groupBlockHashes
      Int32, // groupBlockHashes_length
    )>>('CJSS')
    .asFunction();

String createJoinSplitScript(
  String txHash,
  int spendAmount,
  bool subtractFeeFromAmount,
  String keydata,
  int index,
  List<Pointer<LelantusEntry>> coins,
  List<int> setIds,
  List<List<String>> anonymitySets,
  List<String> anonymitySetHashes,
  List<String> groupBlockHashes,
) {
  var memory_coins =
      pkgffi.malloc.allocate<Pointer<LelantusEntry>>(coins.length);
  for (int i = 0; i < coins.length; i++) {
    memory_coins[i] = coins[i];
  }

  var set_ids = pkgffi.malloc.allocate<Uint32>(setIds.length);
  for (int i = 0; i < setIds.length; i++) {
    set_ids[i] = setIds[i];
  }
  var anonymity_sets =
      pkgffi.malloc.allocate<Pointer<Pointer<Utf8>>>(anonymitySets.length);
  var anonymity_sets_lengths =
      pkgffi.malloc.allocate<Int32>(anonymitySets.length);
  for (int i = 0; i < anonymitySets.length; i++) {
    var anonymity_set =
        pkgffi.malloc.allocate<Pointer<Utf8>>(anonymitySets[i].length);
    for (int j = 0; j < anonymitySets[i].length; j++) {
      anonymity_set[j] = anonymitySets[i][j].toNativeUtf8();
    }
    anonymity_sets[i] = anonymity_set;
    anonymity_sets_lengths[i] = anonymitySets[i].length;
  }
  var anonymity_set_hashes =
      pkgffi.malloc.allocate<Pointer<Utf8>>(anonymitySetHashes.length);
  for (int i = 0; i < anonymitySetHashes.length; i++) {
    anonymity_set_hashes[i] = anonymitySetHashes[i].toNativeUtf8();
  }
  var group_block_hashes =
      pkgffi.malloc.allocate<Pointer<Utf8>>(groupBlockHashes.length);
  for (int i = 0; i < groupBlockHashes.length; i++) {
    group_block_hashes[i] = groupBlockHashes[i].toNativeUtf8();
  }
  String result = _createJoinSplitScript(
          txHash.toNativeUtf8(),
          spendAmount,
          subtractFeeFromAmount ? 1 : 0,
          keydata.toNativeUtf8(),
          index,
          memory_coins,
          coins.length,
          set_ids,
          setIds.length,
          anonymity_sets,
          anonymity_sets_lengths,
          anonymitySets.length,
          anonymity_set_hashes,
          anonymitySetHashes.length,
          group_block_hashes,
          groupBlockHashes.length)
      .toDartString();

  pkgffi.malloc.free(memory_coins);
  pkgffi.malloc.free(set_ids);
  for (int i = 0; i < anonymitySets.length; i++) {
    pkgffi.malloc.free(anonymity_sets[i]);
  }
  pkgffi.malloc.free(anonymity_sets);
  pkgffi.malloc.free(anonymity_sets_lengths);
  pkgffi.malloc.free(anonymity_set_hashes);
  pkgffi.malloc.free(group_block_hashes);
  return result;
}

//
//
//
//
// TODO: Test methods, remove
final Pointer<LelantusEntry> Function(
  int,
  int,
  int,
  int,
  int,
  Pointer<Utf8>,
) createEntry = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<LelantusEntry> Function(
      Int8,
      Int32,
      Int32,
      Int64,
      Uint32,
      Pointer<Utf8>,
    )>>('create_entry')
    .asFunction();

final int Function(
  Pointer<Pointer<LelantusEntry>>,
) _testy = nativeAddLib
    .lookup<
        NativeFunction<
            Uint64 Function(
      Pointer<Pointer<LelantusEntry>>,
    )>>('testy')
    .asFunction();

int testy(Pointer<Pointer<LelantusEntry>> ent) => _testy(ent);
