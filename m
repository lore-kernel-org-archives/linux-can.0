Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222B46C838;
	Wed, 30 Sep 2026 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757901; cv=none; b=CCXI9BIXhW7S7jS1JDztwqAYa7TN275QYPjba7dp8ochEnchmUu+G2VKasSTAF7HNnmfFdbiRHw6cXkE25GmYX9Q9TRVS5yhsvmXVDpNOk3FTEx9cgDp7W9RKqcaa9jwbg139X4DkHOcGxZlwXLgSj8/AwFdAAqpF5ntPiG4vdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757901; c=relaxed/simple;
	bh=1N6la0pKgfYUc2t+ZgloMwPRKnzj6D3+WN0alBSoOq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uIfwYwearUwHOiEnw70dY31RnS2Kc9P5+3dXR46ZEjfCfus+OgrztK9Y9EsYFdS+w0FUDJanT+u6j4Qh5MoAq+mxB0svlcEi2Wp3S99EsH1YDQVsYYH0ILH6R3xBPcJ/N7enNxT7MUV24yx844OFCzmq5/soUxRnZrGKlQGjW7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=ent7Zl9r; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="ent7Zl9r"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 29F9C7803A2;
	Wed, 30 Sep 2026 10:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1790757891;
	bh=1N6la0pKgfYUc2t+ZgloMwPRKnzj6D3+WN0alBSoOq0=;
	h=From:Date:Subject:To:Cc:From;
	b=ent7Zl9rADwt9D5ezYf2PmedFn8Dhgaiq8Sz/+OB/0YlvSezsCyeMmApfZ+U0rF5E
	 +jkfZe2FjRFrib5sHcjcCfEzulWJLpDLDzoh9T+Jcqs730KcC1ZcmKpZuq7lyF5fGg
	 3xfvwBVsh81XM0b+MeA9fbWEDI7bmtNluKY4dl2VktZwHi2sCKxJbOo3GWKEHpgZt2
	 mrnzylt8rvTkdS8NcU9ZgYH/2iQN8m/8wV8UtjVrbgScsr81tQSLPfy4ATzgFLCULa
	 iSqUoFu7oH6MvDV/kjO8SYfb3fx28sbyG76ta/lvw+t7S53NQH6y3kfz6fFE4F/51B
	 Y/Diqffq5UpTQ==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Wed, 30 Sep 2026 10:44:33 +0200
Subject: [PATCH v3] can: peak_usb: Add bus error reporting for the PCAN-USB
 FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>
X-B4-Tracking: v=1; b=H4sIAPDLvGoC/42NywrCMBQFf0WyNpKk1rSu/A8RyePGRrEtuW2wl
 P67SV0K4nJgzpyZIAQPSI6bmQSIHn3XJii2G2Ia1d6AepuYCCYOrBY17UE9riNqalTrLNUQArU
 Ae2GY0YoxkpZ9AOdfa/V8+TCO+g5myKlsNB6HLkzrbeTZ+/0QOeVUKm3LqnSVlO6ULYoTDvDcu
 UDyTRR/hEQKcSUZK2UtTVF9hZZleQOVR6J8FgEAAA==
X-Change-ID: 20260929-peak_usb-canfd-berr-dee42c0cba00
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.16.0

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

CAN bus error reporting is currently missing for all PEAK-System
USB-to-CAN FD devices. Add support for reporting bus errors by enabling
bus error notifications in the firmware for each CAN channel. Parsing of
the entire URB is aborted if the firmware reports an invalid channel.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
Changes in v3:
- Reword comment on bogus channel reports to explicitly document why
  the entire URB is rejected on protocol violations.
- Link to v2: https://patch.msgid.link/20260929-peak_usb-canfd-berr-v2-1-1a7005797c38@peak-system.fr

Changes in v2:
- Add a defensive check against single-channel adapters reporting an
  invalid channel index.
