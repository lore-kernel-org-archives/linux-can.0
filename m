From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Tue, 8 May 2012 20:02:25 +0200
Message-ID: <20120508200225.2cf518cc@eb-e6520>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com>
	<4FA9394A.90303@pengutronix.de>
	<20120508173001.31ce8f0c@eb-e6520>
	<4FA93FC1.7030808@pengutronix.de>
	<20120508191459.703c4369@eb-e6520>
	<4FA95A17.8090406@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:52560 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab2EHSCf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 14:02:35 -0400
In-Reply-To: <4FA95A17.8090406@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Le Tue, 08 May 2012 19:38:31 +0200,
Oliver Hartkopp <socketcan@hartkopp.net> a =E9crit :

> On 08.05.2012 19:14, Eric B=E9nard wrote:
>=20
> > Le Tue, 08 May 2012 17:46:09 +0200,
> > Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :
> >=20
> >> On 05/08/2012 05:30 PM, Eric B=E9nard wrote:
> >>> Hi Marc,
> >>>
> >>> Le Tue, 08 May 2012 17:18:34 +0200,
> >>> Marc Kleine-Budde <mkl@pengutronix.de> a =E9crit :
> >>>
> >>>> On 05/08/2012 05:12 PM, Eric B=E9nard wrote:
> >>>>> tested on an i.MX257
> >>>>
> >>>> What about the transceiver? Does is make sense to switch it off,=
 too?
> >>>>
> >>> this could make sense on platform which have a transceiver with a=
n
> >>> enable input. I can add flexcan_transceiver_switch after/before
> >>> flexcan_chip_disable/enable but won't be able to test that featur=
e.
> >>
> >> I looked at two ethernet drivers: ethernet/intel/ixgbe/ixgbe_main.=
c and
> >> ethernet/intel/ixgbe/ixgbe_main.c and AFAICS they basically do the=
 same
> >> as in open/close. (btw: the flexcan driver switches the transceive=
r
> >> on/off on open/close.) I haven't implemented any network driver pm=
 yet,
> >> but what is a driver supposed to do in suspend/resume?
> >>
> > concerning the transceiver : that depends if you need to resume whe=
n
> > receiving a message on the CAN bus in which case you can't disable =
the
> > transceiver (btw, I have an other patch which enable wakeup when
> > receiving a message on the CAN bus, but I need to clean and test it
> > again).
>=20
>=20
> I wonder if you mix up the enabling/disabling of the CAN transceiver =
(trx)
> with the entire system power management.
>=20
> E.g. if you take the TJA1054A as an example, you can switch the trx i=
nto a
> mode that switches off the power supply (INH-line) in order to wake u=
p with a
> received CAN frame, which switches on the power supply and boots the =
system.
>=20
> Even if you don't switch the power supply with the INH pin the trx wa=
kes up
> with CAN traffic in this mode.
>=20
> To me switching the trx modes only makes sense to implement system po=
wer
> management states. IMO there's no need to switch them when setting th=
e
> interface to up/down state. Or did i miss anything?
>=20
OK so the actual patch should be fine.

Eric
