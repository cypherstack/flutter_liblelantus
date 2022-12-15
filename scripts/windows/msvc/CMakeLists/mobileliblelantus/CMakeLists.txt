cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
project(mobileliblelantus)

set(OPENSSL_USE_STATIC_LIBS OFF CACHE BOOL "" FORCE)

SET(distribution_DIR C:/src/flutter_liblelantus/scripts/windows/MSVC/build)
SET(OPENSSL_ROOT_DIR ${distribution_DIR}/prefix_x86_64)

SET(OPENSSL_LIBRARIES_DIR "${OPENSSL_ROOT_DIR}/lib")
SET(OPENSSL_INCLUDE_DIR ${OPENSSL_ROOT_DIR}/include)
SET(OPENSSL_LIBRARIES "ssl" "crypto")

LINK_DIRECTORIES(${OPENSSL_LIBRARIES_DIR}/*)

add_subdirectory(secp256k1)

set_property(SOURCE src/lelantus.cpp
    bitcoin/amount.cpp
    bitcoin/arith_uint256.cpp
    bitcoin/uint256.cpp
    bitcoin/utilstrencodings.cpp
    bitcoin/crypto/aes.cpp
    bitcoin/crypto/hmac_sha512.cpp
    bitcoin/crypto/sha256.cpp
    bitcoin/crypto/sha512.cpp
    bitcoin/support/cleanse.cpp
    src/coin.cpp
    src/innerproduct_proof_generator.cpp
    src/innerproduct_proof_verifier.cpp
    src/joinsplit.cpp
    src/lelantus_primitives.cpp
    src/lelantus_prover.cpp
    src/lelantus_verifier.cpp
    src/params.cpp
    src/range_prover.cpp
    src/range_verifier.cpp
    src/schnorr_prover.cpp
    src/schnorr_verifier.cpp
    src/sigmaextended_prover.cpp
    src/sigmaextended_verifier.cpp
    src/spend_metadata.cpp
    src/Utils.cpp
    src/dart_interface.cpp
    PROPERTY COMPILE_FLAGS "-std=c++17" )


add_library(mobileliblelantus SHARED
    src/lelantus.cpp
    bitcoin/amount.cpp
    bitcoin/arith_uint256.cpp
    bitcoin/uint256.cpp
    bitcoin/utilstrencodings.cpp
    bitcoin/crypto/aes.cpp
    bitcoin/crypto/hmac_sha512.cpp
    bitcoin/crypto/sha256.cpp
    bitcoin/crypto/sha512.cpp
    bitcoin/support/cleanse.cpp
    src/coin.cpp
    src/innerproduct_proof_generator.cpp
    src/innerproduct_proof_verifier.cpp
    src/joinsplit.cpp
    src/lelantus_primitives.cpp
    src/lelantus_prover.cpp
    src/lelantus_verifier.cpp
    src/params.cpp
    src/range_prover.cpp
    src/range_verifier.cpp
    src/schnorr_prover.cpp
    src/schnorr_verifier.cpp
    src/sigmaextended_prover.cpp
    src/sigmaextended_verifier.cpp
    src/spend_metadata.cpp
    src/Utils.cpp
    src/dart_interface.cpp)

target_link_libraries(mobileliblelantus ${OPENSSL_LIBRARIES} secp256k1 ws2_32)

add_dependencies(mobileliblelantus secp256k1)

target_include_directories(mobileliblelantus PUBLIC secp256k1 ${OPENSSL_INCLUDE_DIR})
