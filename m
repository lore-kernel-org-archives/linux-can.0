From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 11:38:31 +0100
Message-ID: <547EE827.2080004@peak-system.com>
References: <5477A5A3.9070107@pengutronix.de>
 <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com>
 <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com>
 <547EE315.40703@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:35778 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbaLCKis (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:38:48 -0500
In-Reply-To: <547EE315.40703@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Le 03/12/2014 11:16, Oliver Hartkopp a =C3=A9crit :
> Hi Stephane,
>
> when there are defines that are definitely only relevant for one C=20
> file these defines should go into this specific C file.
>
> But defines that are (even potentially) relevant for more users shoul=
d=20
> go into a .h file, e.g. the ucan defines - or when you have common US=
B=20
> functions that are used by PCAN USB and PCAN USB pro.
>
> But definitions that are *only* PCAN USB pro specific should go into=20
> pcan_usb_pro.c then.

Well I know that. My remark was about two points:

- the *kernel 3.4* version of pcan_usb_pro.h defines some data struct=20
and constants that are *only* used by pcan_usb_pro.c (see "struct=20
pcan_usb_pro_fwinfo", for example). Since it has been acked in the=20
mainline in these early times, I simply asked if and when this rule did=
=20
evolve? Underlying question: what to do now? Should I (also) post=20
patches to setup things right between pcan_usb_pro.c and pcan_usb_pro.h=
,=20
in order to define (for ex) "struct pcan_usb_pro_fwinfo" in=20
pcan_usb_pro.c instead? Or do we let things "as is"?

- pcan_ucan.h defines some data structs and constants that will be=20
common across different kinds of CAN-FD hardwares. How should I include=
=20
this "pcan_ucan.h" file from a future (for example) PCI CAN-FD driver=20
(which, obvioulsy) won't be stored  under "usb/peak_usb" directory).

Regards,

St=C3=A9phane
>
> Regards,
> Oliver
>
>
> On 03.12.2014 10:38, Stephane Grosjean wrote:
>> Hi Marc,
>>
>> Le 02/12/2014 16:17, Marc Kleine-Budde a =C3=A9crit :
>>> On 12/02/2014 04:08 PM, Stephane Grosjean wrote:
>>>>>> drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955
>>>>>> +++++++++++++++++++++++++++++
>>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
>>>>> Please don't create a header file, if it's only included once. Pl=
ease
>>>>> merge into the correct .c file.
>>>> Ok. So I merge both header files into the .c file. There will be=20
>>>> only a
>>>> single (and big) pcan_usb_fd.c file.
>>> Yes, we only want code in header files that's used in more than one=
=20
>>> .c file.
>>
>> Is this rule quite recent? I mean, the current version of peak_usb=20
>> contains
>> "pcan_usb_pro.h" which is included only by "pcan_usb_pro.c"?
>>
>> Moreover, "pcan_ucan.h" defines some data structures that might be=20
>> used by
>> some other new "non USB" PEAK -FD devices (peak_pci, for example).
>> So, how to manage to avoid to have to define several times the same =
data
>> structures and constants, please?
>>
>> St=C3=A9phane
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
