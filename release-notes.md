KEEPSCoin Core version 1.3.0.1
==========================

Release is now available from:

  <https://www.keepscoin.com/>

This is a new major version release, including various bug fixes and performance improvements, as well as updated translations.

Please report bugs using the issue tracker at github:

  <https://github.com/keepscoin/keepscoin/issues>
 


Mandatory Update
=========================

How to Upgrade
--------------

If you are running an older version, shut it down. Wait until it has completely
shut down (which might take a few minutes for older versions), copy over sanacoind on Linux.
If you upgrade after version 1.3.0.1 activation and you were
using version < 1.3.0.1 you will have to reindex (start with -reindex -chainstate
or -reindex) to make sure your wallet has all the new data synced. Upgrading from
version 1.2.1.0 should not require any additional actions.

Compatibility
-----------------

KEEPSCoin Core is tested on Ubuntu 16.04 Lts.

KEEPSCoin Core should also work on most other Unix-like systems but is not frequently tested on them.


Notable changes
===============

Performance improvements
------------------------
Slow startup times were observed in older versions. This was due to sub-optimal handling of old
deterministic masternode lists which caused the loading of too many lists into memory. This should be
fixed now.

Fixed excessive memory use
--------------------------
Multiple issues were found which caused excessive use of memory in some situations, especially when
a full reindex was performed, causing the node to crash even when enough RAM was available. This should
be fixed now.

Fixed out-of-sync masternode list UI
------------------------------------
The masternode tab, which shows the masternode list, was not always up-to-date as it missed some internal
updates. This should be fixed now.

Fixed governance votes pruning for invalid masternodes 
------------------------------------------------------
A community member reported a possible attack that involves DoSing masternodes to force the network
to prune all governance votes from this masternodes. This could be used to manipulate vote outcomes.

This version includes a fix that requires to have at least 51% masternodes to upgrade to
1.3.0.0, after which superblock trigger voting will automatically fix the discrepancies between
old and new nodes. This also means that we will apply included PoS system.
at least 51% of masternodes have upgraded to 1.3.0.1.


Credits
=======

Thanks to everyone who directly contributed to this release:

- Momoko garza (Project Coin Main Dev)
- Arnold Carl (Project Coin Dev Assistant)


As well as everyone that submitted issues and reviewed pull requests.

Older releases
==============

KEEPSCoin tree 1.3.0.1 was a fork of Bitcoin Green 1.3.1, original name was Bitcoin Green
which was first released on Aug/22/2018.

KEEPSCoin tree 1.3.0.1 was the open source implementation of masternodes based on
the 1.2.1 tree and was first released on July/05/2019.
