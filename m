Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862964582E3;
	Thu,  8 Oct 2026 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451506; cv=none; b=M+R4dAfE/30xOcRBZcun0vrURgPzaTFiBzk8yt9U/AjUZhgIuwpbgc+XG8tran9LEhIdcUAkN+jYYX2Y+19CXq1rxLRQsNuDlWJhBpopnjw+wRSy6efd6WXjGgE/FJd0WRMpKDUoYOXNKbfOHnchXmchn3hPL8i1SwbtUJshW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451506; c=relaxed/simple;
	bh=z06FNvXXXS4jXoEfu9mmkKXXS6JOcNeKOHrmgP+kAjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtOxN55jXWoYy81VCQmrGjTOXxQ50Ca2+mGECOS6rVzut1W+tq5j2mAQkG1csHR0ai/AHNa2gOlNbzkrSj9GhWnYn8M2eWTDeInxQWPwBe3g3v6c/qzEZdcbQChiz6vIYRlSGZa01CHJgP7VTozzd/vulM4YUYcv9VSVEXrXuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=fIofYQk5; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="fIofYQk5"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 1C9E4780331;
	Thu,  8 Oct 2026 11:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791451499;
	bh=z06FNvXXXS4jXoEfu9mmkKXXS6JOcNeKOHrmgP+kAjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fIofYQk5FMXzrMFNCgKqd0p9/5pWFA1V6CnxmxMjpYEM3nbEUEoON7Agd3zC2tx0k
	 BGNtnALguu8CfIcc8U28/piCGcFqaLd4ptshyEr3bNPRy93pBlLsKHOE2JK9WgrVi6
	 unRU7CroFCT5hDOwUTG4wsP8kPbQcEir8ezj9iNvd5EjS2D0/uLW4D4GFgGVoG7lm5
	 T7x2NI70JcahQJUYV6ayMHr8dotMTrGDNsViCsFvN4LEz3iHeh4Jgf5jpnZDaL9JSd
	 +99pCJbeswp191HWBWNy0a0T/4JssyLhekk+gtegrtPvlSPnM35pNef0q00hUMpyRF
	 +A1tOrY4ZnrHA==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Thu, 08 Oct 2026 11:14:58 +0200
Subject: [PATCH 4/5] can: peak_usb: validate channel numbers in PCAN-USB FD
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-canfd_check_channel_idx-v1-4-0a3bb82f4e09@peak-system.fr>
References: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
In-Reply-To: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.16.0

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PCAN-USB FD family encodes the CAN channel number in messages
received from the device. This value is used as an index into the
adapter CAN device table.

Validate the channel number against the number of CAN controllers
supported by the adapter before performing the lookup. Any message
containing an invalid channel number is treated as malformed and the
entire message buffer is discarded, as the device is considered to be
providing untrusted data.

Additionally, return -EINVAL instead of -ENOMEM when an invalid
channel number is detected, making the error reporting consistent
with the rest of the driver.

This prevents potential out-of-bounds accesses when handling
unexpected or corrupted messages received from PCAN-USB FD family
devices.

Fixes: a6921dd524fe ("can: peak_usb: add range checking in decode operations")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 32 ++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 82502594a409..ddbb2be1de0d 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -60,6 +60,7 @@ struct __packed pcan_ufd_fw_info {
 
 /* handle device specific info used by the netdevices */
 struct pcan_usb_fd_if {
+	const struct peak_usb_adapter *adapter;
 	struct peak_usb_device	*dev[PCAN_USB_MAX_CHANNEL];
 	struct pcan_ufd_fw_info	fw_info;
 	struct peak_time_ref	time_ref;
@@ -536,8 +537,12 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	struct sk_buff *skb;
 	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
 
-	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware.
+	 * Any channel below ctrl_count is guaranteed to have a valid
+	 * entry in usb_if->dev[].
+	 */
+	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
 
 	dev = usb_if->dev[pucan_msg_get_channel(rm)];
 	netdev = dev->netdev;
@@ -605,8 +610,12 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pucan_stmsg_get_channel(sm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware.
+	 * Any channel below ctrl_count is guaranteed to have a valid
+	 * entry in usb_if->dev[].
+	 */
+	if (pucan_stmsg_get_channel(sm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
 
 	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
@@ -662,7 +671,11 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	struct pcan_usb_fd_device *pdev;
 	struct peak_usb_device *dev;
 
-	if (pucan_ermsg_get_channel(er) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware.
+	 * Any channel below ctrl_count is guaranteed to have a valid
+	 * entry in usb_if->dev[].
+	 */
+	if (pucan_ermsg_get_channel(er) >= usb_if->adapter->ctrl_count)
 		return -EINVAL;
 
 	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
@@ -685,7 +698,11 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pufd_omsg_get_channel(ov) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware.
+	 * Any channel below ctrl_count is guaranteed to have a valid
+	 * entry in usb_if->dev[].
+	 */
+	if (pufd_omsg_get_channel(ov) >= usb_if->adapter->ctrl_count)
 		return -EINVAL;
 
 	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
@@ -987,6 +1004,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		if (!pdev->cmd_buffer_addr)
 			goto err_out_1;
 
+		/* keep reference to the adapter device */
+		pdev->usb_if->adapter = dev->adapter;
+
 		/* number of ts msgs to ignore before taking one into account */
 		pdev->usb_if->cm_ignore_count = 5;
 

-- 
2.43.0

