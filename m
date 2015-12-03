From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Thu, 3 Dec 2015 11:23:19 +0000
Message-ID: <20151203112319.GA5230@maxwell.marel.net>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net>
 <565FE31D.8060606@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0068.outbound.protection.outlook.com ([157.55.234.68]:20032
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964909AbbLCLZW (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 3 Dec 2015 06:25:22 -0500
Content-Disposition: inline
In-Reply-To: <565FE31D.8060606@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, s.grosjean@peak-system.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

On Thu, Dec 03, 2015 at 07:37:17AM +0100, Oliver Hartkopp wrote:
> Some more details:
>=20
> On 12/02/2015 08:19 PM, Oliver Hartkopp wrote:
> > On 12/02/2015 07:09 PM, Andri Yngvason wrote:
> >> Quoting Andri Yngvason (2015-11-18 14:51:21)
> >> [...]
> >>> We've been experiencing frame loss on transmission in the peak_pc=
i netdev
> >>> driver.
> >> [...]
>=20
>=20
> >>  I tried adding a delay to test my theory:
> >> diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/s=
ja1000/sja1000.c
> >> index f968d1e..b5115c2 100644
> >> --- a/drivers/net/can/sja1000/sja1000.c
> >> +++ b/drivers/net/can/sja1000/sja1000.c
> >> @@ -93,6 +93,7 @@ static void sja1000_write_cmdreg(struct sja1000_=
priv *priv, u8 val)
> >>  	spin_lock_irqsave(&priv->cmdreg_lock, flags);
> >>  	priv->write_reg(priv, SJA1000_CMR, val);
> >>  	priv->read_reg(priv, SJA1000_SR);
> >> +	udelay(10);
> >>  	spin_unlock_irqrestore(&priv->cmdreg_lock, flags);
> >>  }
> >=20
> > Hi Andri,
> >=20
> > looking at the code above I wonder whether the
> >=20
> > 	priv->read_reg(priv, SJA1000_SR);
> >=20
> > is a bad hack anyway.
> >=20
> > The read_reg() becomes readb(priv->reg_base + (port << 2)) in peak_=
pci.c and
> > the result is never used.
> >=20
> > What if the entire operation gets 'optimized' at some point?

Hi Oliver,

According to ftrace it takes at least 1us to execute.

> >=20
> > Can you check what happens if you just replace the priv->read_reg()=
 with your
> > udelay(10) call?
> >=20
>=20
> In fact I contributed the first SJA1000 SMP fix myself.
>=20
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi=
t?id=3D57c8a456640fa3ca777652f11f2db4179a3e66b6
>=20
> As we only picked the code suggestion from Klaus the delay was introd=
uced by
> priv->read_reg() - which is obviously not the proper way.
>=20
> The data sheet says:
>=20
> "Between two commands at least one internal clock cycle is needed in =
order to
> proceed. The internal clock is half of the external oscillator freque=
ncy."

The upper bound would have been more useful information here. ;)

>=20
> The SJA1000 accepts external clocks from 0 to 24 MHz - all our driver=
s have an
> external clock of 16 MHz which leads to an internal clock of 8 MHz.
>=20
> If we need an additional internal clock cycle we can calculate this w=
ith
> 4 MHz and 1/4.000.000 =3D 0.000,000,25 =3D> 250ns =3D 0.25us
>=20
> Even if someone would use an external clock of 8 MHz a udelay(1) shou=
ld be enough.
>=20
> Can you please make a test where you replace the priv->read_reg() jus=
t with
> udelay(1)?

I tried it and it's not enough. The sja1000 on the peak pci is an FPGA
implementation that claims to be sja1000 compatible. Is it possible tha=
t peak's
=46PGA implementation is slower than the original sja1000?

St=E9phane, what do you think?

>=20
> If it works I would like to contribute a patch to fix my former attem=
pt with a
> Reported-by: and Tested-by: tag from you.
>=20
Sure, whatever gets this fixed is fine by me. ;)

Thanks,
Andri
