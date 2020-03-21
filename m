From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: Need help in interpreting ip status output
Date: Sat, 21 Mar 2020 16:19:39 +0100
Message-ID: <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:45859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgCUPTk (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 21 Mar 2020 11:19:40 -0400
In-Reply-To: <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Alex Blasche <alexander.blasche@qt.io>

Hi Oliver,

thanks for your answer. I hope you are well.

> Hi Andr=C3=A9,
>
> I have an idea ;-)
>
> On 12/03/2020 18.43, Andr=C3=A9 Hartmann wrote:
>
>>> can someone help me interpreting the following ip output:
>>>
>>> ip -s link show can1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: can1: <NOARP,UP,LOWER_UP,ECHO> mtu 1=
6 qdisc pfifo_fast state
>>> UNKNOWN mode DEFAULT group default qlen 100
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 link/can
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: bytes=C2=A0=
 packets=C2=A0 errors=C2=A0 dropped overrun mcast
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9987413=C2=A0 1=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 74=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: bytes=C2=A0=
 packets=C2=A0 errors=C2=A0 dropped carrier collsns
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>
>>> I'm especially interested in the meaning of the
>>>
>>> * 1 errors
>>> * 74 dropped
>>> * 1 overrun
>
> E.g. if you look into
> linux/drivers/net/can/sja1000/sja1000.c
> you can see that an overrun error also triggers the error counter to
> increase - that's why both are set to 1.
>
> The reason for the overrun error is a notification from the CAN
> controller itself. It tells us that the received CAN frame has not been
> read from the controller until the next CAN frame arrived.

Ok, that's what I thought too, thanks for the confirmation.

> The dropped counter usually indicates that the CAN driver did not get a
> skbuff data structure (e.g. out of memory condition).
>
> This is NOT good. What CAN hardware/setup are you using?

Actually it's not my system. The report is from a customer doing a full
load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610

I guess the customer should try a more recent Kernel than 4.14 first?

Thanks, and best regards,
Andr=C3=A9

>
> Regards,
> Oliver
