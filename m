From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SJA1000 loopback feature
Date: Thu, 19 Jun 2014 19:43:15 +0200
Message-ID: <53A32133.7050300@hartkopp.net>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>	<539F3DDF.70007@hartkopp.net>	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>	<20140617161347.25cb639e@snail>	<53A1EDA7.7040504@hartkopp.net>	<20140619164424.244e5634@snail>	<53A2F9EC.4060107@hartkopp.net> <20140619200110.7427bdfe@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:49590 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295AbaFSRnZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 13:43:25 -0400
In-Reply-To: <20140619200110.7427bdfe@snail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>, linux-can@vger.kernel.org



On 19.06.2014 18:01, Alexander GQ Gerasiov wrote:
> Thu, 19 Jun 2014 16:55:40 +0200
> Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> 
>>>> Just to give an example how I dealed with such situation:
>>>>
>>>> 1. Let all applications run on a virtual CAN interface (e.g.
>>>> vcan0). 2. make a cross routing with can-gw netlink routes
>>>
>>> Yes, I was thinking about it. We strictly need the same order of
>>> events on both buses (local/virtual and remote/hardware), but in
>>> case of bridging (userspace, or even in-kernel one) race is
>>> possible. So we'd better use one bus (to rule them all =)) 
>>>
>>
>> You have a strict order on vcan0. And this order is then transfered
>> to the real can0. OTOH the order on can0 is forwarded to vcan0. Where
>> do you see a problem here?
> Correct me if I'm wrong, but if I'm quite sure, there will be the
> following problem:
> 
> Application works on vcan and initiate transmit A on time T.
> Another (hardware) node initiate transmit B on physical bus on the same
> T.

So your hosts are absolutely synchronized (via ntp)??

> 
> On vcan you will see A (on T+dt1), B (on T+dt1+dt2).

How do you get the timestamp information then?
E.g. you can configute the routing rule with '-t' option to preserve the
src_dev rx timestamp. You would see the timestamp from the real CAN tnen.

> On bus you will see B (on T+dt3), A (on T+dt3+dt4).

Hm - i wonder if you would really see a difference as the networking stack is
not real-time anyway. When sending on vcan (which has no receive queue) the rx
is performed instantly which leads to en-queue the frame into the real CAN
interface immediately.

> 
> As we develop testbench environment, the order of events our software
> see (and logs) should be the same as hardware nodes see.
> 

Looks interesting. Your experiences are welcome :-)

Regards,
Oliver
