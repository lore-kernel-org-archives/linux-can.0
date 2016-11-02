From: "Grim, Dennis" <Dennis.Grim@teejet.com>
Subject: canfdtest missing tx frame
Date: Wed, 2 Nov 2016 15:12:01 +0000
Message-ID: <1579A5A5423CC14B827884B535F8E9513493B8CE@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ms.spray.com ([207.247.13.3]:45679 "EHLO mail.spray.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755525AbcKBPRX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 2 Nov 2016 11:17:23 -0400
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I'm running canfdtest between two ports of a PEAK PCAN-PCI Express card.  The card appears to use the SJA1000.  The bus is terminated.

The ports are configured using:
ip link set can0 up type can bitrate 250000
ip link set can1 up type can bitrate 250000

The test is run using:
canfdtest can1
canfdtest -g -v -l 1000 can0

canfdtest aborts at random numbers of test messages sent and received.  The number might be less than 10 or might be several hundred.  It never reaches 1000.

Here is a typical output:

$ canfdtest -g -v -l 1000 can0
interface = can0, family = 29, type = 3, proto = 1
Databyte 0 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 1 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 2 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 3 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 4 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 5 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 6 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d
Databyte 7 mismatch !
expected: 0078: [8] 25 26 27 28 29 2a 2b 2c
received: 0078: [8] 26 27 28 29 2a 2b 2c 2d

Test messages sent and received: 37
Exiting...
$

PEAK's PCAN-View is running on a separate machine and reports:

    61)      2456.3  Rx         0077  8  1E 1F 20 21 22 23 24 25 
    62)      2456.9  Rx         0078  8  1F 20 21 22 23 24 25 26 
    63)      2457.4  Rx         0077  8  1F 20 21 22 23 24 25 26 
    64)      2458.0  Rx         0078  8  20 21 22 23 24 25 26 27 
    65)      2458.5  Rx         0077  8  20 21 22 23 24 25 26 27 
    66)      2459.1  Rx         0078  8  21 22 23 24 25 26 27 28 
    67)      2461.7  Rx         0077  8  21 22 23 24 25 26 27 28 
    68)      2462.2  Rx         0078  8  22 23 24 25 26 27 28 29 
    69)      2462.8  Rx         0077  8  22 23 24 25 26 27 28 29 
    70)      2463.3  Rx         0078  8  23 24 25 26 27 28 29 2A 
    71)      2463.9  Rx         0077  8  23 24 25 26 27 28 29 2A 
    72)      2464.5  Rx         0078  8  24 25 26 27 28 29 2A 2B 
    73)      2466.1  Rx         0077  8  25 26 27 28 29 2A 2B 2C 
    74)      2466.7  Rx         0078  8  26 27 28 29 2A 2B 2C 2D 
    75)      2467.2  Rx         0077  8  26 27 28 29 2A 2B 2C 2D 
    76)      2467.8  Rx         0078  8  27 28 29 2A 2B 2C 2D 2E 
    77)      2468.3  Rx         0077  8  27 28 29 2A 2B 2C 2D 2E 
    78)      2468.9  Rx         0078  8  28 29 2A 2B 2C 2D 2E 2F 
    79)      2469.4  Rx         0077  8  28 29 2A 2B 2C 2D 2E 2F 
    80)      2470.0  Rx         0078  8  29 2A 2B 2C 2D 2E 2F 30

Note that the following is missing from the above sequence.

                                          0077  8  24 25 26 27 28 29 2A 2B
                                          0078  8  25 26 27 28 29 2A 2B 2C

What might be the issue here?









