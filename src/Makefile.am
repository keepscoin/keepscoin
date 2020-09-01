# Copyright (c) 2013-2016 The Bitcoin Core developers
# Copyright (c) 2017-2019 The Bicoin Green Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS) $(GPROF_LDFLAGS) $(SANITIZER_LDFLAGS)
AM_CXXFLAGS = $(DEBUG_CXXFLAGS) $(HARDENED_CXXFLAGS) $(WARN_CXXFLAGS) $(NOWARN_CXXFLAGS) $(ERROR_CXXFLAGS) $(GPROF_CXXFLAGS) $(SANITIZER_CXXFLAGS)
AM_CPPFLAGS = $(DEBUG_CPPFLAGS) $(HARDENED_CPPFLAGS)
AM_LIBTOOLFLAGS = --preserve-dup-deps
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

KPCOIN_INCLUDES=-I$(builddir) $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

KPCOIN_INCLUDES += -I$(srcdir)/secp256k1/include
KPCOIN_INCLUDES += $(UNIVALUE_CFLAGS)

LIBKPCOIN_SERVER=libkpcoin_server.a
LIBKPCOIN_COMMON=libkpcoin_common.a
LIBKPCOIN_CLI=libkpcoin_cli.a
LIBKPCOIN_UTIL=libkpcoin_util.a
LIBKPCOIN_CRYPTO=crypto/libkpcoin_crypto.a
LIBKPCOINQT=qt/libkpcoinqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBKPCOIN_ZMQ=libkpcoin_zmq.a
endif
if BUILD_KPCOIN_LIBS
LIBKPCOINCONSENSUS=libkpcoinconsensus.la
endif
if ENABLE_WALLET
LIBKPCOIN_WALLET=libkpcoin_wallet.a
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*.h) $(wildcard secp256k1/src/*.c) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBKPCOIN_CRYPTO) \
  $(LIBKPCOIN_UTIL) \
  $(LIBKPCOIN_COMMON) \
  $(LIBKPCOIN_SERVER) \
  $(LIBKPCOIN_CLI) \
  $(LIBKPCOIN_WALLET) \
  $(LIBKPCOIN_ZMQ)

lib_LTLIBRARIES = $(LIBKPCOINCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_KPCOIND
  bin_PROGRAMS += keepscoind
endif

if BUILD_KPCOIN_UTILS
  bin_PROGRAMS += keepscoin-cli keepscoin-tx
endif

.PHONY: FORCE check-symbols check-security
# keepscoin core #
KPCOIN_CORE_H = \
  activemasternode.h \
  addrman.h \
  alert.h \
  allocators.h \
  amount.h \
  base58.h \
  bip38.h \
  bloom.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coincontrol.h \
  coins.h \
  compat.h \
  compat/sanity.h \
  compressor.h \
  primitives/block.h \
  primitives/transaction.h \
  core_io.h \
  crypter.h \
  db.h \
  hash.h \
  httprpc.h \
  httpserver.h \
  init.h \
  kernel.h \
  swifttx.h \
  key.h \
  keystore.h \
  leveldbwrapper.h \
  limitedmap.h \
  main.h \
  masternode.h \
  masternode-payments.h \
  masternode-budget.h \
  masternode-sync.h \
  masternodeman.h \
  masternodeconfig.h \
  masternode-helpers.h \
  masternode-vote.h \
  merkleblock.h \
  miner.h \
  mruset.h \
  netbase.h \
  net.h \
  noui.h \
  pow.h \
  protocol.h \
  pubkey.h \
  random.h \
  reverselock.h \
  reverse_iterate.h \
  rpcclient.h \
  rpcprotocol.h \
  rpcserver.h \
  scheduler.h \
  script/interpreter.h \
  script/script.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  script/script_error.h \
  serialize.h \
  spork.h \
  sporkdb.h \
  streams.h \
  support/cleanse.h \
  sync.h \
  threadsafety.h \
  timedata.h \
  tinyformat.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  uint256.h \
  undo.h \
  util.h \
  utilstrencodings.h \
  utilmoneystr.h \
  utiltime.h \
  validationinterface.h \
  version.h \
  wallet.h \
  wallet_ismine.h \
  walletdb.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h \
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h

obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh "$(abs_top_builddir)/src/obj/build.h" \
	  "$(abs_top_srcdir)"
libkpcoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between keepscoind and keepscoin-qt
libkpcoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libkpcoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_server_a_SOURCES = \
  addrman.cpp \
  alert.cpp \
  bloom.cpp \
  chain.cpp \
  checkpoints.cpp \
  httprpc.cpp \
  httpserver.cpp \
  init.cpp \
  leveldbwrapper.cpp \
  main.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  noui.cpp \
  pow.cpp \
  rest.cpp \
  rpcblockchain.cpp \
  rpcmasternode.cpp \
  rpcmasternode-budget.cpp \
  rpcmasternode-vote.cpp \
  rpcmining.cpp \
  rpcmisc.cpp \
  rpcnet.cpp \
  rpcrawtransaction.cpp \
  rpcserver.cpp \
  script/sigcache.cpp \
  sporkdb.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  validationinterface.cpp \
  $(KPCOIN_CORE_H)

if ENABLE_ZMQ
libkpcoin_zmq_a_CPPFLAGS = $(KPCOIN_INCLUDES) $(ZMQ_CFLAGS)
libkpcoin_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp
endif

# wallet: shared between keepscoind and keepscoin-qt, but only linked
# when wallet enabled
libkpcoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
libkpcoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_wallet_a_SOURCES = \
  activemasternode.cpp \
  bip38.cpp \
  db.cpp \
  crypter.cpp \
  swifttx.cpp \
  masternode.cpp \
  masternode-budget.cpp \
  masternode-payments.cpp \
  masternode-sync.cpp \
  masternodeconfig.cpp \
  masternodeman.cpp \
  masternode-helpers.cpp \
  masternode-vote.cpp \
  rpcdump.cpp \
  rpcwallet.cpp \
  kernel.cpp \
  wallet.cpp \
  wallet_ismine.cpp \
  walletdb.cpp \
  $(KPCOIN_CORE_H)

# crypto primitives library
crypto_libkpcoin_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(PIC_FLAGS)
crypto_libkpcoin_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIC_FLAGS)
crypto_libkpcoin_crypto_a_SOURCES = \
  crypto/sha1.cpp \
  crypto/sha256.cpp \
  crypto/sha512.cpp \
  crypto/hmac_sha256.cpp \
  crypto/rfc6979_hmac_sha256.cpp \
  crypto/hmac_sha512.cpp \
  crypto/scrypt.cpp \
  crypto/ripemd160.cpp \
  crypto/aes_helper.c \
  crypto/blake.c \
  crypto/bmw.c \
  crypto/groestl.c \
  crypto/jh.c \
  crypto/keccak.c \
  crypto/skein.c \
  crypto/common.h \
  crypto/sha256.h \
  crypto/sha512.h \
  crypto/hmac_sha256.h \
  crypto/rfc6979_hmac_sha256.h \
  crypto/hmac_sha512.h \
  crypto/scrypt.h \
  crypto/sha1.h \
  crypto/ripemd160.h \
  crypto/sph_blake.h \
  crypto/sph_bmw.h \
  crypto/sph_groestl.h \
  crypto/sph_jh.h \
  crypto/sph_keccak.h \
  crypto/sph_skein.h \
  crypto/sph_types.h

# common: shared between keepscoind, and keepscoin-qt and non-server tools
libkpcoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
libkpcoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_common_a_SOURCES = \
  allocators.cpp \
  amount.cpp \
  base58.cpp \
  bip38.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  primitives/block.cpp \
  primitives/transaction.cpp \
  core_read.cpp \
  core_write.cpp \
  hash.cpp \
  key.cpp \
  keystore.cpp \
  netbase.cpp \
  protocol.cpp \
  pubkey.cpp \
  scheduler.cpp \
  script/interpreter.cpp \
  script/script.cpp \
  script/sign.cpp \
  script/standard.cpp \
  script/script_error.cpp \
  spork.cpp \
  sporkdb.cpp \
  $(KPCOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libkpcoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
libkpcoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_util_a_SOURCES = \
  allocators.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpcprotocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  uint256.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(KPCOIN_CORE_H)

if GLIBC_BACK_COMPAT
libkpcoin_util_a_SOURCES += compat/glibc_compat.cpp
AM_LDFLAGS += $(COMPAT_LDFLAGS)
endif

# cli: shared between keepscoin-cli and keepscoin-qt
libkpcoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
libkpcoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libkpcoin_cli_a_SOURCES = \
  rpcclient.cpp \
  $(KPCOIN_CORE_H)

nodist_libkpcoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# keepscoind binary #
keepscoind_SOURCES = keepscoind.cpp
keepscoind_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
keepscoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
keepscoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
keepscoind_SOURCES += keepscoind-res.rc
endif
keepscoind_LDADD = \
  $(LIBKPCOIN_SERVER) \
  $(LIBKPCOIN_WALLET) \
  $(LIBKPCOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBKPCOIN_UTIL) \
  $(LIBKPCOIN_ZMQ) \
  $(LIBKPCOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

keepscoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# keepscoin-cli binary #
keepscoin_cli_SOURCES = keepscoin-cli.cpp
keepscoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES) $(EVENT_CFLAGS)
keepscoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
keepscoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
keepscoind_SOURCES += keepscoind-res.rc
endif

keepscoin_cli_LDADD = \
  $(LIBKPCOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBKPCOIN_UTIL) \
  $(LIBKPCOIN_CRYPTO)

keepscoin_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# keepscoin-tx binary #
keepscoin_tx_SOURCES = keepscoin-tx.cpp
keepscoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(KPCOIN_INCLUDES)
keepscoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
keepscoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
keepscoin_tx_SOURCES += keepscoin-tx-res.rc
endif

keepscoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBKPCOIN_COMMON) \
  $(LIBKPCOIN_UTIL) \
  $(LIBKPCOIN_CRYPTO) \
  $(LIBSECP256K1)

keepscoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# kpcoinconsensus library #
if BUILD_KPCOIN_LIBS
include_HEADERS = script/kpcoinconsensus.h
libkpcoinconsensus_la_SOURCES = \
  allocators.cpp \
  primitives/transaction.cpp \
  crypto/hmac_sha512.cpp \
  crypto/scrypt.cpp \
  crypto/sha1.cpp \
  crypto/sha256.cpp \
  crypto/sha512.cpp \
  crypto/ripemd160.cpp \
  hash.cpp \
  pubkey.cpp \
  script/script.cpp \
  script/interpreter.cpp \
  script/kpcoinconsensus.cpp \
  uint256.cpp \
  utilstrencodings.cpp

if GLIBC_BACK_COMPAT
  libkpcoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libkpcoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libkpcoinconsensus_la_LIBADD = $(LIBSECP256K1)
libkpcoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_KPCOIN_INTERNAL
libkpcoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno
CLEANFILES += obj/build.h

EXTRA_DIST =


config/keepscoin-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/keepscoin-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/keepscoin-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/keepscoin-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
