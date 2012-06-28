From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/2] flexcan driver updates
Date: Thu, 28 Jun 2012 11:21:39 +0800
Message-ID: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:44242
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753987Ab2F1DWR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 23:22:17 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Changes since v1:
* Add phy-standby-gpios support
* Remove enable-active-low and use of_get_named_gpio_flags instead
* Use devm_gpio_request_one instead of gpio_request_one

Shawn Guo (2):
  net: flexcan: clock-frequency is optional for device tree probe
  net: flexcan: add transceiver switch gpios support

 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    5 ++
 drivers/net/can/flexcan.c                          |   62 ++++++++++++++++++++
 2 files changed, 67 insertions(+), 0 deletions(-)

-- 
1.7.5.4


