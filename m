From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon,  9 Jul 2018 21:16:40 +0200
Message-ID: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-can.vger.kernel.org

 of_iompa() can return NULL so that return needs to be checked and NULL
treated as failure. While at it also take care of the missing
of_node_put() in the error path.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
---

Problem was found by an experimental coccinelle script

Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=y,
CONFIG_CAN_MSCAN=y, CONFIG_CAN_MPC5XXX=y
(with a number of sparse warnings not related to the proposed change)

Patch is against 4.18-rc3 (localversion-next is next-20180706)

 drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index c7427bd..2949a38 100644
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
2.1.4
