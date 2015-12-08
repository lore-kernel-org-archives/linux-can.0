From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 8 Dec 2015 10:50:26 +0000
Message-ID: <20151208105026.GA13146@maxwell.marel.net>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net>
 <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net>
 <56602B1D.90601@pengutronix.de>
 <5666AF26.2080806@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0073.outbound.protection.outlook.com ([157.56.112.73]:38572
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932537AbbLHKwZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 Dec 2015 05:52:25 -0500
Content-Disposition: inline
In-Reply-To: <5666AF26.2080806@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi Stephane,

On Tue, Dec 08, 2015 at 11:21:26AM +0100, Stephane Grosjean wrote:
> Hi!
>=20
> Don't know atm what is buggier, but:
>=20
> - the issue isn't reproducible with our Windows drivers,
> - the issue isn't reproducible with the pcan driver,
You have spin locks sprinkled around the pcan driver even where there i=
sn't a
specific shared resource that's being protected.

However, a nice side-effect of that is that the interrupt routine is no=
t allowed
to run concurrently with the xmit function, so the command register is =
never
written to so frequently as in the linux-can driver.
>=20
[...]
> FYI, I have surrounded the _xmit() function as well as the ISR with c=
ouples
> of spin_lock/spin_unlock instructions, rebuild everything and have ra=
n
> Andri's testbed... and guess what?
I don't know. I'm not sure if you hinted at the answer to this question=
=2E Did the
problem go away? I guess it did due to the reasons that I mentioned abo=
ve.

This does not strike at the core of the issue. A targeted solution is t=
o add a
delay.
>=20
[...]
>=20
> Le 03/12/2015 12:44, Marc Kleine-Budde a =E9crit :
> >On 12/03/2015 12:23 PM, Andri Yngvason wrote:
> >>I tried it and it's not enough. The sja1000 on the peak pci is an F=
PGA
> >>implementation that claims to be sja1000 compatible. Is it possible=
 that peak's
> >>FPGA implementation is slower than the original sja1000?
> >Maybe buggier :)
> >
> >Marc
> >
>=20

Regards,
Andri
