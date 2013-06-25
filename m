From: "Gerhard Bertelsmann" <info@gerhard-bertelsmann.de>
Subject: Re: AW: Receiving messages issue
Date: Tue, 25 Jun 2013 14:00:11 +0200 (CEST)
Message-ID: <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
Reply-To: info@gerhard-bertelsmann.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.rdts.de ([195.243.153.21]:55024 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751201Ab3FYMX2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Jun 2013 08:23:28 -0400
In-Reply-To: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: Luka Rahne <luka.rahne@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

>> On 06/24/2013 02:26 PM, Luka Rahne wrote:
>> > I am using MCP2515 with  i.MX27
>>
>> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is wor=
se.
>>

IMHO the controller isn't bad - it's the host interface (SPI).
The MCP2515 based capes are using the BB SPI bus. As already stated bef=
ore,
the CAN controller is not read-out fast enough. Root cause of this is m=
ainly
the latency between MCP2515 interrupt and the SPI commands. I have seen
this on different platforms: there are gaps sometimes in the 100usec ra=
nge.
The BBB is fast but there will be still gaps between MCP2515 attention =
needed
and SPI transfers and on heavy loaded links there will be reordered pac=
kets
or packet losts.
One solution could be running the SPI with higher priority. Second one =
would
be to tie SPI and MCP2515 driver together, but this is a quite dirty ha=
ck.

But the Beaglebone-CPU has a nifty thing: the PRUSS - 2x200 MHz CPUs
independantly running from the main CPU. Coupling one or more MCP2515s
to the appropiate pins could be easily served. The PRUSS doesn't have a
hardware SPI interface, but with old school bitbanging you could get  a=
ll
CAN packets even on fully loaded 1MBit link.
There is shared memory region between main and PRUSS CPU. Both CPU
domains could generate an interrupt for the other domain. So the data
could be easily exchanged - without any lost or reordered packets.

BTW: Which structure would be the best for this kind of data transfer ?

Regards

Gerd

Am Di, 25.06.2013, 09:43, schrieb Michael Luxen:
> Hello Marc, hello Luca,
>
> what I can confirm is that I've seen the message lost issue some week=
s ago
> on a Raspberry Pi with MCP2515.
>
> The solution for me was to use the async MCP2515 driver from Andre B.
> Oliveira mentoned by Marc below and furthermore to optimize the SPI
> interface to get less latency here.
> This modifications for the Raspberry Pi are documented here:
> http://www.elinux.org/RPi_CANBus
>
> Whith these modifications I didn't see any message lost at busload ab=
ove
> 50%@500kbit/s!
>
> Currently I'm fighting with the same MCP251x driver on my BeagleBone =
Black
> where I've seen the same message lost problem yesterday. Now, I'm
> compiling a new kernel with the async MCP2515 driver and hopefully I =
can
> get the same good results to get my 3rd/4th CAN-Interface working on =
the
> BeagleBone Black.
>
> Regards
> Mike
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von:	Marc Kleine-Budde <mkl@pengutronix.de>
> Gesendet:	Mo 24.06.2013 15:42
> Betreff:	Re: Receiving messages issue
> Anlage:	signature.asc
> An:	Luka Rahne <luka.rahne@gmail.com>;
> CC:	linux-can@vger.kernel.org;
>> On 06/24/2013 02:26 PM, Luka Rahne wrote:
>> > I am using MCP2515 with  i.MX27
>>
>> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is wor=
se.
>>
>> You can try Andre B. Oliveira's async mcp2515 driver. It's here:
>>
>> http://git.pengutronix.de/?p=3Dmkl/linux.git;a=3Dshortlog;h=3Drefs/h=
eads/can/mcp2515-a
>> sync
>>
>> regards,
>> Marc
>> --
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

