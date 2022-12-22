import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:ffi/ffi.dart' as pkgffi;
import 'package:flutter/services.dart';

class Lelantus {
  static const MethodChannel _channel = MethodChannel('lelantus');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

final DynamicLibrary nativeAddLib = Platform.isWindows
    ? DynamicLibrary.open("libmobileliblelantus.dll")
    : Platform.environment.containsKey('FLUTTER_TEST')
        ? DynamicLibrary.open(
            'crypto_plugins/flutter_liblelantus/scripts/linux/build/libmobileliblelantus.so')
        : Platform.isAndroid || Platform.isLinux
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

class DartLelantusEntry {
  int isUsed;
  int height;
  int anonymitySetId;
  int amount;
  int index;
  String keydata;

  DartLelantusEntry(this.isUsed, this.height, this.anonymitySetId, this.amount,
      this.index, this.keydata);
  String toString() {
    return "${isUsed} $height, $anonymitySetId, $amount, $index, $keydata";
  }
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

final void Function(
  int, // value
) _setTestnet = nativeAddLib
    .lookup<
        NativeFunction<
            Void Function(
      Int8, // value
    )>>('ST')
    .asFunction();

void setTestnet(
  bool isTestnet,
) =>
    _setTestnet(
      isTestnet ? 1 : 0,
    );

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  Pointer<Utf8>, // seedID
  int, // isTestnet
) _getMintScript = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Pointer<Utf8>, // seedID
      Int8, // isTestnet
    )>>('CMS')
    .asFunction();

String getMintScript(int value, String keydata, int index, String seedID,
        {bool isTestnet = false}) =>
    _getMintScript(
      value,
      keydata.toNativeUtf8(),
      index,
      seedID.toNativeUtf8(),
      isTestnet ? 1 : 0,
    ).toDartString();

final Pointer<Utf8> Function(
  Pointer<Utf8>, // keydata
  int, // index
  Pointer<Utf8>, // seedID
  int, // isTestnet
) _CreateTag = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Pointer<Utf8>, // keydata
      Int32, // index
      Pointer<Utf8>, // seedID
      Int8, // isTestnet
    )>>('CT')
    .asFunction();

String CreateTag(String keydata, int index, String seedID,
        {bool isTestnet = false}) =>
    _CreateTag(
      keydata.toNativeUtf8(),
      index,
      seedID.toNativeUtf8(),
      isTestnet ? 1 : 0,
    ).toDartString();

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, //keydata
  int, //index
  int, // isTestnet
) _getPublicCoin = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Int8, // isTestnet
    )>>('GPC')
    .asFunction();

String getPublicCoin(int value, String keydata, int index,
        {bool isTestnet = false}) =>
    _getPublicCoin(
      value,
      keydata.toNativeUtf8(),
      index,
      isTestnet ? 1 : 0,
    ).toDartString();

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  int, // isTestnet
) _GetSerialNumber = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Int8, // isTestnet
    )>>('GSN')
    .asFunction();

String GetSerialNumber(int value, String keydata, int index,
        {bool isTestnet = false}) =>
    _GetSerialNumber(
      value,
      keydata.toNativeUtf8(),
      index,
      isTestnet ? 1 : 0,
    ).toDartString();

final int Function(
  int, // spendAmount
  int, // subtractFeeFromAmount
  Pointer<Pointer<LelantusEntry>>, // coins
  int, // coins_length
  Pointer<Uint64>, // changeToMint
  Pointer<Int32>, // spendCoinIndexes
  Pointer<Int32>, // spendCoinIndexes_length
  int, // isTestnet
) _estimateFee = nativeAddLib
    .lookup<
        NativeFunction<
            Uint64 Function(
      Uint64, // spendAmount
      Int8, // subtractFeeFromAmount
      Pointer<Pointer<LelantusEntry>>, // coins
      Int32, // coins_length
      Pointer<Uint64>, // changeToMint
      Pointer<Int32>, // spendCoinIndexes
      Pointer<Int32>, // spendCoinIndexes_length
      Int8, // isTestnet
    )>>('EF')
    .asFunction();

