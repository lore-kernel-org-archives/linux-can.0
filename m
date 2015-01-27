From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 14:25:46 +0100
Message-ID: <54C791DA.3060708@peak-system.com>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com>
 <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com>
 <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com>
 <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com>
 <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net>
 <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net>
 <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com>
 <54C78E4D.9060601@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:40329 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbA0NZt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 08:25:49 -0500
In-Reply-To: <54C78E4D.9060601@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org


Le 27/01/2015 14:10, Oliver Hartkopp a =C3=A9crit :
> Hi Stephane, Marc,
>
> On 27.01.2015 14:02, Stephane Grosjean wrote:
>
>> But putting "const" here leads to several other changes in=20
>> pcan_usb_core.h and
>> pcan_usb_core.c (as well as in older pcan_usb.c and pcan_usb_pro.c=20
>> files,
>> where same struct peak_adapter static objects are used to define the
>> corresponding USB adapter).
>>
>> Do you need another patch which does this, once for all?
>
> I would suggest the following:
>
> 1. Send a new patch set where the CAN_CTRLMODE_FD_NON_ISO is set as=20
> discussed

? AFAIU, the discussion has stopped with:

> Yes, check the firmware version and set ctrlmode directly.

Then, what kind of patch do you want me to send, please?

> 2. Marc: Please put these patches into peak-next branch as it was
> 3. Plan the conversion to constify the struct for 3.21
>
> IMO it makes more sense to make this in the next next-net cycle.

Not clear again, sorry: what do u mean with "this" ? The ISO/NO_ISO=20
stuff or Adding the "const" specifier to all source files with "struct=20
peak_usb_adapter" ???

Regards,

St=C3=A9phane

>
> Regards,
> Oliver
>
Well, to be sure (the e-mail
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
