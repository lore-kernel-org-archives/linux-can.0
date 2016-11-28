From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: wrong CAN frame order in network layer due to SMP?
Date: Mon, 28 Nov 2016 21:36:09 +0100
Message-ID: <c9a4e53c-42f8-c982-e701-0259fb1ac67b@hartkopp.net>
References: <1864402.pXgGBBp51L@ws-stein>
 <153c7653-ab74-fd0c-c605-7bafe5e44297@hartkopp.net>
 <3312577.WzoMqUrz0A@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:18049 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbcK1UgX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Nov 2016 15:36:23 -0500
In-Reply-To: <3312577.WzoMqUrz0A@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, =?UTF-8?Q?Daniel_Kr=c3=bcger?= <daniel.krueger@systec-electronic.com>

On 11/28/2016 10:01 AM, Alexander Stein wrote:
> On Friday 25 November 2016 12:46:08, Oliver Hartkopp wrote:

>> When you look at the networking guys that like to speed up TCP traffic
>> and also put skbs into percpu queues that are related to the receiving
>> socket(!!!) instance then it should be possible to put CAN skbs related
>> to their CAN interfaces into a percpu queue (to suppress out-of-order
>> reception).
>
> But wouldn't using queues related to sockets result in different orderings in
> different sockets? I've yet to find an erroneous rest run with a non-
> conforming candump.
> Anyway I don't yet fully understand the complete code and/or data flow up to
> the socket once netif_rx() is called.
>

/me too


>> IMO the difference is not to queue the skbs for a specific socket but
>> for a specific interface.
>> The 'endpoint' of CAN frames where they have to be in order is can_rcv()
>> in af_can.c and not any TCP instance that needs to reassemble the TCP
>> traffic for a specific socket.
>
> Sure, TCP can handle OOO pretty fine. Even for UDP this is not a problem at
> all. But isn't using raw sockets on ethernet in promiscuous mode a somewhat
> similar scenario? Or to put it in another way: Wouldn't tcpdump or wireshark
> suffer from the same problem?

Hm - I pushed Wireshark and libpcap to remove PF_CAN support and 
implement the CAN dissectors based on PF_PACKET:

Wireshark bug/feature request:
https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=12687

libpcap:
https://github.com/the-tcpdump-group/libpcap/commit/93ca5ff7030aaf1219e1de05ec89a68384bfc50b

Wireshark CAN/CANFD dissector:
https://code.wireshark.org/review/#/c/16787/

Commit:
https://code.wireshark.org/review/gitweb?p=wireshark.git;a=commitdiff;h=7fad354a3e379382368cd1ef67b841315c29e050

But you need to build the latest libpcap & Wireshark to use the 
PF_PACKET flavour in Wireshark.

IIRC Wireshark puts the PF_PACKET socket into some special 'tpacket' 
mode and I don't know whether this has any impact on frame ordering.

At least you may check for:
https://github.com/linux-can/can-tests/blob/master/tst-packet.c

... if there's a difference between PF_PACKET and PF_CAN with your OOO 
setup.

Regards,
Oliver
