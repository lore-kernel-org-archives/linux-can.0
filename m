Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4648B385;
	Fri,  9 Oct 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531122; cv=none; b=XrLry7L1h4VpHua4nuZCrQ1zrNRosCi/qzN0WpYZGCEXOTRUavU5b93jfUANkWqwgc/bwVGa3qWXP1uA3PQZ7lcmviD1mqiIrKXvsPWdTVrcGsE/Ovd1yQO8B5WA0u4OzJnmPFwiw2DaBPiPETApKVKpqlrQ1THa6IVeVwTPHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531122; c=relaxed/simple;
	bh=3itJl0NxloO7ufVZJvkv3HEhzjlfPu0EeIotR1kwuBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcwEP7DXj7Sn6v9L7ghYQZU1x/FqwnjoquZXInn10tT0q3ToHrTg80SoxFUCdPAAP9og18sQ280jO1aQOxp/n1QGNrUnpuS5ZhDWHzjUF7Dlho/5yJoseAu/cTnAC3T21N8MJyTHoa6r7fhOtCsyHRMmR9dF6pXp4uGgAaWBHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=VnFUOKW8; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="VnFUOKW8"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id D7311780368;
	Fri,  9 Oct 2026 09:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791531118;
	bh=3itJl0NxloO7ufVZJvkv3HEhzjlfPu0EeIotR1kwuBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VnFUOKW8zdOicilIfWuSKHZ/P/RfWnR8JTWgmNWDAFsXPTYiZM9aWrfxHYrvKlvG3
	 Yj4HjFzbhK75gJheFJmXzDfQ9UlWQVGqDc/xepV4d0EPLq9yZFdbK+cHOWAjj4RofQ
	 MzOkAhyThioz1tt3YLksOc0V0pa1xAxBsNTQZhiNct1jQMAd9S5AKaHRPD1xDu3thZ
	 ++cIB7D2IRCSHq5PjqQcYcJvSFEQUfYfaCO35JRAVpZtY+GjZOF6Ved5k8EM9EnUJm
	 DU+2PfioK8Vd1sGuWUn939rcrAzhTsVaIMIh5MzbbWwsHLHw7F1tWZFGxr4XDHR+OB
	 LaGH6Ga/ZBjQg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Fri, 09 Oct 2026 09:30:31 +0200
Subject: [PATCH v2 4/5] can: peak_usb: validate channel numbers in PCAN-USB
 FD
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-canfd_check_channel_idx-v2-4-f7b772929791@peak-system.fr>
References: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
In-Reply-To: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
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
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 12 ++++++-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   | 52 ++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 55aad01cd8ca..751cd52cb548 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1038,7 +1038,17 @@ static void peak_usb_disconnect(struct usb_interface *intf)
 	struct peak_usb_device *dev;
 	struct peak_usb_device *dev_prev_siblings;
 
-	/* unregister as many netdev devices as siblings */
+	/* First, kill all pending RX URBs. usb_kill_anchored_urbs() waits
+	 * until all completion handlers have completed, ensuring that no
+	 * decode_buf() callback can access usb_if->dev[] after this point.
+	 */
+	for (dev = usb_get_intfdata(intf); dev; dev = dev->prev_siblings)
+		usb_kill_anchored_urbs(&dev->rx_submitted);
+
+	/* All RX URBs have been drained before reaching this point. No
+	 * decode_buf() callback can access usb_if->dev[] anymore, making it
+	 * safe to unregister and free the associated netdevs.
+	 */
 	for (dev = usb_get_intfdata(intf); dev; dev = dev_prev_siblings) {
 		struct net_device *netdev = dev->netdev;
 		char name[IFNAMSIZ];
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
index 82502594a409..71ac6fdcd99b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
@@ -60,6 +60,7 @@ struct __packed pcan_ufd_fw_info {
 
 /* handle device specific info used by the netdevices */
 struct pcan_usb_fd_if {
+	const struct peak_usb_adapter *adapter;
 	struct peak_usb_device	*dev[PCAN_USB_MAX_CHANNEL];
 	struct pcan_ufd_fw_info	fw_info;
 	struct peak_time_ref	time_ref;
@@ -536,10 +537,19 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb_fd_if *usb_if,
 	struct sk_buff *skb;
 	const u16 rx_msg_flags = le16_to_cpu(rm->flags);
 
-	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_msg_get_channel(rm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
 
 	dev = usb_if->dev[pucan_msg_get_channel(rm)];
+
+	/* This should never happen during normal operation. However, do not
+	 * trust the device and reject records targeting a valid channel
+	 * without an associated netdev.
+	 */
+	if (!dev)
+		return -EINVAL;
+
 	netdev = dev->netdev;
 
 	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
@@ -605,10 +615,19 @@ static int pcan_usb_fd_decode_status(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pucan_stmsg_get_channel(sm) >= ARRAY_SIZE(usb_if->dev))
-		return -ENOMEM;
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_stmsg_get_channel(sm) >= usb_if->adapter->ctrl_count)
+		return -EINVAL;
 
 	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
+
+	/* This should never happen during normal operation. However, do not
+	 * trust the device and reject records targeting a valid channel
+	 * without an associated netdev.
+	 */
+	if (!dev)
+		return -EINVAL;
+
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 	netdev = dev->netdev;
 
@@ -662,10 +681,19 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
 	struct pcan_usb_fd_device *pdev;
 	struct peak_usb_device *dev;
 
-	if (pucan_ermsg_get_channel(er) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pucan_ermsg_get_channel(er) >= usb_if->adapter->ctrl_count)
 		return -EINVAL;
 
 	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
+
+	/* This should never happen during normal operation. However, do not
+	 * trust the device and reject records targeting a valid channel
+	 * without an associated netdev.
+	 */
+	if (!dev)
+		return -EINVAL;
+
 	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
 
 	/* keep a trace of tx and rx error counters for later use */
@@ -685,10 +713,19 @@ static int pcan_usb_fd_decode_overrun(struct pcan_usb_fd_if *usb_if,
 	struct can_frame *cf;
 	struct sk_buff *skb;
 
-	if (pufd_omsg_get_channel(ov) >= ARRAY_SIZE(usb_if->dev))
+	/* Reject invalid channel numbers reported by the firmware */
+	if (pufd_omsg_get_channel(ov) >= usb_if->adapter->ctrl_count)
 		return -EINVAL;
 
 	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
+
+	/* This should never happen during normal operation. However, do not
+	 * trust the device and reject records targeting a valid channel
+	 * without an associated netdev.
+	 */
+	if (!dev)
+		return -EINVAL;
+
 	netdev = dev->netdev;
 
 	/* allocate an skb to store the error frame */
@@ -987,6 +1024,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
 		if (!pdev->cmd_buffer_addr)
 			goto err_out_1;
 
+		/* keep reference to the adapter device */
+		pdev->usb_if->adapter = dev->adapter;
+
 		/* number of ts msgs to ignore before taking one into account */
 		pdev->usb_if->cm_ignore_count = 5;
 

-- 
2.43.0

