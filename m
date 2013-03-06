From: Sako Youssouf <youssouf.sako@renault-trucks.com>
Subject: RE: Informations About CAN API of the Linux Kernel
Date: Wed, 6 Mar 2013 16:03:29 +0000
Message-ID: <2B7D120CFC15DC438D721B998AD9D9E90971062B@SEGOTNC5180-N2.vcn.ds.volvo.net>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net>
 <513763CC.1070507@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-gw1.it.volvo.com ([192.138.110.14]:31684 "EHLO
	mail-gw1.it.volvo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab3CFQNK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Mar 2013 11:13:10 -0500
In-Reply-To: <513763CC.1070507@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Kurt Van Dijck <kurt.van.dijck@eia.be>

What's your usecae? What do you want to do with that information?

Actually I'm in a multithreaded application and my goal is to lose no f=
rame.
If I had direct access to the hardware, I would go  get the new frame a=
fter hardware interrupt.
But I think it's not possible. So I want to find the better way to get =
all frames in a multithreaded application.=20

Youssouf
_________________________________________________










Youssouf SAKO
System engineer
S +33 1 73 19 07 45
+ youssouf.sako@renault-trucks.com
www.renault-trucks-defense.com

15 bis All=E9e des Marronniers
SAT TER 1 15
SATORY - CS 30502
78 008 VERSAILLES Cedex
=46rance



-----Original Message-----
=46rom: Marc Kleine-Budde [mailto:mkl@pengutronix.de]=20
Sent: mercredi 6 mars 2013 16:42
To: Sako Youssouf
Cc: linux-can@vger.kernel.org; Kurt Van Dijck
Subject: Re: Informations About CAN API of the Linux Kernel

On 03/06/2013 03:51 PM, Sako Youssouf wrote:
> I'm an engineer of a French company, Renault Trucks Defense. We are=20
> Militaries cars makers. We are currently testing the CAN API of=20
> Linux. I found your article "SocketCAN - The official CAN API of the=20
> Linux kernel" on internet and after reading it I have some=20
> questions.

Please use the linux-can mailinglist (Cc'ed), however no HTML mails are
allowed on that list.

> About CAN frame reception:
>=20
> 1.       In a case of a controller with a single receive buffer . if=20
> a new CAN frame arrives and the previous one has not yet been=20
> treated, what happens? is the previous one is just lost? Or the=20
> kernel has a way to handle that situation.

In linux-can we make use of the Linux networking driver model. This
means if a frame is received from the hardware, it read from the receiv=
e
buffer by the driver as soon as possible and pushed into the Linux
networking stack. If the driver fails to do so, the frame of course is =
lost.

However there is a queue between you application and the kernel, so tha=
t
several CAN frames can be on-the-fly between the driver and your
application.

> 2.       In a case of a hardware with a large RX FIFO,  when we call=20
> the read function on userspace program, is it possible to know how=20
> many frames are available on the RX queue?

There's no way to figure out the number of frames in the RX queue of th=
e
hardware. It might be possible to figure out the number of frames in th=
e
software queue between the kernel and your application. What's your
usecae? What do you want to do with that information?

> And a last question, do you have information about when the Linux
> API for SAE J1939 will be available?

Kurt (Cc'ed) can probably comment on this.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



