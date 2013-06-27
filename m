From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 0/3] ARM: imx: flexcan: convert transceiver switching to DT
Date: Thu, 27 Jun 2013 09:22:08 +0200
Message-ID: <1372317731-24966-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33257 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3F0HWO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2013 03:22:14 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-can@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Hello,

this series converts the flexcan driver from using a callback function
(configured via platform data), to switch the transceiver on and off, to a
standard regulator. As there are no in-tree users of the platform data, it's
finally removed.

If there are no objections I'd like to upstream this via can-next and David
Miller's net-next. As these patches are touching arch/arm/mach-imx, I don't
want to continue without some Acked-bys.

regards,
Marc

