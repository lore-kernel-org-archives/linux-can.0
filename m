From: Colin King <colin.king@canonical.com>
Subject: [PATCH][can-next] can: ucan: fix spelling mistake: "resumbmitting" -> "resubmitting"
Date: Mon, 30 Jul 2018 14:40:37 +0100
Message-ID: <20180730134037.8240-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in netdev_dbg error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/can/usb/ucan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 0678a38b1af4..b9b5f6ef5bb2 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -719,7 +719,7 @@ static void ucan_read_bulk_callback(struct urb *urb)
 				  up->in_ep_size,
 				  urb->transfer_buffer,
 				  urb->transfer_dma);
-		netdev_dbg(up->netdev, "not resumbmitting urb; status: %d\n",
+		netdev_dbg(up->netdev, "not resubmitting urb; status: %d\n",
 			   urb->status);
 		return;
 	default:
-- 
2.17.1
