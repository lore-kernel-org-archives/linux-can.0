From: "Mylene Josserand" <Mylene.Josserand@navocap.com>
Subject: Re: [imx27 - mcp251x] MCP251x does not work in static ?
Date: Fri, 12 Apr 2013 11:24:03 +0200
Message-ID: <CA78C307B8F06747967D122FC656B15377446C@SERVEUR0.nvp.local>
References: <CA78C307B8F06747967D122FC656B153774451@SERVEUR0.nvp.local> <51656B9B.80907@pengutronix.de> <CA78C307B8F06747967D122FC656B153774455@SERVEUR0.nvp.local> <5165857D.1050303@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445A@SERVEUR0.nvp.local> <51666B21.10109@pengutronix.de> <CA78C307B8F06747967D122FC656B15377445D@SERVEUR0.nvp.local> <516676B5.6090903@pengutronix.de> <CA78C307B8F06747967D122FC656B153774460@SERVEUR0.nvp.local> <51668741.6030909@pengutronix.de> <CA78C307B8F06747967D122FC656B153774467@SERVEUR0.nvp.local> <5166D231.2040107@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp-155-friday.nerim.net ([194.79.134.155]:48635 "EHLO
	maiev.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753361Ab3DLJYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Apr 2013 05:24:10 -0400
Content-class: urn:content-classes:message
In-Reply-To: <5166D231.2040107@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

Le 11/04/2013 17:09, Marc Kleine-Budde a =E9crit :
> On 04/11/2013 04:39 PM, Mylene Josserand wrote:
>>> Err... don't set IP addresses on CAN interfaces, that's wrong.
>> Yes, I even do not know why I set the IP address !
>
> might be the usual habit of giving network interfaces IP addresses  :=
)

Yes, maybe ;)

>
> [...]
>
>> Bad news for me.
>>
>> I think that your patch works but I have the same error as my first =
post
>> : the CAN / spi is blocked after some frames sent/received.
>>
>> Currently, I use a CAN232 and a small program which send CAN frames
>> through the 232 to the CAN. Then, In the same time, I read the CAN
>> frames sent with "candump can0".
>>
>> I received the good message sent (00 01 02 03 04) :
>>
>> "
>> root@navocap:~# candump can0
>> interface =3D can0, family =3D 29, type =3D 3, proto =3D 1
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> <0x001>  [5] 00 01 02 03 04
>> [...]
>> "
>>
>> I have read 15 383 frames but after 15 834, it hangs. And after that=
, I
>> can not act on the CAN anymore. A "ifconfig can0 down" hangs the ker=
nel
>> (even with ^C) and I have to restart the board to use the CAN again =
!
>
> Ohhh, not good.
>
> Activate "MAGIC_SYSRQ" in the kernel via "make menuconfog" (Kernel
> hacking ->  Magic SysRq key) and bring your system to hang again. The=
n
> connect via serial line to your embedded system and send a "break". (=
See
> documentation of your terminal program.). After the "break" send a
> normal "?" to get the help. If I remember correctly, use "break" +  "=
d"
> to create a stackdump (see
> http://lxr.linux.no/linux+v3.8.6/Documentation/sysrq.txt for more
> documentation). You might want to try the magic sys request if your
> system is still alive to test if your setup is working.
>
> With the stack trace you might figure out what the system is doing.


Oouuhhhaaa ! Very useful ! It did not know the sysrq and it seems to be=
=20
very powerful ! Thanks ! :D