int estimateFee(
    int spendAmount,
    bool subtractFeeFromAmount,
    List<DartLelantusEntry> coins,
    List<int> changeToMint,
    List<int> spendCoinIndexes,
    {bool isTestnet = false}) {
  Pointer<Pointer<LelantusEntry>> entries = make_entry_array(coins.length);
  for (int i = 0; i < coins.length; i++) {
    DartLelantusEntry coin = coins[i];
    entries[i] = createEntry(coin.isUsed, coin.height, coin.anonymitySetId,
        coin.amount, coin.index, coin.keydata);
  }

  var memory_changeToMint = uint64_t_array(1);

  var memory_spendCoinIndexes = int32_t_array(coins.length);
  var memory_spendCoinIndexes_length = int32_t_array(1);
  int result = _estimateFee(
    spendAmount,
    subtractFeeFromAmount ? 1 : 0,
    entries,
    coins.length,
    memory_changeToMint,
    memory_spendCoinIndexes,
    memory_spendCoinIndexes_length,
    isTestnet ? 1 : 0,
  );
  changeToMint.add(memory_changeToMint[0]);
  for (int i = 0; i < memory_spendCoinIndexes_length[0]; i++) {
    spendCoinIndexes.add(memory_spendCoinIndexes[i]);
  }
  pkgffi.calloc.free(entries);
  pkgffi.calloc.free(memory_changeToMint);
  pkgffi.calloc.free(memory_spendCoinIndexes);
  pkgffi.calloc.free(memory_spendCoinIndexes_length);
  return result;
}

final int Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  int, // isTestnet
) _getMintKeyPath = nativeAddLib
    .lookup<
        NativeFunction<
            Uint32 Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, //index
      Int8, // isTestnet
    )>>('GMKP')
    .asFunction();

int getMintKeyPath(int value, String keydata, int index,
        {bool isTestnet = false}) =>
    _getMintKeyPath(
      value,
      keydata.toNativeUtf8(),
      index,
      isTestnet ? 1 : 0,
    );

final int Function(
  Pointer<Utf8>, // serializedCoin
) _GetAesKeyPath = nativeAddLib
    .lookup<
        NativeFunction<
            Uint32 Function(
      Pointer<Utf8>, // serializedCoin
    )>>('GAKP')
    .asFunction();

int GetAesKeyPath(
  String serializedCoin,
) =>
    _GetAesKeyPath(
      serializedCoin.toNativeUtf8(),
    );

final Pointer<Utf8> Function(
  int, // value
  Pointer<Utf8>, // keydata
  int, // index
  Pointer<Utf8>, // seedID
  Pointer<Utf8>, // AESkeydata
  int, // isTestnet
) _createJMintScript = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Utf8> Function(
      Uint64, // value
      Pointer<Utf8>, // keydata
      Int32, // index
      Pointer<Utf8>, // seedID
      Pointer<Utf8>, // AESkeydata
      Int8, // isTestnet
    )>>('CJMS')
    .asFunction();

String createJMintScript(
        int value, String keydata, int index, String seedID, String AESkeydata,
        {bool isTestnet = false}) =>
    _createJMintScript(
      value,
      keydata.toNativeUtf8(),
      index,
      seedID.toNativeUtf8(),
      AESkeydata.toNativeUtf8(),
      isTestnet ? 1 : 0,
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
  int, // isTestnet
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
      Int8, // isTestnet
    )>>('CJSS')
    .asFunction();

