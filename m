From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 10/20] can: flexcan: Unlock the MB unconditionally
Date: Mon, 12 Nov 2018 12:57:18 +0100
Message-ID: <20181112115728.18331-11-mkl@pengutronix.de>
References: <20181112115728.18331-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181112115728.18331-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Pankaj Bansal <pankaj.bansal@nxp.com>, linux-stable <stable@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
List-Id: linux-can.vger.kernel.org

From: Pankaj Bansal <pankaj.bansal@nxp.com>

Unlock the MB irrespective of reception method being FIFO or timestamp
based. It is optional but recommended to unlock Mailbox as soon as
possible and make it available for reception.

Reported-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 8e972ef08637..0431f8d05518 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -720,9 +720,14 @@ static unsigned int flexcan_mailbox_read(struct can_rx_offload *offload,
 			priv->write(BIT(n - 32), &regs->iflag2);
 	} else {
 		priv->write(FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->iflag1);
-		priv->read(&regs->timer);
 	}
 
+	/* Read the Free Running Timer. It is optional but recommended
+	 * to unlock Mailbox as soon as possible and make it available
+	 * for reception.
+	 */
+	priv->read(&regs->timer);
+
 	return 1;
 }
 
-- 
2.19.1
