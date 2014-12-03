From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 12:51:15 +0100
Message-ID: <547EF933.5060802@hartkopp.net>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com> <547EE315.40703@hartkopp.net> <547EE827.2080004@peak-system.com> <547EE9CA.8070608@pengutronix.de> <547EEAFA.6050203@hartkopp.net> <547EF1EE.4050409@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:15055 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaLCLvY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 06:51:24 -0500
In-Reply-To: <547EF1EE.4050409@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.12.2014 12:20, Stephane Grosjean wrote:

>> So maybe it makes sense to create a
>>
>>     linux/drivers/net/can/ucan
>>
>> directory where the (new/current?) peak_pci cards with ucan might go in too.
>>
>> The pcan_ucan.h is something like sja1000.h
>>
>
> Yes it is! But what about the new USB devices I'm pushing now? Is it possible
> to #include "pcan_ucan.h" from "usb/peak_usb" if it is stored into "ucan" ???
> AFAIT it isn't without doing dirty things... but I'd like to be wrong...

Yes. That would look ugly.

I wonder if it makes send to leave the drivers in

	drivers/net/can/sja1000
and

	drivers/net/can/usb/peak_usb

as-is and put the new ucan based adapters (usb/pci/ ...) into

	drivers/net/can/ucan

???

Do you assume this to create a code duplication problem for the USB drivers?

@Marc: Any suggestion from you?

Regards,
Oliver
