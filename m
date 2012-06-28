From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios
 support
Date: Thu, 28 Jun 2012 19:39:03 +0800
Message-ID: <20120628113902.GK6406@shlinux2.ap.freescale.net>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <4FEC329C.7070004@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:39951
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab2F1Lol (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:44:41 -0400
Content-Disposition: inline
In-Reply-To: <4FEC329C.7070004@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Thu, Jun 28, 2012 at 12:31:56PM +0200, Marc Kleine-Budde wrote:
> On 06/28/2012 05:21 AM, Shawn Guo wrote:
> > The flexcan driver has function pointer transceiver_switch defined in
> > flexcan_platform_data for platform codes to hook up their transceiver
> > switch implementation.  However this does not cope with device tree
> > probe.
> > 
> > It's been observed that platforms mostly use gpios to control the
> > switch of flexcan transceiver, like enable and standby.  The patch
> > adds transceiver switch gpios support into flexcan driver, so that
> > platforms booting from device tree can just define properties
> > phy-enable-gpios and phy-standby-gpios to have flexcan driver control
> > the gpios.
> 
> Hmm I'm wondering if transceiver or phy is the correct name here. In
> platform_data it's called transceiver_switch.
> 
Hmm, i also had this wondering.
I quote some info from the spec like:
"The MC33902 is a high speed CAN physical interface. The device 
includes an internal 5.0 V supply for the CAN bus transceiver, and 
requires only a connection to a battery line."

Maybe transceiver is more close to spec.

Regards
Dong Aisheng

