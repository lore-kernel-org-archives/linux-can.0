From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] can: peak_usb: fix slab info leak
Date: Wed, 23 Oct 2019 10:27:05 +0200
Message-ID: <20191023082705.23283-1-johan@kernel.org>
References: <0000000000007a638805951153c5@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000007a638805951153c5@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, syzbot+863724e7128e14b26732@syzkaller.appspotmail.com
List-Id: linux-can.vger.kernel.org

Fix a small slab info leak due to a failure to clear the command buffer
at allocation.

The first 16 bytes of the command buffer are always sent to the device
in pcan_usb_send_cmd() even though only the first two may have been
initialised in case no argument payload is provided (e.g. when waiting
for a response).

Fixes: bb4785551f64 ("can: usb: PEAK-System Technik USB adapters driver core")
Cc: stable <stable@vger.kernel.org>     # 3.4
Reported-by: syzbot+863724e7128e14b26732@syzkaller.appspotmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 65dce642b86b..0b7766b715fd 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -750,7 +750,7 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	dev = netdev_priv(netdev);
 
 	/* allocate a buffer large enough to send commands */
-	dev->cmd_buf = kmalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
+	dev->cmd_buf = kzalloc(PCAN_USB_MAX_CMD_LEN, GFP_KERNEL);
 	if (!dev->cmd_buf) {
 		err = -ENOMEM;
 		goto lbl_free_candev;
-- 
2.23.0
