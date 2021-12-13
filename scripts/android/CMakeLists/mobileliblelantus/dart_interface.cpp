#include "../include/lelantus.h"
#include "Utils.h"
#include <list>
#include <android/log.h>

using namespace lelantus;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
unsigned char *H2B(const char *str){
    unsigned char * return_this = hex2bin(str);
    return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *B2H(const char *bytes, int size){
    const char * return_this = bin2hex(bytes, size);
    return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *CMS(uint64_t value,
                    const char *keydata,
                    int32_t index,
                    const char *seedID){
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "%d", value);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "%s", keydata);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "%d", index);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "%s", seedID);
    const char * return_this = CreateMintScript(
            value,
            keydata,
            index,
            seedID
    );
    return return_this;
}


extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *GPC(uint64_t value,
                const char *keydata,
                int32_t index){
    const char *return_this = GetPublicCoin(
            value,
            keydata,
            index
    );
    return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
LelantusEntry* create_entry(bool isUsed,
                                  	int height,
                                  	int anonymitySetId,
                                  	int64_t amount,
                                  	uint32_t index,
                                  	const char *keydata){
    struct LelantusEntry *entry = (struct LelantusEntry *)malloc(sizeof (struct LelantusEntry));
    entry->isUsed = isUsed;
    entry->height = height;
    entry->anonymitySetId = anonymitySetId;
    entry->amount = amount;
    entry->index = index;
    entry->keydata = keydata;
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original address %p", entry);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original isUsed %d", entry->isUsed);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original height %d", entry->height);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original anonymitySetId %d", entry->anonymitySetId);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original amount %d", entry->amount);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original index %d", entry->index);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "original address %s", entry->keydata);
    return entry;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t testy(LelantusEntry ** coins){
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "ad1 %p", coins);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "ads1 %p", coins[0]);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "isUsed %d", ( (LelantusEntry *)coins[0])->isUsed);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "height %d", ( (LelantusEntry *)coins[0])->height);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "anonymitySetId %d", ( (LelantusEntry *)coins[0])->anonymitySetId);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "amount %d", ( (LelantusEntry *)coins[0])->amount);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "index %d", ( (LelantusEntry *)coins[0])->index);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "keydata %s", ( (LelantusEntry *)coins[0])->keydata);
    return 0;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t EF(uint64_t spendAmount,
            bool subtractFeeFromAmount,
            LelantusEntry ** coins,
            int32_t coins_length,
            uint64_t changeToMint,
            int32_t * spendCoinIndexes,
            int32_t spendCoinIndexes_length
            ){
    std::list<LelantusEntry> list_coins;
    for(int i = 0; i < coins_length; i++){
        list_coins.emplace_back(*(coins[i]));
    }

    std::vector<int32_t> list_spendCoinIndexes;
    for(int i = 0; i < spendCoinIndexes_length; i++){
        list_spendCoinIndexes.emplace_back(spendCoinIndexes[i]);
    }


    uint64_t return_this = EstimateFee(
            spendAmount,
            subtractFeeFromAmount,
            list_coins,
            changeToMint,
            list_spendCoinIndexes
    );
    return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t GMKP(uint64_t value,
              const char *keydata,
              int32_t index){
    uint32_t return_this = GetMintKeyPath(
            value,
            keydata,
            index
    );
    return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *CJMS(uint64_t value,
                 const char *keydata,
                 int32_t index,
                 const char *seedID,
                 const char *AESkeydata){
    const char * return_this = CreateJMintScript(
            value,
            keydata,
            index,
            seedID,
            AESkeydata);
	return return_this;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *CJSS(
    const char *txHash,
    uint64_t spendAmount,
    bool subtractFeeFromAmount, 
    const char *keydata,
    uint32_t index,
    LelantusEntry ** coins,
    int32_t coins_length,
    uint32_t * setIds,
    int32_t setIds_length,
    const char *** anonymitySets,
    int32_t * anonymitySets_lengths,
    int32_t anonymitySets_length,
    const char ** anonymitySetHashes,
    int32_t anonymitySetHashes_length,
    const char ** groupBlockHashes,
    int32_t groupBlockHashes_length){
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "txHash %s", txHash);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "spendAmount %d", spendAmount);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "subtractFeeFromAmount %d", subtractFeeFromAmount);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "keydata %s", keydata);
    __android_log_print(ANDROID_LOG_DEBUG, "flutter", "index %d", index);

    
    std::list<LelantusEntry> list_coins;
    for(int i = 0; i < coins_length; i++){
        list_coins.emplace_back(*(coins[i]));

        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "ad1 %p", coins);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "ads1 %p", coins[0]);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "isUsed %d", ( (LelantusEntry *)coins[0])->isUsed);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "height %d", ( (LelantusEntry *)coins[0])->height);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "anonymitySetId %d", ( (LelantusEntry *)coins[0])->anonymitySetId);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "amount %d", ( (LelantusEntry *)coins[0])->amount);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "index %d", ( (LelantusEntry *)coins[0])->index);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "keydata %s", ( (LelantusEntry *)coins[0])->keydata);
    }

    std::vector<uint32_t> list_setIds;
    for(int i = 0; i < setIds_length; i++){
        list_setIds.emplace_back(setIds[i]);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "setIds1 %d", setIds[i]);
    }

    std::vector<std::vector<const char *>> list_anonymitySets;
    for(int i = 0; i < anonymitySets_length; i++){
        std::vector<const char *> anonymitySet;
        int32_t anonymitySet_length = anonymitySets_lengths[i];
        for(int j = 0; j < anonymitySet_length; j++){
            anonymitySet.emplace_back( ((anonymitySets[i]))[j] );
            __android_log_print(ANDROID_LOG_DEBUG, "flutter", "anonymitySet %s", ((anonymitySets[i]))[j]);
        }
        list_anonymitySets.emplace_back(anonymitySet);
    }

    std::vector<const char *> list_anonymitySetHashes;
    for(int i = 0; i < anonymitySetHashes_length; i++){
        list_anonymitySetHashes.emplace_back(anonymitySetHashes[i]);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "anonymitySetHashes %s", anonymitySetHashes[i]);
    }

    std::vector<const char *> list_groupBlockHashes;
    for(int i = 0; i < groupBlockHashes_length; i++){
        list_groupBlockHashes.emplace_back(groupBlockHashes[i]);
        __android_log_print(ANDROID_LOG_DEBUG, "flutter", "groupBlockHashes %s", groupBlockHashes[i]);
    }

    const char * return_this = CreateJoinSplitScript(
            txHash,
            spendAmount,
            subtractFeeFromAmount,
            keydata,
            index,
            list_coins,
            list_setIds,
            list_anonymitySets,
            list_anonymitySetHashes,
            list_groupBlockHashes);
    return return_this;
}