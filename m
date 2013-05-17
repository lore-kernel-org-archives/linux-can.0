From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] can: flexcan: allow compilation on arm and powerpc
Date: Fri, 17 May 2013 10:03:52 +0800
Message-ID: <20130517020351.GE3893@S2101-09.ap.freescale.net>
References: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:2992 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447Ab3EQCD7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 16 May 2013 22:03:59 -0400
Content-Disposition: inline
In-Reply-To: <1368711756-22324-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Kumar Gala <galak@kernel.crashing.org>, U Bhaskar-B22300 <B22300@freescale.com>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

Hi Marc,

On Thu, May 16, 2013 at 03:42:36PM +0200, Marc Kleine-Budde wrote:
> This patch removes the Kconfig symbols HAVE_CAN_FLEXCAN and
> IMX_HAVE_PLATFORM_FLEXCAN from arch/{arm,powerpc} and allowing compilation on
> all arm and powerpc platforms.

I'm generally fine with the approach.  But with Kconfig symbol
IMX_HAVE_PLATFORM_FLEXCAN removed, how does the build of
platform-flexcan.o work?

arch/arm/mach-imx/devices/Makefile:obj-$(CONFIG_IMX_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o

Shawn

