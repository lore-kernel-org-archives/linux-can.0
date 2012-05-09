From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [PATCH] can: flexcan: add PM support
Date: Wed, 9 May 2012 10:16:50 +0200
Message-ID: <20120509081650.GA426@vandijck-laurijssen.be>
References: <1336489937-29645-1-git-send-email-eric@eukrea.com>
 <4FA9394A.90303@pengutronix.de>
 <20120508173001.31ce8f0c@eb-e6520>
 <4FA93FC1.7030808@pengutronix.de>
 <20120508191459.703c4369@eb-e6520>
 <4FA95A17.8090406@hartkopp.net>
 <4FA96750.6020206@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:31383 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010Ab2EIIRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 May 2012 04:17:00 -0400
Content-Disposition: inline
In-Reply-To: <4FA96750.6020206@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-can@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

On Tue, May 08, 2012 at 08:34:56PM +0200, Marc Kleine-Budde wrote:
> On 05/08/2012 07:38 PM, Oliver Hartkopp wrote:
> > On 08.05.2012 19:14, Eric B=C3=A9nard wrote:
> >=20
> >> Le Tue, 08 May 2012 17:46:09 +0200,
> >> Marc Kleine-Budde <mkl@pengutronix.de> a =C3=A9crit :
> >>
> >>> On 05/08/2012 05:30 PM, Eric B=C3=A9nard wrote:
> >>>> Hi Marc,
> >>>>
> >>>> Le Tue, 08 May 2012 17:18:34 +0200,
> >>>> Marc Kleine-Budde <mkl@pengutronix.de> a =C3=A9crit :
> >>>>
> >>>>> On 05/08/2012 05:12 PM, Eric B=C3=A9nard wrote:
> >>>>>> tested on an i.MX257
> >>>>>
> >>>>> What about the transceiver? Does is make sense to switch it off=
, too?
> >>>>>
> >>>> this could make sense on platform which have a transceiver with =
an
> >>>> enable input. I can add flexcan_transceiver_switch after/before
> >>>> flexcan_chip_disable/enable but won't be able to test that featu=
re.
> >>>
> >>> I looked at two ethernet drivers: ethernet/intel/ixgbe/ixgbe_main=
=2Ec and
> >>> ethernet/intel/ixgbe/ixgbe_main.c and AFAICS they basically do th=
e same
> >>> as in open/close. (btw: the flexcan driver switches the transceiv=
er
> >>> on/off on open/close.) I haven't implemented any network driver p=
m yet,
> >>> but what is a driver supposed to do in suspend/resume?
> >>>
> >> concerning the transceiver : that depends if you need to resume wh=
en
> >> receiving a message on the CAN bus in which case you can't disable=
 the
> >> transceiver (btw, I have an other patch which enable wakeup when
> >> receiving a message on the CAN bus, but I need to clean and test i=
t
> >> again).
> >=20
> >=20
> > I wonder if you mix up the enabling/disabling of the CAN transceive=
r (trx)
> > with the entire system power management.
> >=20
> > E.g. if you take the TJA1054A as an example, you can switch the trx=
 into a
> > mode that switches off the power supply (INH-line) in order to wake=
 up with a
> > received CAN frame, which switches on the power supply and boots th=
e system.
> >=20
> > Even if you don't switch the power supply with the INH pin the trx =
wakes up
> > with CAN traffic in this mode.
> >=20
> > To me switching the trx modes only makes sense to implement system =
power
> > management states. IMO there's no need to switch them when setting =
the
> > interface to up/down state. Or did i miss anything?
* the transceiver consumes power when on, while the netif if off.
  That just feels a bit stupid.
* From outside, the wires looks 'active', while there's just noone list=
ening.

=46or these 2 arguments, I would think a regular system switches them o=
ff too.looks

>=20
> In the current implementation you can register a callback via
> platform_data to enable/disable the transceiver. It's up to the board=
 to
> do something useful with it.
Like in: The driver must call the callback, and the board can act upon =
this.
>=20
> I think for now I'll take Eric's patch as it is, until we've implemen=
ted
> something more complicated to support automotive style transceivers :=
)

To implement something more complicated:
http://www.mail-archive.com/socketcan-core@lists.berlios.de/msg00269.ht=
ml

Kurt

