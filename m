Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C03B14A2;
	Sun, 30 Aug 2026 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094610; cv=none; b=ur1uQ/C3QnU9Onw5OAW8CcvaDnToqh57YgWFhQR8pE2tjTAObaP62OFkDcdEiQPXBh7ODCpyLxMoAyaea5h/byYFd9/NwxVE+RomofRlIY9LxUEQ3K7cn3ulM0KDZmaMykUrEvwfzV80sp+1mCNX7nXPX0skvL2rPDaV+8DokbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094610; c=relaxed/simple;
	bh=EYqv2UdLoOpfRHOPMtK7q1k4fVrA4/Y0nigXs2sCR8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5MomV84ilI0BVPhTTEBkkvblc95OA+zYIZUieP+BhDFor1WLnSkR2dpUa12OD7RHuPSW9pEjR6BLEc7b+ju2FsC5NyDx0l0hc6AHGaGwoUBc02Focfsdjn/sCwQYVkDARLy+mPFOnbZO8Qzy6mxf6c9MBmJwuSKdcGnziGDnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAC3wT+JKJRqd7WaBg--.22668S2;
	Sun, 30 Aug 2026 20:56:42 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Frank Jungclaus <frank.jungclaus@esd.eu>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	socketcan@esd.eu,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: esd_usb: validate receive message extents
Date: Sun, 30 Aug 2026 20:56:40 +0800
Message-ID: <20260830125640.98787-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wT+JKJRqd7WaBg--.22668S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1xKrW5Gr4xWr4DWr1UGFg_yoW5Wry5pF
	WxAF15trs8tFZxA39xZw4kAw15A3Z7Ja4xKryfG3Z3C3sIq3WUW34DKFy2qFyvkr4ak34a
	qFW7tFWUur4DJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The bulk callback reads the message command before proving that the current
URB remainder contains a header and dispatches CAN messages before checking
the declared message span. Short records can therefore be consumed before
the later position check.

Validate the common header, declared record extent, and command-specific
payload before dispatch.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/usb/esd_usb.c | 46 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index f41d4a0d140f7..1112af5d41d9c 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -482,6 +482,33 @@ static void esd_usb_tx_done_msg(struct esd_usb_net_priv *priv,
 	netif_wake_queue(netdev);
 }
 
+static bool esd_usb_rx_msg_valid(const union esd_usb_msg *msg, size_t len)
+{
+	size_t data_offset = offsetof(struct esd_usb_rx_msg, data);
+	u32 id;
+	u8 data_len;
+
+	if (msg->hdr.cmd == ESD_USB_CMD_CAN_TX)
+		return len >= sizeof(struct esd_usb_tx_done_msg);
+	if (msg->hdr.cmd != ESD_USB_CMD_CAN_RX)
+		return true;
+	if (len < data_offset)
+		return false;
+
+	id = le32_to_cpu(msg->rx.id);
+	if (id & ESD_USB_EVENT)
+		return len >= data_offset + sizeof(msg->rx.ev_can_err_ext);
+
+	if (msg->rx.dlc & ESD_USB_FD)
+		data_len = can_fd_dlc2len(msg->rx.dlc);
+	else if (msg->rx.dlc & ESD_USB_RTR)
+		data_len = 0;
+	else
+		data_len = can_cc_dlc2len(msg->rx.dlc);
+
+	return len >= data_offset + data_len;
+}
+
 static void esd_usb_read_bulk_callback(struct urb *urb)
 {
 	struct esd_usb *dev = urb->context;
@@ -507,8 +534,20 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 
 	while (pos < urb->actual_length) {
 		union esd_usb_msg *msg;
+		size_t msg_len;
+		int remaining = urb->actual_length - pos;
 
+		if (remaining < sizeof(msg->hdr)) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
 		msg = (union esd_usb_msg *)(urb->transfer_buffer + pos);
+		msg_len = msg->hdr.len * sizeof(u32);
+		if (msg_len < sizeof(msg->hdr) || msg_len > remaining ||
+		    !esd_usb_rx_msg_valid(msg, msg_len)) {
+			dev_err(dev->udev->dev.parent, "format error\n");
+			break;
+		}
 
 		switch (msg->hdr.cmd) {
 		case ESD_USB_CMD_CAN_RX:
@@ -531,12 +570,7 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			break;
 		}
 
-		pos += msg->hdr.len * sizeof(u32); /* convert to # of bytes */
-
-		if (pos > urb->actual_length) {
-			dev_err(dev->udev->dev.parent, "format error\n");
-			break;
-		}
+		pos += msg_len;
 	}
 
 resubmit_urb:

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

