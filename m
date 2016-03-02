From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: r8a7795: Add CAN support
Date: Wed, 2 Mar 2016 09:28:06 +0900
Message-ID: <20160302002806.GH17986@verge.net.au>
References: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D54EFA.6020105@pengutronix.de>
 <SG2PR06MB103895394DED2A849E2A801BC3BB0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52209 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932364AbcCBA2K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Mar 2016 19:28:10 -0500
Content-Disposition: inline
In-Reply-To: <SG2PR06MB103895394DED2A849E2A801BC3BB0@SG2PR06MB1038.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "wg@grandegger.com" <wg@grandegger.com>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Paterson <Chris.Paterson2@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>

On Tue, Mar 01, 2016 at 08:20:25AM +0000, Ramesh Shanmugasundaram wrote:
> Hi Marc,
> 
> > On 02/29/2016 03:22 PM, Ramesh Shanmugasundaram wrote:
> > > Adds CAN controller nodes for r8a7795.
> > >
> > > Note: CAN channel register base address mentioned in R-Car Gen3
> > > Hardware User Manual v0.5E is incorrect. The corrected base addresses
> > are:
> > >
> > > CAN Channel 0 - 0xe6c30000
> > > CAN Channel 1 - 0xe6c38000
> > >
> > > Signed-off-by: Ramesh Shanmugasundaram
> > > <ramesh.shanmugasundaram@bp.renesas.com>
> > > ---
> > > Hi All,
> > >
> > >    This patch is based on linux-next (tag:next-20160225) with following
> > patch
> > >    applied on top
> > 
> > Who should take this patch?
> 
> If acked, I think it is Simon (who consolidates all Renesas ARM64 DT changes and make one pull request). Copied Geert too.

I believe it is appropriate for me to take this patch the renesas tree.
I would be glad of any review and Acks, though I don't think an Ack
from the driver maintainer is strictly necessary.

Assuming there are no objections I plan to queue up this patch
once the bindings been queued up.
