From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 7/7 v9] can/peak_usb: add support for PEAK new CANFD USB
 adapters
Date: Tue, 27 Jan 2015 15:27:03 +0100
Message-ID: <54C7A037.6080100@hartkopp.net>
References: <1422009085-11858-1-git-send-email-s.grosjean@peak-system.com> <1422009085-11858-8-git-send-email-s.grosjean@peak-system.com> <54C64633.9080204@pengutronix.de> <54C65912.5020309@peak-system.com> <54C659C0.4040207@pengutronix.de> <54C66063.9050500@peak-system.com> <54C6628D.7010902@pengutronix.de> <54C6ABE1.8000504@hartkopp.net> <54C6ACBD.2020806@pengutronix.de> <54C74589.9050603@hartkopp.net> <54C746AE.60801@pengutronix.de> <54C78C6E.3070705@peak-system.com> <54C78E4D.9060601@hartkopp.net> <54C791DA.3060708@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:22769 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758279AbbA0O1S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 09:27:18 -0500
In-Reply-To: <54C791DA.3060708@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org



On 27.01.2015 14:25, Stephane Grosjean wrote:
>
> Le 27/01/2015 14:10, Oliver Hartkopp a =C3=A9crit :
>> Hi Stephane, Marc,
>>
>> On 27.01.2015 14:02, Stephane Grosjean wrote:
>>
>>> But putting "const" here leads to several other changes in pcan_usb=
_core.h and
>>> pcan_usb_core.c (as well as in older pcan_usb.c and pcan_usb_pro.c =
files,
>>> where same struct peak_adapter static objects are used to define th=
e
>>> corresponding USB adapter).
>>>
>>> Do you need another patch which does this, once for all?
>>
>> I would suggest the following:
>>
>> 1. Send a new patch set where the CAN_CTRLMODE_FD_NON_ISO is set as =
discussed
>
> ? AFAIU, the discussion has stopped with:
>
>> Yes, check the firmware version and set ctrlmode directly.


As there is no firmware version to check against right now:

In pcan_usb_fd_init() just set

pdev->dev.can.ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO;

Right before the comment '/* tell the hardware ...'

Here:
http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/tree=
/drivers/net/can/usb/peak_usb/pcan_usb_fd.c?h=3Dpeak-next#n861

That's all for the v10 patchset IMO.

>
> Then, what kind of patch do you want me to send, please?
>
>> 2. Marc: Please put these patches into peak-next branch as it was
>> 3. Plan the conversion to constify the struct for 3.21
>>
>> IMO it makes more sense to make this in the next next-net cycle.
>
> Not clear again, sorry: what do u mean with "this" ? The ISO/NO_ISO s=
tuff or
> Adding the "const" specifier to all source files with "struct
> peak_usb_adapter" ???

Setting

pdev->dev.can.ctrlmode =3D CAN_CTRLMODE_FD_NON_ISO;

is mandatory.

But constify the struct peak_usb_adapter can be done later.

ok?

Regards,
Oliver

ps. I hope pdev->dev.can.ctrlmode is valid in pcan_usb_fd_init() ?!?
