From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/2] flexcan: add err interrupt for p1010rdb
Date: Fri, 20 Jun 2014 11:16:07 -0500
Message-ID: <1403280967.12851.183.camel@snotra.buserror.net>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
	 <1403229664-33912-2-git-send-email-B45475@freescale.com>
	 <53A3F660.4040807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:51847
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753600AbaFTQQP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 20 Jun 2014 12:16:15 -0400
In-Reply-To: <53A3F660.4040807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-can@vger.kernel.org, wg@grandegger.com, B07421@freescale.com

On Fri, 2014-06-20 at 10:52 +0200, Marc Kleine-Budde wrote:
> On 06/20/2014 04:01 AM, Zhao Qiang wrote:
> > add err interrupt for p1010rdb into dts.
> > 
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > Changes for v2:
> > 	- add binding documentation update
> > 
> >  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 7 +++++--
> >  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi               | 6 ++++--
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > index 56d6cc3..81929e5 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > @@ -10,7 +10,9 @@ Required properties:
> >    - fsl,p1010-flexcan
> >  
> >  - reg : Offset and length of the register set for this device
> > -- interrupts : Interrupt tuple for this device
> > +- interrupts : Interrupt tuple for this device.
> > +	The first interrupt is for FlexCAN(Message Buffer and Wake Up)
> > +	The second is for error(Shared with IFC, PEX1 and some other device)
> 
> The second interrupt is optional, at least on ARM we don't need it,
> please reflect this in the documentation update.

The binding also shouldn't specify that the interrupt is shared, much
less with specific things.  It's not relevant, and may not be
universally true.

-Scott


