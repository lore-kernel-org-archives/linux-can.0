From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH v2 1/3][can-next] can: rcar_can: Fix erroneous registration
Date: Mon, 10 Sep 2018 11:43:13 +0100
Message-ID: <1536576195-11520-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Chris Paterson <Chris.Paterson2@renesas.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Assigning 2 to "renesas,can-clock-select" tricks the driver into
registering the CAN interface, even though we don't want that.
This patch improves one of the checks to prevent that from happening.

Fixes: 862e2b6af9413b43 ("can: rcar_can: support all input clocks")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <Chris.Paterson2@renesas.com>
---

v1->v2:
* dropped id specific data as per Geert's comments

This patch applies on top of linux-can-next-for-4.19-20180727.

 drivers/net/can/rcar/rcar_can.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 11662f4..771a460 100644
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
2.7.4
