From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] socketcan in barebox bootloader
Date: Fri, 10 Feb 2012 10:33:41 +0100
Message-ID: <4F34E475.1090408@hartkopp.net>
References: <OF32B6D01B.4E8430B8-ONC125799E.0055E20B-C125799E.00563FFD@o0802.rafi.inhouse> <1328824647.5414.10.camel@slaptop> <4F34DB82.2050603@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:19727 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625Ab2BJJdf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 10 Feb 2012 04:33:35 -0500
In-Reply-To: <4F34DB82.2050603@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Max S." <king@greatfreeworld.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 10.02.2012 09:55, Marc Kleine-Budde wrote:

> Now with linux-can on Cc :)
> 
> On 02/09/2012 10:57 PM, Max S. wrote:
>> CAN is meant for control messages, not for media, or data transfer.
> 
> In the automotive world it's quite common to do firmware updates over CAN.


Hi,

indeed e.g. the ISO 15765-2 protocol is used to segment PDUs up to 4095 byte
into the 8 byte payload of CAN frames.

If you want to play with ISO TP on SocketCAN - it's located here:

https://gitorious.org/linux-can/can-modules/blobs/master/net/can/isotp.c

But then you would need to implement ISO-TP inside the bootloader too.

>> That aside, I do use CAN to flash AVR microchips. It can take a few
>> minutes though.
> 
> What throughput do you usually get when updating over CAN?


I implemented a IP-over-ISOTP tunnel for fun:

https://gitorious.org/linux-can/can-utils/blobs/master/isotptun.c

and taking into account that ISO-TP uses the first byte inside the CAN frame
payload for protocol purposes (1/8 = 12.5% overhead) and the TCP/IP-header of
40 byte within the IP communication i got ~26 kByte/s on a 500kbit/s CAN as
throughput.

Probably that helps to get an impression ;-)

Regards,
Oliver

