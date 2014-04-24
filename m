From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: (Case 14359) Kvaser socketCAN support
Date: Thu, 24 Apr 2014 14:01:03 +0200
Message-ID: <5358FCFF.9020604@hartkopp.net>
References: <CAGm1_ks40c8SGE+BuokShMmOXkGk0PO4MF67N+jhYh+DBWnp6w@mail.gmail.com> <5357e7f5.c72de00a.4ba2.40ff@mx.google.com> <CAGm1_kuo9J1_0nPew_urkF-jh6Y0J0oFaW9QVZe4k4T0KqcVkg@mail.gmail.com> <5358D731.9000908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:35734 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbaDXMBK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 24 Apr 2014 08:01:10 -0400
In-Reply-To: <5358D731.9000908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>, Kvaser Support <support@kvaser.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>



On 24.04.2014 11:19, Marc Kleine-Budde wrote:
> On 04/24/2014 09:46 AM, Yegor Yefremov wrote:
>> What about making a table with following columns:
>>
>> 1. driver module name
>> 2. supported devices
>> 3. kernel version, where all these devices are supported
>>
>> *alternative variant*
>>
>> 1. device name
>> 2. related driver module name
>> 3. kernel version
> 
> ^^^ I think this is the most useful variant.

Yep!

If possible I would like to add the Vendor too:

1. Vendor (with URL to the Vendor)
2. device name  (with URL to the Product if possible)
3. related driver module name
4. Kconfig option: CONFIG_CAN CONFIG_CAN_DEV CONFIG_SJA1000 CONFIG_EMS_PCMCIA
5. since kernel version (or "out-of-tree")
6. Remarks

Point 4. might probably be too much ...

As elinux.org uses the same Wiki system, i would suggest to
have a sorted table to be able to sort by Vendor / device name / Kernel version

See:
http://en.wikipedia.org/wiki/Help:Table#Sorting_and_collapsing

Btw. the DE example looks better
http://de.wikipedia.org/wiki/Hilfe:Tabellen#Sortierbare_Tabelle

Regards,
Oliver

ps. My account creation at elinux.org still waits for approval ...

