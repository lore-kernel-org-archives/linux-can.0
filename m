From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH v2 2/2] Allwinner SoC CAN controller Support
Date: Thu, 10 Sep 2015 10:29:40 +0200
Message-ID: <CAJ=nTstAWKjszZMyGJVXPn0bJqF1mn6HGHu8L_tpwsmrGXazTg@mail.gmail.com>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
	<1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
	<55EEBDC4.8050800@pengutronix.de>
	<19003c5e5894dc0d656490cd17be1bcb@mail.rdts.de>
	<55F13CB7.6050603@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33840 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbIJI3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 04:29:42 -0400
Received: by laeb10 with SMTP id b10so23319634lae.1
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2015 01:29:40 -0700 (PDT)
In-Reply-To: <55F13CB7.6050603@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2015-09-10 10:17 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:
> On 09/10/2015 08:29 AM, Gerhard Bertelsmann wrote:
>>>> +
>>>> +static struct platform_driver sunxi_can_driver =3D {
>>>> +   .driver =3D {
>>>> +              .name =3D DRV_NAME,
>>>
>>> Please remove the .name.
>>
>> Without it, the kernel oops
>
> Doh! But there was one assignment here, that was not needed...I'll tr=
y
> to remember which one it was.
>

I believe

    .owner =3D THIS_MODULE,

is not needed.


--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
