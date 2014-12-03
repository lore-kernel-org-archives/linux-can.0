From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can/peak_usb: CAN-FD: add new adapters specific files
Date: Wed, 03 Dec 2014 11:16:53 +0100
Message-ID: <547EE315.40703@hartkopp.net>
References: <5477A5A3.9070107@pengutronix.de> <547DBAEC.6010903@pengutronix.de> <547DD608.5090403@peak-system.com> <547DD81B.9000403@pengutronix.de> <547EDA21.6030802@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:47933 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaLCKRC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 3 Dec 2014 05:17:02 -0500
In-Reply-To: <547EDA21.6030802@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stephane,

when there are defines that are definitely only relevant for one C file=
 these=20
defines should go into this specific C file.

But defines that are (even potentially) relevant for more users should =
go into=20
a .h file, e.g. the ucan defines - or when you have common USB function=
s that=20
are used by PCAN USB and PCAN USB pro.

But definitions that are *only* PCAN USB pro specific should go into=20
pcan_usb_pro.c then.

Regards,
Oliver


On 03.12.2014 10:38, Stephane Grosjean wrote:
> Hi Marc,
>
> Le 02/12/2014 16:17, Marc Kleine-Budde a =C3=A9crit :
>> On 12/02/2014 04:08 PM, Stephane Grosjean wrote:
>>>>>    drivers/net/can/usb/peak_usb/pcan_ucan.h   | 208 +++++++
>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 955
>>>>> +++++++++++++++++++++++++++++
>>>>>    drivers/net/can/usb/peak_usb/pcan_usb_fd.h | 108 ++++
>>>> Please don't create a header file, if it's only included once. Ple=
ase
>>>> merge into the correct .c file.
>>> Ok. So I merge both header files into the .c file. There will be on=
ly a
>>> single (and big) pcan_usb_fd.c file.
>> Yes, we only want code in header files that's used in more than one =
=2Ec file.
>
> Is this rule quite recent? I mean, the current version of peak_usb co=
ntains
> "pcan_usb_pro.h" which is included only by "pcan_usb_pro.c"?
>
> Moreover, "pcan_ucan.h" defines some data structures that might be us=
ed by
> some other new "non USB" PEAK -FD devices (peak_pci, for example).
> So, how to manage to avoid to have to define several times the same d=
ata
> structures and constants, please?
>
> St=C3=A9phane
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt
> Handelsregister Darmstadt HRB 9183 Geschaeftsfuehrung: Alexander Gach=
, Uwe
> Wilhelm
> --
