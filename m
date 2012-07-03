From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue, 3 Jul 2012 23:28:15 +0800
Message-ID: <20120703152813.GI22705@S2101-09.ap.freescale.net>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
 <20120703130747.GD25995@sirena.org.uk>
 <20120703141829.GG22705@S2101-09.ap.freescale.net>
 <20120703144646.GT29030@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61101 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab2GCP1c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 11:27:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so9390991pbb.19
        for <linux-can@vger.kernel.org>; Tue, 03 Jul 2012 08:27:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120703144646.GT29030@opensource.wolfsonmicro.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Tue, Jul 03, 2012 at 03:46:47PM +0100, Mark Brown wrote:
> On Tue, Jul 03, 2012 at 10:18:31PM +0800, Shawn Guo wrote:
> > On Tue, Jul 03, 2012 at 02:07:47PM +0100, Mark Brown wrote:
> 
> > > No, the regulator API will stub itself out if not enabled, and if the
> > > supply is fixed then a fixed voltage regulator will do the job.  We
> > > shouldn't be open coding this stuff in individual users.
> 
> > Ah, yes.  But when you say "a fixed voltage regulator", you actually
> > meant dummy regulator, right?
> 
> No, I really do mean a fixed voltage regulator.  Dummy regulators should
> essentially never be used in production.
> 
In that case, my patch may need to stay unchanged.  Some systems have
a supply controlled by gpio and we need to have it be a Linux regulator
to switch it, while other systems have the supply non-switchable which
can be reasonably invisible to software.  That said, the regulator is
optional and the failure of devm_regulator_get should not make the
driver probe fail.

I guess your suggestion here is to make the regulator mandatory for
the driver, which means those non-switchable supplies have to be
also defined as Linux regulators for every single system.  I'm not
sure we want to do that just for saving a regulator pointer check.

> >  static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
> >  {
> > +       if (on)
> > +               regulator_enable(priv->reg_xcvr);
> > +       else
> > +               regulator_disable(priv->reg_xcvr);
> > +
> 
> So long as the stack guarantees that you won't get unbalanced calls to
> this and...
> 
> > +       priv->reg_xcvr = devm_regulator_get(&pdev->dev, "xcvr");
> 
> ...add error checking here the code should be fine, yes.

-- 
Regards,
Shawn
