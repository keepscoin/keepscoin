// Copyright (c) 2011-2014 The Bitcoin developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef KPCOIN_QT_KPCOINADDRESSVALIDATOR_H
#define KPCOIN_QT_KPCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinAddressEntryValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

/** Bitcoin address widget validator, checks for a valid kpcoin address.
 */
class BitcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinAddressCheckValidator(QObject* parent);

    State validate(QString& input, int& pos) const;
};

#endif // KPCOIN_QT_KPCOINADDRESSVALIDATOR_H
