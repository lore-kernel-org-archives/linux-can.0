From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: m_can: add CONFIG_HAS_IOMEM dependence
Date: Sat, 18 Oct 2014 18:30:02 +0200
Message-ID: <20141018163001.GA24931@pengutronix.de>
References: <1413409310-14117-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45665 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbaJRQaV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 18 Oct 2014 12:30:21 -0400
Content-Disposition: inline
In-Reply-To: <1413409310-14117-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: wg@grandegger.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org

On Wed, Oct 15, 2014 at 02:41:50PM -0700, David Cohen wrote:
> m_can uses io memory which makes it not compilable on architectures
> without HAS_IOMEM such as UML:
> 
> drivers/built-in.o: In function `m_can_plat_probe':
> m_can.c:(.text+0x218cc5): undefined reference to `devm_ioremap_resource'
> m_can.c:(.text+0x218df9): undefined reference to `devm_ioremap'
> 
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>

Applied to the can tree.

Thanks,
Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
