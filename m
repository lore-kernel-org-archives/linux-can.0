From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] net: flexcan: clock-frequency is optional for device tree probe
Date: Thu, 28 Jun 2012 11:21:40 +0800
Message-ID: <1340853701-4488-2-git-send-email-shawn.guo@linaro.org>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:14417
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753987Ab2F1DVh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 23:21:37 -0400
In-Reply-To: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

The property clock-frequency is optional for device tree probe.  When
it's absent, the flexcan driver will try to get the frequency from clk
system by calling clk_get_rate.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index f31b686..8ff324e 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -11,6 +11,9 @@ Required properties:
 
 - reg : Offset and length of the register set for this device
 - interrupts : Interrupt tuple for this device
+
+Optional properties:
+
 - clock-frequency : The oscillator frequency driving the flexcan device
 
 Example:
-- 
1.7.5.4


