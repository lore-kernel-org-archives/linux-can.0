From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue, 3 Jul 2012 17:56:35 +0100
Message-ID: <20120703165635.GV29030@opensource.wolfsonmicro.com>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
 <20120703141829.GG22705@S2101-09.ap.freescale.net>
 <20120703144646.GT29030@opensource.wolfsonmicro.com>
 <20120703152813.GI22705@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59126 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752741Ab2GCQ4l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 12:56:41 -0400
Content-Disposition: inline
In-Reply-To: <20120703152813.GI22705@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Tue, Jul 03, 2012 at 11:28:15PM +0800, Shawn Guo wrote:
> On Tue, Jul 03, 2012 at 03:46:47PM +0100, Mark Brown wrote:

> > No, I really do mean a fixed voltage regulator.  Dummy regulators should
> > essentially never be used in production.

> In that case, my patch may need to stay unchanged.  Some systems have
> a supply controlled by gpio and we need to have it be a Linux regulator
> to switch it, while other systems have the supply non-switchable which
> can be reasonably invisible to software.  That said, the regulator is
> optional and the failure of devm_regulator_get should not make the
> driver probe fail.

No, really.

> I guess your suggestion here is to make the regulator mandatory for
> the driver, which means those non-switchable supplies have to be
> also defined as Linux regulators for every single system.  I'm not
> sure we want to do that just for saving a regulator pointer check.

If we go down that route what we need to do is to go through and remove
all error checking for failure to get regulators and make the regulator
API silently handle this since exactly the same thing applies to almost
every supply in the system.

What we shouldn't be doing is open coding this stupidity in every single
regulator API user, that's just a pointless waste of everyone's time.
