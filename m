From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SJA1000 loopback feature
Date: Wed, 18 Jun 2014 21:51:03 +0200
Message-ID: <53A1EDA7.7040504@hartkopp.net>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>	<539F3DDF.70007@hartkopp.net>	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com> <20140617161347.25cb639e@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:60874 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbaFRTvG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jun 2014 15:51:06 -0400
In-Reply-To: <20140617161347.25cb639e@snail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>, Nikita Edward Baruzdin <nebaruzdin@gmail.com>
Cc: linux-can@vger.kernel.org

Hello Alexander,

On 17.06.2014 14:13, Alexander GQ Gerasiov wrote:
> Tue, 17 Jun 2014 15:41:14 +0400
> Nikita Edward Baruzdin <nebaruzdin@gmail.com> wrote:
> 
>>
>> You see, we, for instance, don't really need hardware loopback for
>> our case. What we need is to have software loopback working. And for
>> that STM is necessary. If we enable SRR feature as well, we'll have
>> each message loopbacked twice: once by software
>> (can_{put|get}_echo_skb() functions) and once by hardware (message in
>> controller's RX buffer). Thus we'll probably have to disable the
>> software loopback per socket (CAN_RAW_LOOPBACK option) which is not
>> really convenient.
> 
> Just to clarify situation, Nikita is working on distributed system,
> where N components are working on M physical hosts (N >> M) and should
> be able to intercommunicate with each other via can bus even if M==1.
> In such case, ACKs are absent on the bus, but frames are transmited
> between several components within one host.
> 
> So we want to be able to tune CAN subsystem to ignore ACK absence.
> As we understand, SJA1000 has the mode we are looking for (but lacks
> support in driver/subsystem).

If we would find a name for it, it could be:

#define CAN_CTRLMODE_PRESUME_ACK        0x40    /* ignore missing CAN ACKs */

> 
> As LOOPBACK option for interface means that TX should be passed to RX,
> thats not exactly what we need. (As for loopback we already have it
> on the socket with CAN_RAW_LOOPBACK and CAN_RAW_RECV_OWN_MSGS.) I think
> we could add one more interface mode "ignore-no-ack", but we'd like to
> stay as much closer to vanilla kernel as possible and contribute our
> modifications, so we need your opinion on
> 
> Is this the common situation? Do you interested in such mode and our
> modifications? How should we realize thees modifications?
> 

Just to give an example how I dealed with such situation:

1. Let all applications run on a virtual CAN interface (e.g. vcan0).
2. make a cross routing with can-gw netlink routes

E.g.
cangw -s vcan0 -d can0 -e
cangw -s can0 -d vcan0 -e

The cross routing can be done with netlink socket configuration (without using
the cangw tool). In any case the applications run in a stable CAN environment
on the virtual CAN interface. And when there's traffic on can0 it is forwarded
to vcan0 and vice versa.

Regards,
Oliver
