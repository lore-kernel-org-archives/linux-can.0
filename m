From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] can: flexcan: add a regulator for transceiver
Date: Tue, 3 Jul 2012 14:07:47 +0100
Message-ID: <20120703130747.GD25995@sirena.org.uk>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50469 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab2GCNHv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jul 2012 09:07:51 -0400
Content-Disposition: inline
In-Reply-To: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org

On Tue, Jul 03, 2012 at 08:46:11PM +0800, Shawn Guo wrote:

> +	if (priv->reg_xcvr) {
> +		if (on)
> +			regulator_enable(priv->reg_xcvr);
> +		else
> +			regulator_disable(priv->reg_xcvr);
> +	}

No, the regulator API will stub itself out if not enabled, and if the
supply is fixed then a fixed voltage regulator will do the job.  We
shouldn't be open coding this stuff in individual users.
