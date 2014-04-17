From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] c_can: Add support for eg20t (pch_can)
Date: Thu, 17 Apr 2014 23:18:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404172316060.22697@ionos.tec.linutronix.de>
References: <"<533DB663.3030408@hartkopp.net>"> <1396853523-14941-1-git-send-email-alexander.stein@systec-electronic.com> <53503DFB.1080203@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51768 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaDQVSc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 17:18:32 -0400
In-Reply-To: <53503DFB.1080203@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, 17 Apr 2014, Marc Kleine-Budde wrote:

> On 04/07/2014 08:52 AM, Alexander Stein wrote:
> > Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> [..]
> 
> > +static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)
> > +{
> > +	if (enable) {
> > +		u32 __iomem *addr = priv->base + PCH_PCI_SOFT_RESET;
> > +
> > +		/* write to sw reset register */
> > +		iowrite32(1, addr);
> 
> Do we need to wait for something here?

No. It's activating the "reset line" for that IP block. As long as the
bit is set the IP is effectivly in HW reset state. Releasing the reset
brings it back to operation. iowrite32() is serialized by itself, so
no extra work required.

Thanks,

	tglx
