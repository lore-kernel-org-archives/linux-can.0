From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Thu, 12 Jan 2017 17:30:12 +0100
Message-ID: <a7ca612b-2c62-2a15-7ff0-8791db422647@hartkopp.net>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
 <1180cb22-d2e2-19a4-d0d7-d534dcec6274@hartkopp.net>
 <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:26842 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdALQa2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2017 11:30:28 -0500
In-Reply-To: <2a721fb7-38a3-a535-191a-0623742f3645@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 01/12/2017 12:40 PM, Stephane Grosjean wrote:
> Le 11/01/2017 à 21:11, Oliver Hartkopp a écrit :

>>>  - remove the IFF_ECHO flag from ndev flags (no tx-complete interrupt
>>> available)

(..)

>> Did you ask the CAN IP core designers whether they have a working
>> solution for this? Is the DMA mode the only way to write CAN frames to
>> the ucan core - or is there some sja1000-like mode too?
>>

(..)

> There's one potential fix by setting something like an "ECHO" bit to any
> transmitted frame; The driver rx path will be able to distinguish
> between these "echoed" frames and the - application - "looped back"
> frames, so that the rx stats will be ok.

That would be cool!
I remember discussing about a good echo functionality with Philipp.
Can you also pass some extra data along with the CAN frame down to the 
controller (e.g. to carry an index into the echo skb table?).

Because even when you know that the received frame was echoed, you need 
to got through your saved echo skb list to pick the oldest skb for this 
interface/CAN-ID/mtu combination. This stored skb has to be sent back 
into the system.

Do not create a new skb for echo'ed skbs! See echo skb handling in dev.c

> One question comes to my mind: if I understand well, 'loopback' frames
> are read twice by application: once because of the ECHO mechanism, twice
> because the controller has looped-back it, right?

No.

The application gets normal frames and echo frames only once.
In fact only the originating CAN_RAW socket does not see it's own sent 
traffic unless you set CAN_RAW_RECV_OWN_MSGS socktopt.

To be able to present all other applications (e.g. multiple candump 
instances) the correct traffic on the bus - including the sent traffic 
by getting the echo skbs AND to suppress the echo skbs for the 
originating socket, the reuse of the original tx skbs is needed:

http://lxr.free-electrons.com/source/net/can/raw.c?v=4.8#L126

This checks whether the received (echo) skb has the same sk pointer as 
myself. skbs from 'the outside' do have sk = NULL.

Thanks for searching for an IFF_ECHO capable solution!

Regards,
Oliver

