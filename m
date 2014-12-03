From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 14:18:51 +0100
Message-ID: <547F0DBB.3080200@peak-system.com>
References: <5477A5A3.9070107@pengutronix.de>
 <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com>
 <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com>
 <547EE315.40703@hartkopp.net> <547EE827.2080004@peak-system.com>
 <547EE9CA.8070608@pengutronix.de> <547EEAFA.6050203@hartkopp.net>
 <547EF1EE.4050409@peak-system.com> <547EF933.5060802@hartkopp.net>
 <547F033A.4050109@peak-system.com> <547F08BF.5060307@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57723 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaLCNS4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 08:18:56 -0500
In-Reply-To: <547F08BF.5060307@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


Le 03/12/2014 13:57, Oliver Hartkopp a =C3=A9crit :
> Then I would suggest to stay in the layout of the current patch set=20
> (with pcan_ucan.h in drivers/usb/peak_usb) and discuss about a generi=
c=20
> approach when some other ucan-based devices (e.g. pci) appear ...
>
> ?!?
>

Ok, I agree with you. And I move the content of "pcan_usb_fd.h" into=20
"pcan_usb_fd.c".

Regards,

St=C3=A9phane

> Regards,
> Oliver
>
> On 03.12.2014 13:34, Stephane Grosjean wrote:
>>
>> Le 03/12/2014 12:51, Oliver Hartkopp a =C3=A9crit :
>>> On 03.12.2014 12:20, Stephane Grosjean wrote:
>>>
>>>>> So maybe it makes sense to create a
>>>>>
>>>>>     linux/drivers/net/can/ucan
>>>>>
>>>>> directory where the (new/current?) peak_pci cards with ucan might=
=20
>>>>> go in too.
>>>>>
>>>>> The pcan_ucan.h is something like sja1000.h
>>>>>
>>>>
>>>> Yes it is! But what about the new USB devices I'm pushing now? Is=20
>>>> it possible
>>>> to #include "pcan_ucan.h" from "usb/peak_usb" if it is stored into=
=20
>>>> "ucan" ???
>>>> AFAIT it isn't without doing dirty things... but I'd like to be=20
>>>> wrong...
>>>
>>> Yes. That would look ugly.
>>>
>>> I wonder if it makes send to leave the drivers in
>>>
>>>     drivers/net/can/sja1000
>>> and
>>>
>>>     drivers/net/can/usb/peak_usb
>>>
>>> as-is and put the new ucan based adapters (usb/pci/ ...) into
>>>
>>>     drivers/net/can/ucan
>>>
>>> ???
>>>
>>> Do you assume this to create a code duplication problem for the USB=
=20
>>> drivers?
>>
>> Arf I'm afraid it would... I managed to create a "peak usb core" to=20
>> minimize
>> code duplication, with device specific files around, so that it woul=
d be
>> easier to add any new usb devices. In fact it was. Until "ucan" came=
=20
>> into the
>> story...
>>
>>>
>>> @Marc: Any suggestion from you?
>>>
>>> Regards,
>>> Oliver
>>
>> --=20
>> PEAK-System Technik GmbH
>> Sitz der Gesellschaft Darmstadt
>> Handelsregister Darmstadt HRB 9183 Geschaeftsfuehrung: Alexander=20
>> Gach, Uwe
>> Wilhelm
>> --=20

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
