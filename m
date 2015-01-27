From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 14:02:38 +0100
Message-ID: <54C78C6E.3070705@peak-system.com>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com>
 <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com>
 <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com>
 <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com>
 <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net>
 <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net>
 <54C746AE.60801@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57430 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426AbbA0NCl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 08:02:41 -0500
In-Reply-To: <54C746AE.60801@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi guys,

Le 27/01/2015 09:05, Marc Kleine-Budde a =C3=A9crit :
> On 01/27/2015 09:00 AM, Oliver Hartkopp wrote:
>>>> I assume it is better to set the ctrlmode directly in the struct c=
an_priv
>>>> element in  pcan_usb_fd_init() after retrieving the firmware versi=
on.
>>> Even better.
>>>
>>>> IMO it doesn't make sense to transport this info through the mecha=
nic above
>>>> which mostly initialized quasi constant settings for the adapter.
>>> If we check the firmware version, it doesn't make sende to put the
>>> information into that struct (IMHO)
>> Just to be sure: We stated to have the same opinion here, right?
> Yes, check the firmware version and set ctrlmode directly.
>
>>>> +/* describes the PCAN-USB Pro FD adapter */
>>>> +struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>>>
>>>> be
>>>>
>>>> +/* describes the PCAN-USB Pro FD adapter */
>>>> +const struct peak_usb_adapter pcan_usb_pro_fd =3D {
>>> Yes, but it probably needs some more modifications in the driver.
>> I don't know if this struct is "read-only" all the time.
>> If so it is easy to change.
> I haven't checked but I _think_ it should be possible to make it read
> only everywhere.
>
>> I pity you, Stephane - but we will make it :-))
> :)
>
> Marc

My :) as well as my ACK too...

But putting "const" here leads to several other changes in=20
pcan_usb_core.h and pcan_usb_core.c (as well as in older pcan_usb.c and=
=20
pcan_usb_pro.c files, where same struct peak_adapter static objects are=
=20
used to define the corresponding USB adapter).

Do you need another patch which does this, once for all?

St=C3=A9phane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
