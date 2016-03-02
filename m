From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: r8a7795: Add CAN FD support
Date: Wed, 2 Mar 2016 16:53:04 +0900
Message-ID: <20160302075304.GA8904@verge.net.au>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D59538.2060100@cogentembedded.com>
 <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56681 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbcCBIA6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Mar 2016 03:00:58 -0500
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Paterson <Chris.Paterson2@renesas.com>

On Wed, Mar 02, 2016 at 07:29:04AM +0000, Ramesh Shanmugasundaram wrote:
> Hi Sergei,
> 
> > On 3/1/2016 1:04 PM, Ramesh Shanmugasundaram wrote:
> > 
> > > Adds CAN FD controller node for r8a7795.
> > >
> > > Note: CAN FD controller register base address specified in R-Car Gen3
> > > Hardware User Manual v0.5E is incorrect. The correct address is:
> > >
> > > CAN FD - 0xe66c0000
> > >
> > > Signed-off-by: Ramesh Shanmugasundaram
> > > <ramesh.shanmugasundaram@bp.renesas.com>
> > > ---
> > > Hi All,
> > >
> > >     This patch is based on linux-next (tag:next-20160225) with the
> > following
> > >     patches applied on top.
> > >
> > >     [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
> > >     [PATCH] arm64: dts: r8a7795: Add CAN support
> > >
> > >     The respective CAN subsystem changes are submitted separately here
> > > (https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg013
> > > 88.html)
> > >
> > > Thanks,
> > > Ramesh
> > > ---
> > >   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
> > >   1 file changed, 24 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > index a88f8d8..5049ba6 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > @@ -553,6 +553,30 @@
> > >   			status = "disabled";
> > >   		};
> > >
> > > +		canfd: canfd@e66c0000 {
> > 
> >     The node name should still be "can@e66c0000", I think.
> 
> Thanks for the review.
> 
> The SoC has CAN controller too and hence I chose this node name to differentiate. A grep of canfd on sysfs would tell if the controller is enabled. The channels on "net" would still be named "canx".
> 
> I'll change it if you still feel "can@e66c0000" is more appropriate.

FWIW, "can@e66c0000" seems more appropriate to me.
