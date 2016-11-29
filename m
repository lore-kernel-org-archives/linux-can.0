From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Tue, 29 Nov 2016 11:30:03 +0100
Message-ID: <5633679.WId9jP25Qd@ws-stein>
References: <1864402.pXgGBBp51L@ws-stein> <3312577.WzoMqUrz0A@ws-stein> <c9a4e53c-42f8-c982-e701-0259fb1ac67b@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:37334 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753150AbcK2KaK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 29 Nov 2016 05:30:10 -0500
In-Reply-To: <c9a4e53c-42f8-c982-e701-0259fb1ac67b@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Daniel =?ISO-8859-1?Q?Kr=FCger?= <daniel.krueger@systec-electronic.com>

Hello Oliver,

On Monday 28 November 2016 21:36:09, Oliver Hartkopp wrote:
> >> IMO the difference is not to queue the skbs for a specific socket but
> >> for a specific interface.
> >> The 'endpoint' of CAN frames where they have to be in order is can_rcv()
> >> in af_can.c and not any TCP instance that needs to reassemble the TCP
> >> traffic for a specific socket.
> > 
> > Sure, TCP can handle OOO pretty fine. Even for UDP this is not a problem
> > at
> > all. But isn't using raw sockets on ethernet in promiscuous mode a
> > somewhat
> > similar scenario? Or to put it in another way: Wouldn't tcpdump or
> > wireshark suffer from the same problem?
> 
> Hm - I pushed Wireshark and libpcap to remove PF_CAN support and
> implement the CAN dissectors based on PF_PACKET:
> 
> Wireshark bug/feature request:
> https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=12687
> 
> libpcap:
> https://github.com/the-tcpdump-group/libpcap/commit/93ca5ff7030aaf1219e1de05
> ec89a68384bfc50b
> 
> Wireshark CAN/CANFD dissector:
> https://code.wireshark.org/review/#/c/16787/
> 
> Commit:
> https://code.wireshark.org/review/gitweb?p=wireshark.git;a=commitdiff;h=7fad
> 354a3e379382368cd1ef67b841315c29e050
> 
> But you need to build the latest libpcap & Wireshark to use the
> PF_PACKET flavour in Wireshark.
> 
> IIRC Wireshark puts the PF_PACKET socket into some special 'tpacket'
> mode and I don't know whether this has any impact on frame ordering.
> 
> At least you may check for:
> https://github.com/linux-can/can-tests/blob/master/tst-packet.c
> 
> ... if there's a difference between PF_PACKET and PF_CAN with your OOO
> setup.

Nope, apparently there is no difference. Got similar results.

On a side note: I captured an 30 seconds iperf3 run with wireshark 2.2.2 using 
the "ASIX Electronics Corp. AX88179 Gigabit Ethernet" adapter (driver: 
ax88179_178a).
AFAICS this driver (well usbnet in the end) doesn't use NAPI either and 
therefore unsurprisingly I got OOO of TCP frames.
IMHO this is not acceptable at all.

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein
SYS TEC electronic GmbH
alexander.stein@systec-electronic.com

Legal and Commercial Address:
Am Windrad 2
08468 Heinsdorfergrund
Germany

Office: +49 (0) 3765 38600-0
Fax:    +49 (0) 3765 38600-4100
 
Managing Directors:
	Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
	Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
Commercial Registry:
	Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010