String createJoinSplitScript(
    String txHash,
    int spendAmount,
    bool subtractFeeFromAmount,
    String keydata,
    int index,
    List<DartLelantusEntry> coins,
    List<int> setIds,
    List<List<String>> anonymitySets,
    List<String> anonymitySetHashes,
    List<String> groupBlockHashes,
    {bool isTestnet = false}) {
  try {
    Pointer<Pointer<LelantusEntry>> entries = make_entry_array(coins.length);
    for (int i = 0; i < coins.length; i++) {
      DartLelantusEntry coin = coins[i];
      entries[i] = createEntry(coin.isUsed, coin.height, coin.anonymitySetId,
          coin.amount, coin.index, coin.keydata);
    }

    var set_ids = uint32_t_array(setIds.length);
    for (int i = 0; i < setIds.length; i++) {
      set_ids[i] = setIds[i];
    }
    var anonymity_sets = allocate_string_array(anonymitySets.length);
    var anonymity_sets_lengths = int32_t_array(anonymitySets.length);
    for (int i = 0; i < anonymitySets.length; i++) {
      var anonymity_set = allocateAnonymitySet(anonymitySets[i].length);
      for (int j = 0; j < anonymitySets[i].length; j++) {
        anonymity_set[j] = anonymitySets[i][j].toNativeUtf8();
        if (anonymitySets[i][j].length != 68) {
          print("$j ${anonymitySets[i][j]}");
        }
      }
      anonymity_sets[i] = anonymity_set;
      anonymity_sets_lengths[i] = anonymitySets[i].length;
    }

    var anonymity_set_hashes = allocateAnonymitySet(anonymitySetHashes.length);
    for (int i = 0; i < anonymitySetHashes.length; i++) {
      print(anonymitySetHashes[i]);
      anonymity_set_hashes[i] = anonymitySetHashes[i].toNativeUtf8();
    }

    var group_block_hashes = allocateAnonymitySet(groupBlockHashes.length);
    for (int i = 0; i < groupBlockHashes.length; i++) {
      print(groupBlockHashes[i]);
      group_block_hashes[i] = groupBlockHashes[i].toNativeUtf8();
    }

    String result = _createJoinSplitScript(
      txHash.toNativeUtf8(),
      spendAmount,
      subtractFeeFromAmount ? 1 : 0,
      keydata.toNativeUtf8(),
      index,
      entries,
      coins.length,
      set_ids,
      setIds.length,
      anonymity_sets,
      anonymity_sets_lengths,
      anonymitySets.length,
      anonymity_set_hashes,
      anonymitySetHashes.length,
      group_block_hashes,
      groupBlockHashes.length,
      isTestnet ? 1 : 0,
    ).toDartString();

    pkgffi.calloc.free(entries);
    pkgffi.calloc.free(set_ids);
    for (int i = 0; i < anonymitySets.length; i++) {
      pkgffi.calloc.free(anonymity_sets[i]);
    }
    pkgffi.calloc.free(anonymity_sets);
    pkgffi.calloc.free(anonymity_sets_lengths);
    pkgffi.calloc.free(anonymity_set_hashes);
    pkgffi.calloc.free(group_block_hashes);
    return result;
  } catch (e) {
    print(e);
    return "dud";
  }
}

final int Function(
  Pointer<Utf8>, // privateKeyAES
  Pointer<Utf8>, // encryptedValue
) _decryptMintAmount = nativeAddLib
    .lookup<
        NativeFunction<
            Uint64 Function(
      Pointer<Utf8>, // privateKeyAES
      Pointer<Utf8>, // encryptedValue
    )>>('DMA')
    .asFunction();

int decryptMintAmount(
  String privateKeyAES,
  String encryptedValue,
) =>
    _decryptMintAmount(
      privateKeyAES.toNativeUtf8(),
      encryptedValue.toNativeUtf8(),
    );

final Pointer<Pointer<Utf8>> Function(int) allocateAnonymitySet = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Pointer<Utf8>> Function(
      Int32,
    )>>('allocate_anonymity_set')
    .asFunction();

final Pointer<Pointer<Pointer<Utf8>>> Function(int) allocate_string_array =
    nativeAddLib
        .lookup<
            NativeFunction<
                Pointer<Pointer<Pointer<Utf8>>> Function(
          Int32,
        )>>('allocate_string_array')
        .asFunction();

final Pointer<Pointer<LelantusEntry>> Function(int) make_entry_array =
    nativeAddLib
        .lookup<
            NativeFunction<
                Pointer<Pointer<LelantusEntry>> Function(
          Int32,
        )>>('make_entry_array')
        .asFunction();

final Pointer<Uint64> Function(int) uint64_t_array = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Uint64> Function(
      Int32,
    )>>('uint64_t_array')
    .asFunction();

final Pointer<Uint32> Function(int) uint32_t_array = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Uint32> Function(
      Int32,
    )>>('uint32_t_array')
    .asFunction();

final Pointer<Int32> Function(int) int32_t_array = nativeAddLib
    .lookup<
        NativeFunction<
            Pointer<Int32> Function(
      Int32,
    )>>('int32_t_array')
    .asFunction();

final Pointer<LelantusEntry> Function(
  int,
  int,
  int,
  int,
  int,
  Pointer<Utf8>,
) _createEntry = nativeAddLib
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

Pointer<LelantusEntry> createEntry(
  int isUsed,
  int height,
  int anonymitySetId,
  int amount,
  int index,
  String keydata,
) {
  return _createEntry(
      isUsed, height, anonymitySetId, amount, index, keydata.toNativeUtf8());
}