- Link to v1: https://patch.msgid.link/20260929-peak_usb-canfd-berr-v1-1-7abd585f877f@peak-system.fr

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 91 ++++++++++++++++++++++++++----
 include/linux/can/dev/peak_canfd.h         | 15 ++++-
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 0d46f4ce5dca..5840623662af 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -661,17 +661,73 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	struct pucan_error_msg *er = (struct pucan_error_msg *)rx_msg;
 	struct pcan_usb_fd_device *pdev;
 	struct peak_usb_device *dev;
+	struct can_frame *cf;
+	struct sk_buff *skb;
+	u8 can_err_tx = 0;
 
 	if (pucan_ermsg_get_channel(er) >= ARRAY_SIZE(usb_if->dev))
 		return -EINVAL;
 
+	/* Guard against bogus channel 1 reports from single-channel adapters.
+	 * Treat the entire URB as invalid in that case.
+	 */
 	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
+	if (!dev)
+		return -EINVAL;
+
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 
 	/* keep a trace of tx and rx error counters for later use */
 	pdev->bec.txerr = er->tx_err_cnt;
 	pdev->bec.rxerr = er->rx_err_cnt;
 
+	/* ignore non-CAN error notifications */
+	if (PUCAN_ERMSG_TYPE(er) > PUCAN_ERMSG_OTHER_ERROR)
+		return 0;
+
+	/* update other errors counters */
+	dev->can.can_stats.bus_error++;
+
+	if (PUCAN_ERMSG_RX(er)) {
+		dev->netdev->stats.rx_errors++;
+	} else {
+		dev->netdev->stats.tx_errors++;
+		can_err_tx = CAN_ERR_PROT_TX;
+	}
+
+	/* if berr-reporting is off, stop here */
+	if (!(dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING))
+		return 0;
+
+	/* otherwise, build the CAN_ERR_xxx frame */
+	skb = alloc_can_err_skb(dev->netdev, &cf);
+	if (!skb)
+		return -ENOMEM;
+
+	cf->can_id |= CAN_ERR_CNT | CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	cf->data[2] |= can_err_tx;
+
+	switch (PUCAN_ERMSG_TYPE(er)) {
+	case PUCAN_ERMSG_BIT_ERROR:
+		cf->data[2] |= CAN_ERR_PROT_BIT;
+		break;
+	case PUCAN_ERMSG_FORM_ERROR:
+		cf->data[2] |= CAN_ERR_PROT_FORM;
+		break;
+	case PUCAN_ERMSG_STUFF_ERROR:
+		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		break;
+	default:
+		break;
+	}
+
+	cf->data[3] = PUCAN_ERMSG_CODE(er);
+
+	cf->data[6] = pdev->bec.txerr;
+	cf->data[7] = pdev->bec.rxerr;
+
+	peak_usb_netif_rx_64(skb, le32_to_cpu(er->ts_low),
+			     le32_to_cpu(er->ts_high));
 	return 0;
 }
 
@@ -899,6 +955,7 @@ static int pcan_usb_fd_start(struct peak_usb_device *dev)
 {
 	struct pcan_usb_fd_device *pdev =
 			container_of(dev, struct pcan_usb_fd_device, dev);
+	u16 usb_opts = 0;
 	int err;
 
 	/* set filter mode: all acceptance */
@@ -912,12 +969,17 @@ static int pcan_usb_fd_start(struct peak_usb_device *dev)
 		peak_usb_init_time_ref(&pdev->usb_if->time_ref,
 				       &pcan_usb_pro_fd);
 
-		/* enable USB calibration messages */
-		err = pcan_usb_fd_set_options(dev, 1,
-					      PUCAN_OPTION_ERROR,
-					      PCAN_UFD_FLTEXT_CALIBRATION);
+		/* enable USB calibration messages (needed only once for the
+		 * entire interface)
+		 */
+		usb_opts |= PCAN_UFD_FLTEXT_CALIBRATION;
 	}
 
