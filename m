From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Tue, 29 Apr 2014 14:12:02 +0000
Message-ID: <e8ee658e497ba57266139a0de5645e71@grandegger.com>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
 <20140427180135.GB21176@vandijck-laurijssen.be>
 <535F5449.7000108@tataelxsi.co.in>
 <20140429133355.GA20084@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:58052 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757454AbaD2OME (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 Apr 2014 10:12:04 -0400
In-Reply-To: <20140429133355.GA20084@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>, linux-can@vger.kernel.org, John Whitmore <arigead@gmail.com>

On Tue, 29 Apr 2014 15:33:55 +0200, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:
> On Tue, Apr 29, 2014 at 12:57:05PM +0530, Ratheendran wrote:
>> Thanks John , Kurt Van Dijck for your valuable support.
>>=20
>> I am going ahead with the shell script & iproute2 supported tool
testing
>> a set
>> of fixed baud rate from table.
>>=20
>> My observations with the existing imx6 flexcan hardware running linu=
x
>> 3.0.x.
>>=20
>> Two imx6 board ,both are enabled for FLEXCAN=C2=A0 communication.
>> CAN dev bring up command with baud rate.
>> command -> ip link set can0 up type can bitrate 125000

=46or bus error reporting the option "berr-reporting on" needs to
be added. Otherwise only CAN error state changes will be send.

>> one board run cansend while other end candump--e command

It's good practice to use:

 # candump -td -e any,0:0,#FFFFFFFF

>=20
> The 'autobaud' node must do
> 	$ ip link set canX type can listen-only on
>=20
>>=20
>>=20
>> Case 1 both imx6 operate on same CAN baudrate
>> =C2=A0 cansend can0 -i0x100 11 22 33 44
>> =C2=A0 on candump terminal I receive=C2=A0 <0x100> [4] 0b 16 21 2c
>=20
> Do you use the latest tools from gitorious?
> The syntax of cansend and the output of candump look different.
>=20
> [...]
>> =C2=A0 Case 2: imx6 CAN on different baud rate.=C2=A0
>> =C2=A0received packets( I am not able to interpret the below packet)
>> =C2=A0<0x004> [8] 00 04 00 00 00 00 00 00=C2=A0
>=20
> Well, this is not ok.

Ratheendran, what kernel version are you using? Your flexcan driver mig=
ht
have (old) issues.

> I'd expect an error or status frame, but I don't see it in your candu=
mp
> output.

Me too, that's weird.

> I do notice that the received frame has 8 bytes, and only 1 bit set.
> So, if I suppose that the CAN_ERR_FLAG has been set,
> I see (with include/linux/can/error.h aside)
> <0x004> Controller problem, info in data[1]
>=20
> data[1] 04: Reached warning level for RX errors.
>=20
> I'd expect something like that.
> Wolfgang Grandegger may explain more, as he did author these.

Sounds reasonable, also because the rx error counter did reach 128.

> Next step is to make a script that does all that, and that makes cand=
ump
> stop after a limited time (few seconds).
> I would suggest to skip a baudrate if you receive any error frame, so
the
> interpretation may be not necessary.

Wolfgang.

