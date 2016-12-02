From: "Grim, Dennis" <Dennis.Grim@teejet.com>
Subject: ti hecc rx frames out of order
Date: Fri, 2 Dec 2016 19:43:33 +0000
Message-ID: <1579A5A5423CC14B827884B535F8E951349421F6@SSCOXCHG2.spray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ms.spray.com ([207.247.13.3]:47076 "EHLO mail.spray.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754687AbcLBTne (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 2 Dec 2016 14:43:34 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

When running canfdtest on a TI AM3517 HECC, frames randomly appear out of order.

"can-utils" is current (cloned this week from github)

Linux kernel is 3.19.0.

From host (canfdtest -vv -g can0):

0078: [8] ed ee ef f0 f1 f2 f3 f4
0078: [8] ee ef f0 f1 f2 f3 f4 f5
0078: [8] ef f0 f1 f2 f3 f4 f5 f6
0078: [8] f0 f1 f2 f3 f4 f5 f6 f7
0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 0 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 1 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 2 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 3 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 4 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 5 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 6 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9
Databyte 7 mismatch !
expected: 0078: [8] f1 f2 f3 f4 f5 f6 f7 f8
received: 0078: [8] f2 f3 f4 f5 f6 f7 f8 f9

Test messages sent and received: 507377
Exiting...

From ti hecc DUT (canfdtest -vv can2):

0077: [8] ed ee ef f0 f1 f2 f3 f4
0077: [8] ee ef f0 f1 f2 f3 f4 f5
0077: [8] ef f0 f1 f2 f3 f4 f5 f6
0077: [8] f1 f2 f3 f4 f5 f6 f7 f8
0077: [8] f2 f3 f4 f5 f6 f7 f8 f9
0077: [8] f0 f1 f2 f3 f4 f5 f6 f7   NOTE: this line is out of order
0077: [8] f3 f4 f5 f6 f7 f8 f9 fa
0077: [8] f4 f5 f6 f7 f8 f9 fa fb
0077: [8] f5 f6 f7 f8 f9 fa fb fc


From Peak PCAN-View:

99893)    594360.7  Rx         0077  8  ED EE EF F0 F1 F2 F3 F4 
99894)    594361.1  Rx         0078  8  EC ED EE EF F0 F1 F2 F3 
99895)    594361.6  Rx         0077  8  EE EF F0 F1 F2 F3 F4 F5 
99896)    594362.1  Rx         0078  8  ED EE EF F0 F1 F2 F3 F4 
99897)    594362.5  Rx         0078  8  EE EF F0 F1 F2 F3 F4 F5 
99898)    594363.0  Rx         0078  8  EF F0 F1 F2 F3 F4 F5 F6 
99899)    594363.5  Rx         0077  8  EF F0 F1 F2 F3 F4 F5 F6 
99900)    594363.9  Rx         0077  8  F0 F1 F2 F3 F4 F5 F6 F7 
99901)    594364.4  Rx         0078  8  F0 F1 F2 F3 F4 F5 F6 F7 
99902)    594364.9  Rx         0077  8  F1 F2 F3 F4 F5 F6 F7 F8 
99903)    594365.8  Rx         0077  8  F2 F3 F4 F5 F6 F7 F8 F9 
99904)    594366.8  Rx         0077  8  F3 F4 F5 F6 F7 F8 F9 FA 
99905)    594367.3  Rx         0078  8  F2 F3 F4 F5 F6 F7 F8 F9 
99906)    594367.8  Rx         0078  8  F3 F4 F5 F6 F7 F8 F9 FA 
99907)    594368.3  Rx         0077  8  F4 F5 F6 F7 F8 F9 FA FB 
99908)    594368.7  Rx         0078  8  F1 F2 F3 F4 F5 F6 F7 F8      NOTE: this line is out of order
99909)    594369.2  Rx         0077  8  F5 F6 F7 F8 F9 FA FB FC 
99910)    594369.7  Rx         0078  8  F4 F5 F6 F7 F8 F9 FA FB 
99911)    594370.2  Rx         0077  8  F6 F7 F8 F9 FA FB FC FD

I'm looking at ti_hecc.c.

Any guidance would be very much appreciated.

Dennis


