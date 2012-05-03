From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support
Date: Thu, 03 May 2012 15:13:54 +0200
Message-ID: <4FA28492.7010704@hartkopp.net>
References: <4FA2689D.5030905@hartkopp.net> <4FA26D28.80307@grandegger.com> <4FA26F65.5020804@hartkopp.net> <4FA275C1.4080905@grandegger.com> <20120503121833.GC416@vandijck-laurijssen.be> <4FA27C3C.8010806@hartkopp.net> <4FA27D88.8040401@grandegger.com> <20120503130041.GA2846@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:19072 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab2ECNN6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 09:13:58 -0400
In-Reply-To: <20120503130041.GA2846@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 15:00, Kurt Van Dijck wrote:

>>
>> Furthermore, the user should be allowed to specify *any* lenght below
>> max, als 57 bytes. It's than up to the driver to do the necessary padding.
> I think Oliver solved this (on af_can level?) with a table len2dlc (static in the header?)


Yes - it was the only way not to make it clash when linking proc.o and
af_can.o together.

Btw. if we move this functionality to the driver, i would like to move it from
can.h into dev.c :-)

> 
>>
>>>
>>> What about this binary compatible introduction of cf->len ...
>>
>> Looks good.
> Yep, given 2 structs, this illustrates the contents very well!


Fine.

One question:

What about omitting the union in struct can_frame modification and leave it as
it is since the first days of SocketCAN?

We can still check these offsets

 	BUILD_BUG_ON(offsetof(struct can_frame, can_dlc) !=
-		     offsetof(struct canfd_frame, can_dlc));
+		     offsetof(struct canfd_frame, len));


and can (kernel) internally use struct canfd_frame as reference:

	struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
	struct net_device_stats *stats = &dev->stats;

	stats->rx_packets++;
	stats->rx_bytes += cfd->len;

which would cover cf->can_dlc in the same way.

I wonder, if people would start to use can_frame.len once it is defined as
this would not be backward compatible code (but binary compatible).

Regards,
Oliver
