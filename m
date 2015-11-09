From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: API to support hardware priorities
Date: Mon, 9 Nov 2015 15:04:00 +0100 (CET)
Message-ID: <114496101.533183.1447077840257.JavaMail.open-xchange@omgreatgod.store>
References: <20151109123618.41ad1bae@mitra> <5640A065.2000401@pengutronix.de> <5640A4E4.6020005@pengutronix.de>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:40881 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbKIOGU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Nov 2015 09:06:20 -0500
In-Reply-To: <5640A4E4.6020005@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Benedikt Spranger <b.spranger@linutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Hopefully the webmailer doesn't kill the formatting ... but it seems to=
 be
urgent :-)

We have an ematch implementation for CAN:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/ne=
t/sched/em_canid.c

See idea here:

http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf

The idea is still to have a very short TX FIFO in the driver and fix th=
e
'multi-user' issues in the TX part of the queueing-disciplines.

Regards,
Oliver

> Marc Kleine-Budde <mkl@pengutronix.de> hat am 9. November 2015 um 14:=
51
> geschrieben:
>=20
>=20
> On 11/09/2015 02:32 PM, Marc Kleine-Budde wrote:
> > Let's move this discussion to the mailing list. I'll translate your
> > questions.
> >=20
> > On 11/09/2015 12:36 PM, Benedikt Spranger wrote:
> >> C-CAN und D-CAN basierte Hardware (wie auch andere) unterst=C3=BCt=
zt ja das
> >> priorisierende Versenden von CAN-Paketen. Gibt es Bestrebungen, di=
eses
> >> Feature in der API abzubilden?
> >=20
> > Several CAN IP cores support prioritisation of CAN frames. Is it pl=
anned
> > to support this?
>=20
> There are two buffers before a CAN frame gets send to the wire:
> First there is the queueing in the network layer. You can replace the
> FIFO of the interface by a multi prio queue and filter your CAN frame=
s
> by CAN-ID.
>=20
> The second buffer might be the in the hardware. For now each driver
> ensures that the buffer in configured as a FIFO. Some CAN IP cores
> support sending CAN frames based on the CAN-ID (lowest ID first), som=
e
> have a priority value, some cores even combine these two.
>=20
> Several thoughts on this:
>=20
> IIRC the kernel networking driver API supports several TX queues per
> networking device. We might be exploited this to implement a bulk lar=
ge
> FIFO queue and a high prio no just one buffer TX queue per driver.
>=20
> We can introduce a per device knob to switch a CAN driver from true T=
X
> FIFO mode to CAN-ID based priority TX mode. The driver's TX and
> TX-complete routines have to be adopted as they now assume that the C=
AN
> frames are send in true FIFO order. The feature can be toggled via
> netlink/canconfig.
>=20
> >> Im konkreten Fall werden neben Bulk-Daten azyklisch auch zeitkriti=
sche
> >> CAN-Pakete versendet. Hierbei ist eine FIFO-Abarbeitung st=C3=B6re=
nd. Das
> >> Mailbox-basierte Design von C-CAN/D-CAN unterst=C3=BCtzt ja neben =
der
> >> Verwendung der Mailboxen als FIFO auch die dedizierte Konfiguratio=
n auf
> >> eine CAN-Id/Maske.
> >=20
> > Bene want to send bulk data and time critical cyclic data. Using a
> > hardware FIFO introduces unwanted latencies. He further mentions th=
at
> > it's possible to configure the mailboxes to serve a CAN-ID/mask.
>=20
> Are we talking about RX or TX here?
>=20
> Do you mean the mailbox feature, where you queue a frame into hardwar=
e,
> but sending is delayed until a certain CAN-ID is RX'ed?
>=20
> Marc
>=20
> --=20
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>
