#include "../include/lelantus.h"
#include "Utils.h"
#include <list>
#include <android/log.h>

using namespace lelantus;

extern "C" __attribute__((visibility("default"))) __attribute__((used)) unsigned char *H2B(const char *str)
{
    try
    {
        unsigned char *return_this = hex2bin(str);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "Estimate Fee Error: ", "%s", e.what());
        unsigned char *return_this;
        return return_this;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
B2H(const char *bytes, int size)
{
    try
    {
        const char *return_this = bin2hex(bytes, size);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "Estimate Fee Error: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
CMS(uint64_t value,
    const char *keydata,
    int32_t index,
    const char *seedID)
{
    try
    {
        const char *return_this = CreateMintScript(
            value,
            keydata,
            index,
            seedID);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "CMS: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
CT(const char *keydata,
   int32_t index,
   const char *seedID)
{
    try
    {
        const char *return_this = CreateTag(
            keydata,
            index,
            seedID);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "CT: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
GPC(uint64_t value,
    const char *keydata,
    int32_t index)
{
    try
    {
        const char *return_this = GetPublicCoin(
            value,
            keydata,
            index);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "GPC: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used)) char **allocate_anonymity_set(int32_t size)
{
    try
    {
        char **anonymity_set_list = (char **)calloc(size, sizeof(char *));
        return anonymity_set_list;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "allocate_anonymity_set: ", "%s", e.what());
        char **anonymity_set_list;
        return anonymity_set_list;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used)) char **allocate_anonymity_sets(int32_t size)
{
    try
    {
        char **anonymity_set_list = (char **)calloc(size, sizeof(char *));
        return anonymity_set_list;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "allocate_anonymity_set: ", "%s", e.what());
        char **anonymity_set_list;
        return anonymity_set_list;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used)) char ***allocate_string_array(int32_t size)
{
    try
    {
        char ***anonymity_set_list = (char ***)calloc(size, sizeof(char *));
        return anonymity_set_list;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "allocate_anonymity_set: ", "%s", e.what());
        char ***anonymity_set_list;
        return anonymity_set_list;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
LelantusEntry *
create_entry(bool isUsed,
             int height,
             int anonymitySetId,
             int64_t amount,
             uint32_t index,
             const char *keydata)
{
    try
    {
        struct LelantusEntry *entry = (struct LelantusEntry *)calloc(1, sizeof(struct LelantusEntry));
        entry->isUsed = isUsed;
        entry->height = height;
        entry->anonymitySetId = anonymitySetId;
        entry->amount = amount;
        entry->index = index;
        entry->keydata = keydata;
        return entry;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "create_entry: ", "%s", e.what());
        return (struct LelantusEntry *)calloc(1, sizeof(struct LelantusEntry));
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
LelantusEntry **
make_entry_array(int32_t size)
{
    LelantusEntry **entryarray = (LelantusEntry **)calloc(size, sizeof(LelantusEntry *));
    return entryarray;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t *
uint64_t_array(int32_t size)
{
    uint64_t * entryarray = (uint64_t *)calloc(size, sizeof(uint64_t));
    return entryarray;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t *
uint32_t_array(int32_t size)
{
    uint32_t * entryarray = (uint32_t *)calloc(size, sizeof(uint32_t));
    return entryarray;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t *
int32_t_array(int32_t size)
{
    int32_t * entryarray = (int32_t *)calloc(size, sizeof(int32_t));
    return entryarray;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t
testy(LelantusEntry **coins)
{
    return 0;
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
GSN(uint64_t value,
    const char *keydata,
    int32_t index)
{
    try
    {
        const char *return_this = GetSerialNumber(
            value,
            keydata,
            index);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "GSN: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t
EF(uint64_t spendAmount,
   bool subtractFeeFromAmount,
   LelantusEntry **coins,
   int32_t coins_length,
   uint64_t *changeToMint,
   int32_t *spendCoinIndexes,
   int32_t *spendCoinIndexes_length)
{
    try
    {
        std::list<LelantusEntry> list_coins;
        for (int i = 0; i < coins_length; i++)
        {
            list_coins.emplace_back(*(coins[i]));
        }

        std::vector<int32_t> list_spendCoinIndexes;

        uint64_t return_this = EstimateFee(
            spendAmount,
            subtractFeeFromAmount,
            list_coins,
            *changeToMint,
            list_spendCoinIndexes);
        for (int i = 0; i < list_spendCoinIndexes.size(); i++)
        {
            spendCoinIndexes[i] = list_spendCoinIndexes[i];
        }
        spendCoinIndexes_length[0] = list_spendCoinIndexes.size();
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "Estimate Fee Error: ", "%s", e.what());
        return 1;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t
GMKP(uint64_t value,
     const char *keydata,
     int32_t index)
{
    try
    {
        uint32_t return_this = GetMintKeyPath(
            value,
            keydata,
            index);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "GMKP: ", "%s", e.what());
        return 1;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint32_t
GAKP(const char *serializedCoin)
{
    try
    {
        uint32_t return_this = GetAesKeyPath(serializedCoin);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "GAKP: ", "%s", e.what());
        return 1;
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
CJMS(uint64_t value,
     const char *keydata,
     int32_t index,
     const char *seedID,
     const char *AESkeydata)
{
    try
    {
        const char *return_this = CreateJMintScript(
            value,
            keydata,
            index,
            seedID,
            AESkeydata);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "CJMS: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char *
CJSS(
    const char *txHash,
    uint64_t spendAmount,
    bool subtractFeeFromAmount,
    const char *keydata,
    uint32_t index,
    LelantusEntry **coins,
    int32_t coins_length,
    uint32_t *setIds,
    int32_t setIds_length,
    const char ***anonymitySets,
    int32_t *anonymitySets_lengths,
    int32_t anonymitySets_length,
    const char **anonymitySetHashes,
    int32_t anonymitySetHashes_length,
    const char **groupBlockHashes,
    int32_t groupBlockHashes_length)
{
    try
    {

        std::list<LelantusEntry> list_coins;
        for (int i = 0; i < coins_length; i++)
        {
            list_coins.push_back(*((LelantusEntry *)coins[i]));
        }

        std::vector<uint32_t> list_setIds;
        for (int i = 0; i < setIds_length; i++)
        {
            list_setIds.emplace_back(setIds[i]);
        }

        std::vector<std::vector<const char *>> list_anonymitySets;
        for (int i = 0; i < anonymitySets_length; i++)
        {
            std::vector<const char *> anonymitySet;
            anonymitySet.reserve(anonymitySets_lengths[i]);
            int32_t anonymitySet_length = anonymitySets_lengths[i];
            for (int j = 0; j < anonymitySet_length; j++)
            {
                anonymitySet.push_back(((anonymitySets[i]))[j]);
            }
            list_anonymitySets.emplace_back(anonymitySet);
        }

        std::vector<const char *> list_anonymitySetHashes;
        for (int i = 0; i < anonymitySetHashes_length; i++)
        {
            list_anonymitySetHashes.push_back(anonymitySetHashes[i]);
        }

        std::vector<const char *> list_groupBlockHashes;
        for (int i = 0; i < groupBlockHashes_length; i++)
        {
            list_groupBlockHashes.push_back(groupBlockHashes[i]);
        }

        try
        {
            const char *return_this = CreateJoinSplitScript(
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
        catch (exception &e)
        {
            __android_log_print(ANDROID_LOG_DEBUG, "CreateJoinSplitScript Error: ", "%s", e.what());
            return "Error";
        }
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "CJSS: ", "%s", e.what());
        return e.what();
    }
}

extern "C" __attribute__((visibility("default"))) __attribute__((used))
uint64_t
DMA(const char *privateKeyAES,
    const char *encryptedValue)
{
    try
    {
        uint64_t return_this = DecryptMintAmount(
            privateKeyAES,
            encryptedValue);
        return return_this;
    }
    catch (exception e)
    {
        __android_log_print(ANDROID_LOG_DEBUG, "DMA: ", "%s", e.what());
        return 1;
    }
}