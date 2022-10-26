// https://github.com/firoorg/mobile/tree/main/react-native-lelantus/android/src/main/jniLibs

#ifndef ORG_FIRO_LELANTUS_UTILS_H
#define ORG_FIRO_LELANTUS_UTILS_H

#include "../include/lelantus.h"

#define LELANTUS_TX_TPAYLOAD 47

struct LelantusEntry {
	bool isUsed;
	int height;
	int anonymitySetId;
	int64_t amount;
	uint32_t index;
	const char *keydata;
};

char const hexArray[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
						   'e', 'f'};

void setTestnet(bool isTestnet_);

unsigned char *hex2bin(const char *str);

const char *bin2hex(const unsigned char *bytes, int size);

const char *bin2hex(const char *bytes, int size);

const char *bin2hex(std::vector<unsigned char> bytes, int size);

const char *CreateMintScript(
		uint64_t value,
		const char *keydata,
		int32_t index,
		const char *seedID,
		bool isTestnet_ = false
);

const char *CreateTag(
		const char *keydata,
		int32_t index,
		const char *seedID,
        bool isTestnet_ = false
);

const char *GetPublicCoin(
		uint64_t value,
		const char *keydata,
		int32_t index,
        bool isTestnet_ = false
);

const char *GetSerialNumber(
		uint64_t value,
		const char *keydata,
		int32_t index,
        bool isTestnet_ = false
);

uint64_t EstimateFee(
		uint64_t spendAmount,
		bool subtractFeeFromAmount,
		std::list<LelantusEntry> coins,
		uint64_t &changeToMint,
		std::vector<int32_t> &spendCoinIndexes,
        bool isTestnet_ = false
);

uint32_t GetMintKeyPath(
		uint64_t value,
		const char *keydata,
		int32_t index,
        bool isTestnet_ = false
);

uint32_t GetAesKeyPath(
		const char *serializedCoin
);

const char *CreateJMintScript(
		uint64_t value,
		const char *keydata,
		int32_t index,
		const char *seedID,
		const char *AESkeydata,
		bool isTestnet_ = false);

const char *CreateJoinSplitScript(
		const char *txHash,
		uint64_t spendAmount,
		bool subtractFeeFromAmount,
		const char *keydata,
		uint32_t index,
		std::list<LelantusEntry> coins,
		std::vector<uint32_t> setIds,
		std::vector<std::vector<const char *>> anonymitySets,
		const std::vector<const char *> &anonymitySetHashes,
		std::vector<const char *> groupBlockHashes,
		bool isTestnet_ = false
);

uint64_t DecryptMintAmount(
		const char *privateKeyAES,
		const char *encryptedValue
);

#endif //ORG_FIRO_LELANTUS_UTILS_H
