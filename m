From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH 1/3] can: mcp251x: Convert driver to use common clk
 framework
Date: Sat, 14 Dec 2013 09:15:07 +0400
Message-ID: <20131214091507.35557bcf132c885cfba69008@mail.ru>
References: <1384332144-15211-1-git-send-email-shc_work@mail.ru>
	<528340A7.9080708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:41619 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3LNFRM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Dec 2013 00:17:12 -0500
In-Reply-To: <528340A7.9080708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>, netdev@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Eric Miao <eric.y.miao@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>

On Wed, 13 Nov 2013 10:04:39 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> as this series adds device tree bindings, please add
> devicetree@vger.kernel.org on Cc for the whole series.
> 
> On 11/13/2013 09:42 AM, Alexander Shiyan wrote:
> > This patch converts mcp251x driver to using common clk framework
> > for getting input frequency. The change was made for the preparation
> > of the driver work with the devicetree. As a result private header
> > for the driver is eliminated.
> > Additionally, all existing users of the driver was converted to use
> > this feature.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Looks good from my point of view. I'll take the whole series via the
> linux-can tree, if there are no objections. I'd like to have the pxa and
> imx maintainer's Ack and an Ack from the DT list.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Ping. Resend?

-- 
Alexander Shiyan <shc_work@mail.ru>
