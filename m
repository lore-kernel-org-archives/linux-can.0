From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SJA1000 loopback feature
Date: Thu, 19 Jun 2014 16:55:40 +0200
Message-ID: <53A2F9EC.4060107@hartkopp.net>
References: <CAEJ7JO2ejHBVANYWXxXe_DstXCW-hm9xzJYXifiU+RwYNS3M1A@mail.gmail.com>	<539F3DDF.70007@hartkopp.net>	<CAEJ7JO1a_5Z2yKYDw30XjXh3qt4Qr-yRUVMUkz9s3MRv=zLWhA@mail.gmail.com>	<20140617161347.25cb639e@snail>	<53A1EDA7.7040504@hartkopp.net> <20140619164424.244e5634@snail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:30134 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490AbaFSOzn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 19 Jun 2014 10:55:43 -0400
In-Reply-To: <20140619164424.244e5634@snail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander GQ Gerasiov <gq@cs.msu.su>, linux-can@vger.kernel.org

On 19.06.2014 14:44, Alexander GQ Gerasiov wrote:

> Ok, what is the right git repository for linux-can kernel modules?
> I can see
> linux-can/can-modules
> linux-can/linux-can
> linux-can/linux-can-next

As it is a new feature linux-can/linux-can-next would be the right tree to
reference. According the CAN stuff it should be in sync with
http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git
which is the next step in the upstream process.


>>
>> Just to give an example how I dealed with such situation:
>>
>> 1. Let all applications run on a virtual CAN interface (e.g. vcan0).
>> 2. make a cross routing with can-gw netlink routes
> 
> Yes, I was thinking about it. We strictly need the same order of
> events on both buses (local/virtual and remote/hardware), but in case of
> bridging (userspace, or even in-kernel one) race is possible. So we'd
> better use one bus (to rule them all =)) 
> 

You have a strict order on vcan0. And this order is then transfered to the
real can0. OTOH the order on can0 is forwarded to vcan0. Where do you see a
problem here?

As your application does not use both CAN interfaces (vcan0/can0) at the same
time there should be no reordering when looking only at vcan0.

Due to the forwarding inside the same net-rx softirq you would no even notice
a delay.

Regards,
Oliver
