From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: mcp251x: add some messages to mcp251x_can_probe()
Date: Sat, 18 Jun 2016 10:41:40 +0200
Message-ID: <57650944.5090509@hartkopp.net>
References: <1464487156-20858-1-git-send-email-edo.rus@gmail.com>
 <9e944b22-b63b-dc72-c060-b2c21f124569@pengutronix.de>
 <CACm0Nn3L0fqtRMNJCJrPhnrM0JRaEn+g=3i5CSMvRLkKEAjkJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:22071 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcFRIlv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Jun 2016 04:41:51 -0400
In-Reply-To: <CACm0Nn3L0fqtRMNJCJrPhnrM0JRaEn+g=3i5CSMvRLkKEAjkJQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ed Spiridonov <edo.rus@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hello Marc,

On 06/17/2016 10:41 PM, Ed Spiridonov wrote:
> 17.06.2016 12:22 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8C "Marc Kleine-Budde" <mkl@pengutronix.de> =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>
>>> @@ -1156,6 +1158,8 @@ static int mcp251x_can_probe(struct spi_devic=
e *spi)
>>>
>>>        devm_can_led_init(net);
>>>
>>> +     netdev_info(net, "successfully initialized.\n");
>>
>> I'll remove this hunk, as we try to make the CAN devices as silent a=
s
>> possible in case of no errors.

I agree with Ed in this special case.

In opposite to CAN interfaces that reside on local busses or inside of=20
SoCs the mcp251x is attached indirectly via SPI. This adds additional=20
options to fail at initialization time.

As USB interfaces also tell about the USB plug-in and about their=20
successful netdev initialization - the SPI based interfaces should be=20
able to do it similarly.

Even the mcp251x stuff is not a very high performance CAN interface=20
implementation many RasPi users do their first steps with SocketCAN=20
using this tricky hardware setup.

That's why I vote for more information at initialization time too.

Regards,
Oliver

>
>
> Why it is so important to be totally silent? IMHO one line per CAN bu=
s
> isn't too much.
> But it could help to debug new configuration, e.g. to find wrong
> device tree configuration, especially with several CAN buses.
>
> I made this patch because a lot of complains on Raspberry PI forum.
> Current module does not produce any message if module initializes
> MCP2510/2515 chip successfully or not. It could be confusing.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
