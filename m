From: =?UTF-8?B?RnJhbsOnb2lzIEJlYXVsaWVy?= <fbeaulier@orange.fr>
Subject: Re: Linux board with 10 CANs
Date: Mon, 18 May 2015 11:25:10 +0200
Message-ID: <5559AFF6.3040509@orange.fr>
References: <5555A6A3.7090206@orange.fr> <55560FA4.4090300@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:55521 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbERJZM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 May 2015 05:25:12 -0400
In-Reply-To: <55560FA4.4090300@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, linux-can@vger.kernel.org

Hi Tom,

=46reescale MPC574X chips are MCUs, you can't run Linux on them.
Vybrid SOCs have 2 CANs max.
I know the MCP2515 may work in some situation but it depends on kernel=20
latency and that is very unpredictable.
What is helping in QSPI ? the main problem beeing latency between MCP=20
irq and effective SPI transfer ?

=46rancois


Le 15/05/2015 17:24, Tom Evans a =C3=A9crit :
> On 15/05/2015 5:56 PM, Fran=C3=A7ois Beaulier wrote:
>> Hi,
>>
>> I'm starting the design of a CPU board, based on a computer on modul=
e
>> with a very common SOC like i.mx6 or am335x.
>
> There are SOCs with 8 CAN ports built in, like the Freescale MPC574X=20
> chips. That should be a lot easier to work with, and should be=20
> supported without any extra drivers.
>
> The following Selector Guide tells me the Vybrid SVFxxxR has *FIFTY*=20
> CAN ports. That may have multiple typos, as Freescale's web site=20
> doesn't admit to that part.
>
> http://cache.freescale.com/files/microcontrollers/doc/roadmap/BRAUTOP=
RDCTMAP.pdf=20
>
>
>> CAN bitrate needed is quite low (50kbps)
>
> So at about 110 bits for a minimum sized Standard ID packet, that=20
> gives you 450 messages/second max. That gives you a maximum service=20
> latency of 2.2ms for as many buffers as the chip has. If your data ha=
s=20
> 8 bytes/packet then that drops to 3.5ms/buffer (7ms for a chip with 2=
).
>
> That wouldn't be impossible with MCP2515s, just inadvisable.=20
> Especially with Linux as it isn't good at any service guarantees.
>
> But I've successfully run three MCP2515's on a Coldfire part. The QSP=
I=20
> helps a lot. There are a lot of parts with multiple QSPI ports, and=20
> that makes it less onerous (or DSPI or ECSPI). The i.MX6D has 5 on it=
=2E=20
> So two "real" CAN ports and two MCP2515's on each of the SPI ports,=20
> with a spare SPI port. Or three per port.
>
>> I don't want to use MCP2515, i had trouble with it on a previous
> > design because of the lack of buffer in the chip.
>> I can't imagine putting 8 MCP2515 and not missing any frame, but may=
 be
>> i'm wrong ?
>
> Did you turn the BUKT bit on? If you spread them across lots of SPI=20
> interfaces it should get easier as they should all be accessed in=20
> parallel.
>
> Tom
>

