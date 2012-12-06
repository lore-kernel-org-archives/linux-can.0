From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Thu, 06 Dec 2012 18:14:12 +0100
Message-ID: <9545085.epYbjMqEeA@ws-stein>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4036287.fuKZ6k5idx@ws-stein> <50C0AC38.8080405@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38494 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1424524Ab2LFROO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 12:14:14 -0500
In-Reply-To: <50C0AC38.8080405@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

Hello Wolfgang,

On Thursday 06 December 2012 15:31:20, Wolfgang Grandegger wrote:
> >> Error on MSG ID 0x252. Got counter 96480 and expected 96466
> >> Error on MSG ID 0x251. Got counter 96480 and expected 96466
> >> Error on MSG ID 0x252. Got counter 101706 and expected 101696
> >> Error on MSG ID 0x251. Got counter 101706 and expected 101696
> > Here were messages missed/dropped for both CAN-IDs.
> 
> It is interesting that the same number of messages are missing for both
> IDs... which come from different CAN nodes, right?

Yep, node 1 sends 0x251 and node 2 sends 0x252.

> Do you see dropped messages with "ip -d -s link show canX"?
> Did you check if the protocol layer did drop messages. You can
> use "candump -d" to find that out.

My test application says:
Error on MSG ID 0x251. Got counter 8442 and expected 8427
Error on MSG ID 0x252. Got counter 8442 and expected 8426
Error on MSG ID 0x251. Got counter 8794 and expected 8792
Error on MSG ID 0x252. Got counter 8794 and expected 8791
Message counters: 0x251: 249982, 0x252: 249980

ip -s -d link show can0:
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN qlen 10
    link/can 
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0 
    bitrate 1000000 sample-point 0.700 
    tq 100 prop-seg 3 phase-seg1 3 phase-seg2 3 sjw 1
    c_can: tseg1 2..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
    clock 50000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0         
    RX: bytes  packets  errors  dropped overrun mcast   
    1999980    501239   0       0       0       0      
    TX: bytes  packets  errors  dropped carrier collsns 
    8          1        0       0       0       0

candump -d can0,0~0,#ffffffff didn't show anything. I used the filter to reduce the load from that ssh session.

On Thursday 06 December 2012 15:02:39, Marc Kleine-Budde wrote:
> >> Error on MSG ID 0x251. Got counter 108673 and expected 108672
> >> Error on MSG ID 0x251. Got counter 108672 and expected 108674
> >> Error on MSG ID 0x251. Got counter 108674 and expected 108673
> >                                      ^^^^^^
> > Here you can see the CAN frame with counter 108673 is read before 108672.
> 
> You could add some offset/mask to the counter data of MSG ID 0x252 to
> see if they get mixed up.

Yep, nice idea. But I've no idea whether I get the possibility to modify the firmware for that.

> This is a typical out-of-sequence reception with a
> RX-goes-into-first-free-mailbox hardware. I've implemented the algorithm
> used in the at91 and fixed the one for the ti_hecc.

Marc, do you mean out-of-sequence reception with such mailbox types can happen even with the algorithm used in c_can and at91?

Best regards,
Alexander