About serious things, the "d" command did not work (it prints the help)=
=20
but the "w" command ["dump tasks that are uninterruptable (blocked)=20
state"] shows interesting things :

---- when not blocked (so nothing in there) :
"
SysRq : Show Blocked State
   task                PC stack   pid father
Sched Debug Version: v0.10, 3.8.2-9-can-modules+ #1
[...]
"

---- when blocked :
"
SysRq : Show Blocked State
   task                PC stack   pid father
kworker/u:0     D c03d6b20     0     6      2 0x00000000
[<c03d6b20>] (__schedule+0x298/0x434) from [<c03d59c8>]=20
(schedule_timeout+0x170/0x1c0)
[<c03d59c8>] (schedule_timeout+0x170/0x1c0) from [<c03d70d4>]=20
(wait_for_common+0x148/0x1a4)
[<c03d70d4>] (wait_for_common+0x148/0x1a4) from [<c0287078>]=20
(spi_imx_transfer+0x70/0x84)
[<c0287078>] (spi_imx_transfer+0x70/0x84) from [<c0285284>]=20
(bitbang_work+0x130/0x390)
[<c0285284>] (bitbang_work+0x130/0x390) from [<c002ee44>]=20
(process_one_work+0x28c/0x504)
[<c002ee44>] (process_one_work+0x28c/0x504) from [<c002f688>]=20
(worker_thread+0x1f0/0x648)
[<c002f688>] (worker_thread+0x1f0/0x648) from [<c0036894>]=20
(kthread+0xa0/0xac)
[<c0036894>] (kthread+0xa0/0xac) from [<c00093b0>] (ret_from_fork+0x14/=
0x24)
irq/201-mcp251x D c03d6b20     0   950      2 0x00000000
[<c03d6b20>] (__schedule+0x298/0x434) from [<c03d59c8>]=20
(schedule_timeout+0x170/0x1c0)
[<c03d59c8>] (schedule_timeout+0x170/0x1c0) from [<c03d70d4>]=20
(wait_for_common+0x148/0x1a4)
[<c03d70d4>] (wait_for_common+0x148/0x1a4) from [<c02839b0>]=20
(__spi_sync+0x58/0x9c)
[<c02839b0>] (__spi_sync+0x58/0x9c) from [<bf08f138>]=20
(mcp251x_spi_trans+0xa4/0xd0 [mcp251x])
[<bf08f138>] (mcp251x_spi_trans+0xa4/0xd0 [mcp251x]) from [<bf090140>]=20
(mcp251x_can_ist+0x60/0x348 [mcp251x])
[<bf090140>] (mcp251x_can_ist+0x60/0x348 [mcp251x]) from [<c005bbf4>]=20
(irq_thread_fn+0x1c/0x34)
[<c005bbf4>] (irq_thread_fn+0x1c/0x34) from [<c005bce4>]=20
(irq_thread+0xd8/0x148)
[<c005bce4>] (irq_thread+0xd8/0x148) from [<c0036894>] (kthread+0xa0/0x=
ac)
[<c0036894>] (kthread+0xa0/0xac) from [<c00093b0>] (ret_from_fork+0x14/=
0x24)
Sched Debug Version: v0.10, 3.8.2-9-can-modules+ #1
[...]
"

We can see that the problem is during the spi transfer.
Do you think it is a hardware problem ?
What is the "kworker" task ?
How fix it ?


>
>> I really think that it is not linked to your patch (do you want me t=
o
>> send the "Tested by" anyway ?) but to my first problem. The kernel
>> update did not seem to fix that.
>> Could you help me to try to fix it ? Because I really do not know ho=
w to
>> debug / fix it.
>> For CAN bus, which is the most CAN chip used ? Do you think that the
>> MCP2515 is a good choice ?
>
> No, mcp2515 is the second worst choice if CAN chips I know, just the
> mcp2510 is worse. If you can change your processor switch to a imx25 =
or
> imx35, they have a CAN controller built-in. If you can redesign your
> hardware, you can add a sja1000 to the external memory interface of t=
he
> imx27. But you need 3.3V ->  5V level shifters, as AFAIK the sja1000 =
is
> only available with 5V io voltage. The easiest option is to add an US=
B
> based CAN adapter to your system. Have a look at the kernel which USB
> adapters are supported.

Thank you for the advice ! I will talk about it with hardware guys and=20
see if we can change it for future design. For USB-CAN, I don't know if=
=20
it is a good idea because, unfortunately, we have many problems with US=
B !


>
> Marc
>

--=20
Myl=E8ne JOSSERAND
Navocap
