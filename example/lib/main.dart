import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:lelantus/lelantus.dart';
import 'package:ffi/ffi.dart' as pkgffi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Lelantus.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    Pointer<LelantusEntry> le =
        createEntry(0, 1, 2, 3, 4, "aaa".toNativeUtf8());
    List<Pointer<LelantusEntry>> coins = List.empty(growable: true);
    coins.add(le);

    List<int> changeToMint = List.empty(growable: true);
    List<int> spendCoinIndexes = List.empty(growable: true);

    var lep = pkgffi.malloc.allocate<Pointer<LelantusEntry>>(1);
    lep[0] = le;

    int fee = estimateFee(2, true, coins, changeToMint, spendCoinIndexes);

    List<int> setIds = List.empty(growable: true);
    setIds.add(0);
    setIds.add(0);

    List<List<String>> anonymitySets = List.empty(growable: true);
    List<String> anonymitySet = List.empty(growable: true);
    anonymitySet.add("anonymitySet10");
    anonymitySet.add("anonymitySet11");
    anonymitySets.add(anonymitySet);
    List<String> anonymitySet2 = List.empty(growable: true);
    anonymitySet2.add("anonymitySet20");
    anonymitySet2.add("anonymitySet21");
    anonymitySets.add(anonymitySet2);

    List<String> anonymitySetHashes = List.empty(growable: true);
    anonymitySetHashes.add("anonymitySetHashes");
    anonymitySetHashes.add("anonymitySetHashes2");

    List<String> groupBlockHashes = List.empty(growable: true);
    groupBlockHashes.add("groupBlockHashes");
    groupBlockHashes.add("groupBlockHashes2");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'data for CreateMintScript\nvalue = 199336\nkeydata = "6475772460b825ac8668a71b2a88139f3c162376d3983d5fbe703dc57404d059"\nindex = 0\nseedID = "cf866e1f37d5c6a46188eea5cdb1989c76f4e1c2"'),
              const SizedBox(
                height: 10,
              ),
              const Text("getMintScript"),
              SelectableText(getMintScript(
                  199336,
                  "6475772460b825ac8668a71b2a88139f3c162376d3983d5fbe703dc57404d059",
                  0,
                  "cf866e1f37d5c6a46188eea5cdb1989c76f4e1c2")),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'getpubliccoin:\n${getPublicCoin(1, "aaaaaaaaaaaaaaaa", 0)}'),
              const SizedBox(
                height: 10,
              ),
              Text('fee: $fee changeToMint: $changeToMint'),
              const SizedBox(
                height: 10,
              ),
              Text(
                  'getMintKeyPath: ${getMintKeyPath(1, "aaaaaaaaaaaaaaaa", 0)}'),
              const SizedBox(
                height: 10,
              ),
              const Text("createJMintScript"),
              SelectableText(createJMintScript(1, "aaaaaaaaaaaaaaaa", 0,
                  "aaaaaaaaaaaaaaaa", "aaaaaaaaaaaaaaaa")),
              // TODO Need valid anonymity sets otherwise this will crash
              // const Text("CreateJoinSplitScript"),
              // SelectableText(createJoinSplitScript(
              //   "aaaaaaa",
              //   1,
              //   true,
              //   "aaaaaaaaaaaaaaaa",
              //   0,
              //   coins,
              //   setIds,
              //   anonymitySets,
              //   anonymitySetHashes,
              //   groupBlockHashes,
              // )),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Text(hex2Bin("c5")),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Text(bin2Hex("10")),
            ],
          ),
        ),
      ),
    );
  }
}
