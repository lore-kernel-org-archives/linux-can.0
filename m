From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: detect auto baud rate on can bus in linux driver.
Date: Tue, 29 Apr 2014 15:33:55 +0200
Message-ID: <20140429133355.GA20084@vandijck-laurijssen.be>
References: <53590FB6.6090707@tataelxsi.co.in>
 <20140427094418.GB28319@griso.site>
 <20140427180135.GB21176@vandijck-laurijssen.be>
 <535F5449.7000108@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:21965 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751330AbaD2NeA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 29 Apr 2014 09:34:00 -0400
Content-Disposition: inline
In-Reply-To: <535F5449.7000108@tataelxsi.co.in>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ratheendran <ba.rsrajeshwaran@tataelxsi.co.in>
Cc: linux-can@vger.kernel.org, John Whitmore <arigead@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>

On Tue, Apr 29, 2014 at 12:57:05PM +0530, Ratheendran wrote:
> Thanks John , Kurt Van Dijck for your valuable support.
>=20
> I am going ahead with the shell script & iproute2 supported tool test=
ing a set
> of fixed baud rate from table.
>=20
> My observations with the existing imx6 flexcan hardware running linux=
 3.0.x.
>=20
> Two imx6 board ,both are enabled for FLEXCAN=C2=A0 communication.
> CAN dev bring up command with baud rate.
> command -> ip link set can0 up type can bitrate 125000
> one board run cansend while other end candump--e command

The 'autobaud' node must do
	$ ip link set canX type can listen-only on

>=20
>=20
> Case 1 both imx6 operate on same CAN baudrate
> =C2=A0 cansend can0 -i0x100 11 22 33 44
> =C2=A0 on candump terminal I receive=C2=A0 <0x100> [4] 0b 16 21 2c

Do you use the latest tools from gitorious?
The syntax of cansend and the output of candump look different.

[...]
> =C2=A0 Case 2: imx6 CAN on different baud rate.=C2=A0
> =C2=A0received packets( I am not able to interpret the below packet)
> =C2=A0<0x004> [8] 00 04 00 00 00 00 00 00=C2=A0

Well, this is not ok.
I'd expect an error or status frame, but I don't see it in your candump=
 output.
I do notice that the received frame has 8 bytes, and only 1 bit set.
So, if I suppose that the CAN_ERR_FLAG has been set,
I see (with include/linux/can/error.h aside)
<0x004> Controller problem, info in data[1]

data[1] 04: Reached warning level for RX errors.

I'd expect something like that.
Wolfgang Grandegger may explain more, as he did author these.

Next step is to make a script that does all that, and that makes candum=
p
stop after a limited time (few seconds).
I would suggest to skip a baudrate if you receive any error frame, so t=
he
interpretation may be not necessary.

Kurt
