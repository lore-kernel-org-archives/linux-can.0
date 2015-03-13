From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: LEDs: documentation
Date: Fri, 13 Mar 2015 11:46:21 +0100
Message-ID: <CAJ=nTstKBGbtANO=NQ0Y9_gd2Kgf=Ohpy33omapM71ssXOq9KQ@mail.gmail.com>
References: <CAGm1_ktxocqFvQQ9Mrnk+ravrgpq-+RWw3vN0qsS=Qpa+o3WGA@mail.gmail.com>
	<CAJ=nTssN6M13-aiAHA=jY7EhGsRbYqrFDoTb-o43YFYtndgb1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45132 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963AbbCMKqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 13 Mar 2015 06:46:22 -0400
Received: by lamq1 with SMTP id q1so21649598lam.12
        for <linux-can@vger.kernel.org>; Fri, 13 Mar 2015 03:46:21 -0700 (PDT)
In-Reply-To: <CAJ=nTssN6M13-aiAHA=jY7EhGsRbYqrFDoTb-o43YFYtndgb1A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, fabio.baltieri@gmail.com

And also take a look at CONFIG_CAN_LEDS.

2015-03-13 11:39 GMT+01:00 Mirza Krak <mirza.krak@hostmobility.com>:
> See Documentation/leds/leds-class.
>
> You can use a CAN device as a led trigger.
>
> There is no such thing as a CAN LEDs subsystem.
>
> 2015-03-12 10:21 GMT+01:00 Yegor Yefremov <yegorslists@googlemail.com=
>:
>>
>> I have am335x based system and would like to use LED feature. Where
>> can I find info about CAN LEDs subsystem? How can I configure LEDs v=
ia
>> device tree?
>>
>> So far I couldn't find anything related under
>> Documentation/devicetree/bindings/net/can/ or in
>> Documentation/networking/can.txt.
>>
>> Yegor
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Med V=C3=A4nliga H=C3=A4lsningar / Best Regards
>
> *******************************************************************
> Mirza Krak
> Host Mobility AB
> mirza.krak@hostmobility.com
> Anders Personsgatan 12, 416 64 G=C3=B6teborg
> Sweden
> http://www.hostmobility.com
> Direct: +46 31 31 32 704
> Phone: +46 31 31 32 700
> Fax: +46 31 80 67 51
> Mobile: +46 730 28 06 22
> *******************************************************************
>



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
