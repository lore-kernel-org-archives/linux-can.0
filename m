From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
Date: Tue, 24 Jun 2014 12:34:58 -0500
Message-ID: <1403631298.26908.1.camel@snotra.buserror.net>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
	 <1403281165.12851.186.camel@snotra.buserror.net>
	 <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0239.outbound.protection.outlook.com ([207.46.163.239]:9689
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754100AbaFXRfK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 24 Jun 2014 13:35:10 -0400
In-Reply-To: <fc0a7150924249768aee8e4361c654a1@BLUPR03MB341.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>

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
> > > 	- use a space instead of tab
> > > 	- use flexcan_poll_state instead of print
> > >
> > >  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> > > index f425ec2..7432ba4 100644
> > > --- a/drivers/net/can/flexcan.c
> > > +++ b/drivers/net/can/flexcan.c
> > > @@ -208,6 +208,7 @@ struct flexcan_priv {
> > >  	void __iomem *base;
> > >  	u32 reg_esr;
> > >  	u32 reg_ctrl_default;
> > > +	unsigned int err_irq;
> > 
> > Why unsigned?
> Err_irq is from 0.

So?  irqs are plain "int" almost everywhere in the kernel.

-Scott


