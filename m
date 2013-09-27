From: Matt Sealey <neko@bakuhatsu.net>
Subject: Re: imprecise external abort using the flexcan driver on i.MX6Q
Date: Fri, 27 Sep 2013 12:24:38 -0500
Message-ID: <CAHCPf3vJi5HH52XRsJ5tsaOsGk_1YsoSHHgJNPpeJLBpd5EZsA@mail.gmail.com>
References: <21060.15934.600859.167074@ipc1.ka-ro>
	<524455FD.7070808@pengutronix.de>
	<20130926155422.GQ12758@n2100.arm.linux.org.uk>
	<CAHCPf3u7qpdiqoOhD1yxoHybgS1+mvdd8xxaTKnK-DJ9sJYY7g@mail.gmail.com>
	<21061.21191.197931.54061@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:48932 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab3I0RYi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Sep 2013 13:24:38 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2885317pdj.29
        for <linux-can@vger.kernel.org>; Fri, 27 Sep 2013 10:24:38 -0700 (PDT)
In-Reply-To: <21061.21191.197931.54061@ipc1.ka-ro>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 27, 2013 at 4:41 AM, Lothar Wa=DFmann <LW@karo-electronics.=
de> wrote:
> Hi,
>
> Matt Sealey writes:
>> Hi Russel,
>>
>> If r2 is indeed the address of the access, then this is entirely dow=
n
>> to a misuse of the hardware; from the manual:
>>
>> ~
>> When the FEN bit is set in the MCR, the memory area from 0x80 to 0xF=
=46 (which is
>> normally occupied by MB0 to MB7) is used by the reception FIFO engin=
e.
>> Table 34-6
>> shows the Rx FIFO data structure. The region 0x80-0x8F contains an
>> message buffer
>
> What manual are you referring to? In my "i.MX 6Dual/6Quad Application=
s
> Processor Reference Manual, Rev. 1, 04/2013" flexcan is chapter 26 an=
d
> Table 34-6 is: Single-Ended Source Termination Resistance Settings
> of the HDMI interface.

Actually that was from the i.MX53 manual.. it's table 26-7 in the MX6
manual and the description is different, but the hardware operation is
*identical*.

>> I'm surprised this ever worked.. if the area 0x90-0xDF is being used
>> by the FIFO internally then the difference between i.MX53 ('working'=
)
>> and i.MX6Q ('imprecise abort') is that the i.MX6Q is causing the
>> proper bus response. We can only hope that the i.MX53 is ONLY not
>> causing the proper bus response and not actually letting you write
>> into a FIFO internal data area..
>
> This seems a plausible explanation.
>
> The definition:
> |struct flexcan_mb {
> |       u32 can_ctrl;
> |       u32 can_id;
> |       u32 data[2];
> |};
> |
> |/* Structure of the hardware registers */
> |struct flexcan_regs {
> |       u32 mcr;                /* 0x00 */
> [...]
> |       struct flexcan_mb cantxfg[64];
> |                                 ^^
> has obviously nothing to do with reality!

It does, as you found later, reflect reality as it is where the
message buffers 0-5 go when the FIFO is disabled. After that there are
filter registers.. some unions or egregious casting is required, but
the structure is semi-correct.

This is defined in the i.MX6Q manual at least in section 26.4:

~~~
26.4 Message Buffer Structure
Message Buffer Address: Base + 0x0080-0x047C
~~~

But when FEN is set, this is internal FIFO data after entry 0, as
defined in section 26.5:

~~~
26.5 Rx FIFO Structure
When the MCR[RFEN] bit is set, the memory area from $80 to $DC (which
is normally
occupied by MBs 0 to 5) is used by the reception FIFO engine.

The region 0x80-0x8C contains the output of the FIFO which must be
read by the CPU as
a Message Buffer. This output contains the oldest message received and
not read yet. The
region 0x90-0xDC is reserved for internal use of the FIFO engine.
~~~

Marc - I don't think FLEXCAN has changed layout at all in these areas.
The hardware always worked this way..

The only difference here  is that the i.MX53 is doing something weird
on the bus. The i.MX6Q is giving the absolutely correct BRESP for the
transfer to the peripheral (in effect, a "go away, this is my data"
failure, which the CPU turns into an imprecise abort since it no idea
which transaction it committed aeons ago caused it).

Writes to 0x90 to 0xDF while MCR[FEN] is set *should* cause a data
abort.. because it's not even a read-only region, it *should* be
totally inaccessible to the CPU.

The question I have is, when MCR[FEN] is set on i.MX53, does reading
from those reserved registers give anything but 0's or garbage? I'm
curious, that's all, it doesn't really matter ;)

Ta,
Matt <neko@bakuhatsu.net>
