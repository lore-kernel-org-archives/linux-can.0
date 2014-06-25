From: "qiang.zhao@freescale.com" <qiang.zhao@freescale.com>
Subject: RE: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
Date: Wed, 25 Jun 2014 02:04:08 +0000
Message-ID: <1403661847384.93009@freescale.com>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
	 <1403281165.12851.186.camel@snotra.buserror.net>
	 <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>,<1403631298.26908.1.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:27917
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752322AbaFYCEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jun 2014 22:04:11 -0400
In-Reply-To: <1403631298.26908.1.camel@snotra.buserror.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>


________________________________________
From: Wood Scott-B07421
Sent: Wednesday, June 25, 2014 1:34 AM
To: Zhao Qiang-B45475
Cc: linuxppc-dev@lists.ozlabs.org; linux-can@vger.kernel.org; wg@grandegger.com; mkl@pengutronix.de
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan

On Mon, 2014-06-23 at 01:20 -0500, Zhao Qiang-B45475 wrote:
> On Sat, 2014-06-21 at 12:19, Wood Scott wrote:
>
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, June 21, 2014 12:19 AM
> > To: Zhao Qiang-B45475
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-can@vger.kernel.org;
> > wg@grandegger.com; mkl@pengutronix.de; Wood Scott-B07421
> > Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
> >
> > On Fri, 2014-06-20 at 10:01 +0800, Zhao Qiang wrote:
> > > when flexcan is not physically linked, command 'cantest' will trigger
> > > an err_irq, add err_irq handler for it.
> > >
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > > ---
> > > Changes for v2:
> > >   - use a space instead of tab
> > >   - use flexcan_poll_state instead of print
> > >
> > >  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > > index f425ec2..7432ba4 100644
> > > --- a/drivers/net/can/flexcan.c
> > > +++ b/drivers/net/can/flexcan.c
> > > @@ -208,6 +208,7 @@ struct flexcan_priv {
> > >   void __iomem *base;
> > >   u32 reg_esr;
> > >   u32 reg_ctrl_default;
> > > + unsigned int err_irq;
> >
> > Why unsigned?
> Err_irq is from 0.

So?  irqs are plain "int" almost everywhere in the kernel.

OK, I will change it.

-Zhao 

