From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: r8a7795: Add CAN FD support
Date: Wed, 2 Mar 2016 07:29:04 +0000
Message-ID: <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D59538.2060100@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:55517 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750797AbcCBH3M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 2 Mar 2016 02:29:12 -0500
In-Reply-To: <56D59538.2060100@cogentembedded.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Paterson <Chris.Paterson2@renesas.com>

Hi Sergei,

> On 3/1/2016 1:04 PM, Ramesh Shanmugasundaram wrote:
> 
> > Adds CAN FD controller node for r8a7795.
> >
> > Note: CAN FD controller register base address specified in R-Car Gen3
> > Hardware User Manual v0.5E is incorrect. The correct address is:
> >
> > CAN FD - 0xe66c0000
> >
> > Signed-off-by: Ramesh Shanmugasundaram
> > <ramesh.shanmugasundaram@bp.renesas.com>
> > ---
> > Hi All,
> >
> >     This patch is based on linux-next (tag:next-20160225) with the
> following
> >     patches applied on top.
> >
> >     [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
> >     [PATCH] arm64: dts: r8a7795: Add CAN support
> >
> >     The respective CAN subsystem changes are submitted separately here
> > (https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg013
> > 88.html)
> >
> > Thanks,
> > Ramesh
> > ---
> >   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a88f8d8..5049ba6 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -553,6 +553,30 @@
> >   			status = "disabled";
> >   		};
> >
> > +		canfd: canfd@e66c0000 {
> 
>     The node name should still be "can@e66c0000", I think.

Thanks for the review.

The SoC has CAN controller too and hence I chose this node name to differentiate. A grep of canfd on sysfs would tell if the controller is enabled. The channels on "net" would still be named "canx".

I'll change it if you still feel "can@e66c0000" is more appropriate.

Thanks,
Ramesh
