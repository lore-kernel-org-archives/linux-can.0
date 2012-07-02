From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Mon, 2 Jul 2012 10:55:55 +0800
Message-ID: <4FF10DBB.1020106@gmail.com>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>	<1340853701-4488-3-git-send-email-shawn.guo@linaro.org>	<4FEC329C.7070004@pengutronix.de>	<20120628112111.GC22990@S2101-09.ap.freescale.net>	<4FEC400F.8010506@pengutronix.de>	<20120628114108.GD22990@S2101-09.ap.freescale.net>	<20460.18717.17688.965250@ipc1.ka-ro>	<20120628121302.GI22990@S2101-09.ap.freescale.net> <20460.19712.158996.397146@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:43345 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab2GBC4g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 22:56:36 -0400
In-Reply-To: <20460.19712.158996.397146@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

Lothar Wa=C3=9Fmann wrote:
> Hi,
>
> Shawn Guo writes:
>  =20
>> On Thu, Jun 28, 2012 at 02:07:57PM +0200, Lothar Wa=C3=9Fmann wrote:
>>    =20
>>> Hi,
>>>
>>> Shawn Guo writes:
>>>      =20
>>>> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
>>>>        =20
>>>>> I mean which name is more precise, do these gpio enable/standy a =
"phy"
>>>>> or a "transceiver". For example:
>>>>> http://www.nxp.com/documents/application_note/AN00094.pdf, this d=
ocument
>>>>> says: TJA1041/1041A high speed CAN transceiver.
>>>>>
>>>>>          =20
>>>> Isn't term "phy" (physical interface) generally meant to be the sa=
me
>>>> thing as "transceiver"?  I just happened to like the shorter one a=
s
>>>> what Hui did in his patch.
>>>>
>>>> But it does not really matter to me, will change the name since yo=
u
>>>> care about it.
>>>>
>>>>        =20
>>> A transceiver is just a dumb piece of hardware, while a PHY contain=
s
>>> some intelligence of its own.
>>>
>>>      =20
>> Then, it sounds more like a PHY than transceiver, since it's an IC
>> chip with some control over it.
>>
>>    =20
> The 'I' in 'IC' does not stand for 'intelligent', but for
> 'integrated'. ;)
> A can transceiver is usually merely a switchable buffer. There are no
> registers to configure it or an internal processor that does some
> magic.
>
>  =20
Sorry for reply late, in my first patch, i chose "phy" instead of "xcvr=
"=20
because the MC33902 datasheet tell me it is a "high speed CAN physical=20
interface", and it includes "an internal 5.0 V supply for the CAN bus=20
transceiver".

And from the diagram in the page 1 of the MC33902 datasheet, the MC3390=
2=20
includes bus xcvr, i/o control logic, power supply and external=20
regulator control logic. As a result i decided to use phy in the driver=
=2E

Regards,
Hui.
> Lothar Wa=C3=9Fmann
>  =20