+	/* set channel device options: always asks for bus error notifications
+	 * to get (at least) rxerr/txerr, as well as any USB-specific option.
+	 */
+	err = pcan_usb_fd_set_options(dev, 1, PUCAN_OPTION_ERROR, usb_opts);
+
 	pdev->usb_if->dev_opened_count++;
 
 	/* reset cached error counters */
@@ -955,12 +1017,15 @@ static int pcan_usb_fd_stop(struct peak_usb_device *dev)
 {
 	struct pcan_usb_fd_device *pdev =
 			container_of(dev, struct pcan_usb_fd_device, dev);
+	u16 usb_opts = 0;
 
 	/* turn off special msgs for that interface if no other dev opened */
 	if (pdev->usb_if->dev_opened_count == 1)
-		pcan_usb_fd_set_options(dev, 0,
-					PUCAN_OPTION_ERROR,
-					PCAN_UFD_FLTEXT_CALIBRATION);
+		usb_opts |= PCAN_UFD_FLTEXT_CALIBRATION;
+
+	/* turn off bus error option, as well as any USB-specific options */
+	pcan_usb_fd_set_options(dev, 0, PUCAN_OPTION_ERROR, usb_opts);
+
 	pdev->usb_if->dev_opened_count--;
 
 	return 0;
@@ -1200,7 +1265,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
+			CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1276,7 +1342,8 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 		CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+		CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
+		CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1352,7 +1419,8 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
+			CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
@@ -1428,7 +1496,8 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.ctrl_count = PCAN_USBPROFD_CHANNEL_COUNT,
 	.ctrlmode_supported = CAN_CTRLMODE_FD |
 			CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
-			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC,
+			CAN_CTRLMODE_ONE_SHOT | CAN_CTRLMODE_CC_LEN8_DLC |
+			CAN_CTRLMODE_BERR_REPORTING,
 	.clock = {
 		.freq = PCAN_UFD_CRYSTAL_HZ,
 	},
diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev/peak_canfd.h
index 056e0efa649f..bbcba2711f19 100644
--- a/include/linux/can/dev/peak_canfd.h
+++ b/include/linux/can/dev/peak_canfd.h
@@ -8,6 +8,8 @@
 #ifndef PUCAN_H
 #define PUCAN_H
 
+#include <linux/bitfield.h>
+
 /* uCAN commands opcodes list (low-order 10 bits) */
 #define PUCAN_CMD_NOP			0x000
 #define PUCAN_CMD_RESET_MODE		0x001
@@ -197,7 +199,18 @@ struct __packed pucan_rx_msg {
 #define PUCAN_ERMSG_FORM_ERROR		1
 #define PUCAN_ERMSG_STUFF_ERROR		2
 #define PUCAN_ERMSG_OTHER_ERROR		3
-#define PUCAN_ERMSG_ERR_CNT_DEC		4
+
+#define PUCAN_ERMSG_TYPE_MASK		GENMASK(6, 4)
+#define PUCAN_ERMSG_D_BIT		BIT(7)
+#define PUCAN_ERMSG_TYPE(e) \
+	FIELD_GET(PUCAN_ERMSG_TYPE_MASK, (e)->channel_type_d)
+
+#define PUCAN_ERMSG_RX(e) \
+	FIELD_GET(PUCAN_ERMSG_D_BIT, (e)->channel_type_d)
+
+#define PUCAN_ERMSG_CODE_MASK		GENMASK(6, 0)
+#define PUCAN_ERMSG_CODE(e) \
+	FIELD_GET(PUCAN_ERMSG_CODE_MASK, (e)->code_g)
 
 struct __packed pucan_error_msg {
 	__le16	size;

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20260929-peak_usb-canfd-berr-dee42c0cba00

Best regards,
--  
Stéphane Grosjean <s.grosjean@peak-system.fr>

