Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3C395AD8;
	Fri,  2 Oct 2026 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928923; cv=pass; b=Pa7g442A5uHvPE5fLIj92D+QGgIK6NS4Gawffw8xxxTa+kMfbpU+BC9wn5P8zE2K7d4EtyJe2615Yi/NCCKNR982on8nN/3T77g9gXqIAhe5DwK5n7J8rKxKFTYgrFOrJpxLO1iFcJseXXhobUiQ6yVNgAD8NTBI3spm5LAuYK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928923; c=relaxed/simple;
	bh=vpvgp76mf8K1aO2/k3UU24h6wybclzSXpH5NwiQDWm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJGvniOIeQq2QAP7ZGJrxyrVs+D6k3nzxpztIikqqgtY8lJTtrYRSFX9xP9uJXEvrj9g/QRoJLLW0nAyWCP0pxgvnogSVVnyTeT/4MezjE4cHEIqqHlxk2NiyoUxjWH5QC4ZfPD3KV7rglyxsMma3HsXH+Hmo2NYex+5zbz7fck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=NP8xuplc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="NP8xuplc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 029F4201991;
	Fri, 02 Oct 2026 10:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+31nrR1Q5VJhzy7BOTVJQJ58oRbTuhqVZjfMt3ldyxs=;
	b=NP8xuplckHpCZKQ/iPyTDIQblOAj22zly5Q2yevXJuxKzf5s41UVSkq/QQyTaC7mNFVTiJ
	dEeuBkXKEKD5taC28tDpsZm8huKf4I0+9uAo0bMDbejR+TcWKb4X2zLIWdMfJAzeekacop
	9GJVhAo2wO1I9DguF6Sdt7/rkfEePhfrQKHKhXu8F70wXoZ5LAPw94MP42a0ZwPg/bxbda
	wayECFIOUd2WPxbLKWv8O0HB4MudaxboMl7ZhMsycl2A6pjUEF2YDHwYf1o51ovoBsuI93
	Kg7p/flT0Qpf3KXRk1ChWF0cJlZrD9ruwKJ4lDWKjlIhSP0ENBQyJNoB39t7Gg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790928911; a=rsa-sha256;
	cv=none;
	b=Ya9habF6GfnhMch79GlbOzFtjN+7DiOAr6maJ8MirQA0yIZ8vC0MOF4Aq3edKRqGSAfZH6
	hTBIoRh57QubM67pK9v4FSbyrzW2bI47R6/Rc+3xsYF1vtkq0cDPcUqIwl9a0MScn+YEi5
	31RQKhSZAZlgdPS/HSqDQxe2NKbRCEJ+2uR/z+aX75BPSMehOjAXM4SwX4NFxHb+4Mh2G5
	bLl1g66+9HiIoL64jA61jhRdM9h3AhnMJa5KEUzRVU7MyYltkUVMm6siAmQjM4drrjtHHE
	9WaQOm35/Oxngrkgw1t8kD2zEPPMKuKbyuWG6qiaW375MhEZxSR6XCb6JSFW8g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790928911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+31nrR1Q5VJhzy7BOTVJQJ58oRbTuhqVZjfMt3ldyxs=;
	b=WLevG4+9D81vEK+gAnAtcrukZAAaV9apjQJiACNefDZbdkV5y+buqCjcxzwBjAOh1HSulN
	eSHXcVco/WRznvW88kfwmcxo+23xF6yv7tWhU5sNNJr8W9QBG2K/MN3VPr/jrO7r9qU9CU
	3Sam14o11gM2juSNtPi6cG+anEu8s4II+8w1rO2yPkjQouuI3UreuK8ufL9hytWlxcNOPw
	W+ffqe47Jx1CVZgbVChyTPJwLQ4L+iuM4wWj0NJIDlJeyKl3hq4ziOXmD61BYG1kX5tm8Q
	ZdkwLDXEiWPPmvnlrRKMtpm3Wu543KEOquMhd8H+Nhh0m+2dsVi4FQ+4UaTvwA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xCYQA-003rVQ-2t;
	Fri, 02 Oct 2026 10:15:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 796F75B828E;
	Fri, 02 Oct 2026 07:55:39 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 02 Oct 2026 09:55:13 +0200
Subject: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-peak_usb_enhancements-v1-6-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
In-Reply-To: <20261002-peak_usb_enhancements-v1-0-50e965755c06@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6921; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Es3Ji303COuak8bPccHkyGLYcEroLS1hT0QpfLbXGNc=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsjan1wc5O57pyX/602WSdo+Lmf2Hj0Scryj22jDjv0/7
 +zzaZ5m31HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJOIsx/LNdsOSo27pFcQ+i
 1t1UNGNYY7ix/+rmXfPeCaukX5mjEVDIyDD1w6O3V5Ojur/++yL1veVxyF6tHG+BOmGVicVKfPe
 nT2AAAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

CAN bus error reporting is currently missing for all PEAK-System
USB-to-CAN FD devices. Add support for reporting bus errors by enabling
bus error notifications in the firmware for each CAN channel. Parsing of
the entire URB is aborted if the firmware reports an invalid channel.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 83 +++++++++++++++++++++++++++---
 include/linux/can/dev/peak_canfd.h         | 15 +++++-
 2 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 82502594a409..9081f30e3d35 100644
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
@@ -1201,6 +1266,7 @@ const struct peak_usb_adapter pcan_usb_fd = {
 	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_FD |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
@@ -1279,6 +1345,7 @@ const struct peak_usb_adapter pcan_usb_chip = {
 	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_FD |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
@@ -1357,6 +1424,7 @@ const struct peak_usb_adapter pcan_usb_pro_fd = {
 	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_FD |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
@@ -1435,6 +1503,7 @@ const struct peak_usb_adapter pcan_usb_x6 = {
 	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
 			      CAN_CTRLMODE_3_SAMPLES |
 			      CAN_CTRLMODE_ONE_SHOT |
+			      CAN_CTRLMODE_BERR_REPORTING |
 			      CAN_CTRLMODE_FD |
 			      CAN_CTRLMODE_CC_LEN8_DLC,
 	.clock = {
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

-- 
2.53.0

