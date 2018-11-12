From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 07/20] can: rcar_can: Fix erroneous registration
Date: Mon, 12 Nov 2018 12:57:15 +0100
Message-ID: <20181112115728.18331-8-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Chris Paterson <Chris.Paterson2@renesas.com>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Assigning 2 to "renesas,can-clock-select" tricks the driver into
registering the CAN interface, even though we don't want that.
This patch improves one of the checks to prevent that from happening.

Fixes: 862e2b6af9413b43 ("can: rcar_can: support all input clocks")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 11662f479e76..771a46083739 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -24,6 +24,9 @@
 
 #define RCAR_CAN_DRV_NAME	"rcar_can"
 
+#define RCAR_SUPPORTED_CLOCKS	(BIT(CLKR_CLKP1) | BIT(CLKR_CLKP2) | \
+				 BIT(CLKR_CLKEXT))
+
 /* Mailbox configuration:
  * mailbox 60 - 63 - Rx FIFO mailboxes
  * mailbox 56 - 59 - Tx FIFO mailboxes
@@ -789,7 +792,7 @@ static int rcar_can_probe(struct platform_device *pdev)
 		goto fail_clk;
 	}
 
-	if (clock_select >= ARRAY_SIZE(clock_names)) {
+	if (!(BIT(clock_select) & RCAR_SUPPORTED_CLOCKS)) {
 		err = -EINVAL;
 		dev_err(&pdev->dev, "invalid CAN clock selected\n");
 		goto fail_clk;
-- 
2.19.1
