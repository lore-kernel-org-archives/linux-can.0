From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] 10 CAN interfaces on ECAN-527d
Date: Wed, 23 Nov 2011 19:56:00 +0100
Message-ID: <4ECD41C0.6060706@hartkopp.net>
References: <32872261.post@talk.nabble.com> <4ECCDA12.3080908@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:39136 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1KWS4J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Nov 2011 13:56:09 -0500
In-Reply-To: <4ECCDA12.3080908@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: IreneV <boir1@yandex.ru>, socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 23.11.2011 12:33, Marc Kleine-Budde wrote:

> On 11/23/2011 11:01 AM, IreneV wrote:
>>
>> Hello,
>> I'm a newbie in CAN-interface and I have to write some programs for MicroPC
>> with ECAN-527D board under Ubuntu. After installing drivers from disk 10
>> CAN-interfaces appear in /dev/ and datasheet says that it must be so. Can
>> anyone tell me why there are 10 interface instead of 2 (the board is
>> dual-channel)?
> 
> I don't know the driver, and it's not using the official linux socketcan
> interface. The driver you're using is probably not so well written and
> supports up to 10 CAN interfaces this is why 10 interfaces pop up in /dev.
> 
> About three years ago Alexey Serov[1] (Cc'ed) was using the same board,
> but a socketcan driver. I don't know if the driver is mainline
> meanwhile. I suggest to use the socketcan driver and not the vendor
> specific one.
> 
> cheers, Marc
> 
> [1] http://old.nabble.com/problem-with-82527-PC-104-board-td19020937.html


I think the referenced i82527-iomem driver

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/old/i82527/?#ac21816bb2f78cb7e7b7b1a75f2ecfed0

is *really* very old ... don't know, if it still works.

AFAIK Wolfgang created the CC770 driver which is the successor of the i82527:

http://svn.berlios.de/wsvn/socketcan/trunk/kernel/2.6/drivers/net/can/cc770/?#a12c70fb51cbd498d785ad6d2ee65ff67

This one is more up to date - but only available in the SVN and not in mainline.

Regards,
Oliver
