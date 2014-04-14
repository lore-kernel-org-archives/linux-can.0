From: Steffen Rose <ro@emtas.de>
Subject: Re: Error Active
Date: Mon, 14 Apr 2014 14:13:33 +0200
Message-ID: <2625052.FRqudkDGEA@lisa>
References: <15704970.EHNVEi1RO0@lisa> <11552477.qsHBqKfRM3@lisa> <a60984530bb93305b1c3dfac1b3403d4@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:58766 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaDNMOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Apr 2014 08:14:14 -0400
In-Reply-To: <a60984530bb93305b1c3dfac1b3403d4@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hello Wolfgang,

thank you very much for your answers.
=20
> libsocketcan, like ip uses a netlink socket to get the configuration =
and
> statistics of the CAN device. This includes the "state" property.

Do all implementation support the netlink socket, especially the CAN st=
ate?
I think, state is UNKNOWN and don't mean the Can state, is it?

$ ip -det -stat link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast *state* UNKNO=
WN qlen=20
10000
    link/can=20
    *can state* ERROR-ACTIVE restart-ms 0=20
    bitrate 250000 sample-point 0.875=20
    tq 250 prop-seg 6 phase-seg1 7 phase-seg2 2 sjw 1
    ems_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
    clock 8000000
    re-started bus-errors arbit-lost error-warn error-pass bus-off
    0          0          0          0          0          0        =20
    RX: bytes  packets  errors  dropped overrun mcast  =20
    0          0        0       0       0       0     =20
    TX: bytes  packets  errors  dropped carrier collsns=20
    0          0        0       0       0       0     =20

=20
> > Do socketcan have different ways to get the current state? Is it a =
low
> > level
> > driver part to read and hold the current state?
>=20
> No. Both get the infos via netlink socket from the kernel.

I'm not so familiar with the parts of the system and the correct naming=
 of it.

I understand, that socketcan has a common part for all (many) driver=20
adaptations  (can_bcm, can_raw) and a CAN controller specific part (can=
).
As I understand, for the last point exists many different implementatio=
ns with=20
different feature implementation.
=20
> > (I'm sorry. I'm unsure about the driver I tested in this situation.=
 I
> > think,
> > it was the EMS CPC driver and kernel 3.2.0-60-generic. )
>=20
> This device uses a SJA1000.
>=20

My mistake
USB interface from EMS

vcan                   12686  0=20
can_bcm                22077  0=20
can_raw                17120  0=20
can                    36556  2 can_bcm,can_raw
ems_usb                17510  0=20
can_dev                15321  1 ems_usb


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen

    Steffen Rose

-----------------------------------------------------------------------=
--

emtas - your embedded solution partner
=20
N=C3=A4chste CANopen Schulung am 06. Mai in Merseburg
N=C3=A4chste EnergyBus Schulung am 07. Mai in Merseburg

-----------------------------------------------------------------------=
--
emtas GmbH
=46ritz-Haber-Stra=C3=9Fe 9
06217 Merseburg
Tel.:  +49(0)3461-79416-0
=46ax.:  +49(0)3461-79416-10
www.emtas.de - service@emtas.de
Gesch=C3=A4ftsf=C3=BChrer: Andreas Boebel, Torsten Gedenk, Steffen Rose
Registergericht: Amtsgericht Stendal
Registernummer:  HRB 17616=20
-----------------------------------------------------------------------=
--

