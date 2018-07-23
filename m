From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 03/12] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 23 Jul 2018 14:58:34 +0200
Message-ID: <20180723125843.391-4-mkl@pengutronix.de>
References: <20180723125843.391-1-mkl@pengutronix.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Nicholas Mc Guire <hofrat@osadl.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

of_iomap() can return NULL so that return needs to be checked and NULL
treated as failure. While at it also take care of the missing
of_node_put() in the error path.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index c7427bdd3a4b..2949a381a94d 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_device *ofdev,
 		return 0;
 	}
 	cdm = of_iomap(np_cdm, 0);
+	if (!cdm) {
+		of_node_put(np_cdm);
+		dev_err(&ofdev->dev, "can't map clock node!\n");
+		return 0;
+	}
 
 	if (in_8(&cdm->ipb_clk_sel) & 0x1)
 		freq *= 2;
-- 
2.18.0
