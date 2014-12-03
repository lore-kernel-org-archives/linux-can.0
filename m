From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 11:50:34 +0100
Message-ID: <547EEAFA.6050203@hartkopp.net>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com> <547EE315.40703@hartkopp.net> <547EE827.2080004@peak-system.com> <547EE9CA.8070608@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:9880 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaLCKun (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:50:43 -0500
In-Reply-To: <547EE9CA.8070608@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.12.2014 11:45, Marc Kleine-Budde wrote:
> On 12/03/2014 11:38 AM, Stephane Grosjean wrote:


>> - pcan_ucan.h defines some data structs and constants that will be
>> common across different kinds of CAN-FD hardwares. How should I include
>> this "pcan_ucan.h" file from a future (for example) PCI CAN-FD driver
>> (which, obvioulsy) won't be stored  under "usb/peak_usb" directory).
>
> If it's CAN-FD relevant than it will go under include/linux/can/ somewhere.

Hm - AFAICS it's not a CAN FD specific thing but these definitions belog to 
the ucan controller IP - similar to a M_CAN or C_CAN controller.

So maybe it makes sense to create a

	linux/drivers/net/can/ucan

directory where the (new/current?) peak_pci cards with ucan might go in too.

The pcan_ucan.h is something like sja1000.h

Regards,
Oliver
