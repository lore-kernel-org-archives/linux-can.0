Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3212CDA5;
	Sun, 30 Aug 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788098389; cv=none; b=eJchkyZmmAHLpQJ5x3RTw7Qy/7dlZqc1bEoFLy3fwz0zPxe2DJbWKRhcq6e2uyMC5W3pxM88CfjTedtvrE5D8YuXwPng9AhKU17gCbLKo/lmnSMeEfCtt63Tki5KOk0mFUai0lpSwyZeHktuHAXE48nnqBY2+Til8zIzpgt+ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788098389; c=relaxed/simple;
	bh=1fEum+nuLHGKBGXcL+057a6KHjjyloEIiKj/wsDJYak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6Qz5nnxC8PIITldEUIz5ogghqSCbsNnekOHHCqktISGvnb/2j65dutlKsARoPi01SgCJ/QGmbC83kGJ/id3q8k9SuugLlA8s+UdgBnpqKCrQHQLlob0qiKpRQn7EKvcIkVnc9hnRkCmbb0h9CULJjkc5Kd63A9bZL8jYeXlqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAC3wD5QN5RqknObBg--.17412S2;
	Sun, 30 Aug 2026 21:59:45 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: peak_usb: validate response and receive record extents
Date: Sun, 30 Aug 2026 21:59:42 +0800
Message-ID: <20260830135942.19449-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAC3wD5QN5RqknObBg--.17412S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43tFWDKrWDCFy5WF17KFg_yoW5GF4kpF
	4FyFy3tr4Utr4xJwn7trs5A3W5J3WDJFyIkr9rXw1Ygw4aqwn7Wry8GFySvFZ7Xr43Xr1I
	v3WUXr18C3W8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj2YLD
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

Both PCAN-USB Pro record walkers read data_type before proving that a
record header remains, and the synchronous response walker advances by a
declared record size without bounding it by actual_length.

Require the type byte and complete declared record in both command-
response and receive paths before dispatch or pointer advancement.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index b6be8c19e537f..aaa5f4f7db191 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -244,6 +244,7 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	for (i = 0; !err && i < PCAN_USBPRO_RSP_SUBMIT_MAX; i++) {
 		struct pcan_usb_pro_msg rsp;
 		union pcan_usb_pro_rec *pr;
+		u8 *msg_end;
 		u32 r, rec_cnt;
 		u16 rec_len;
 		u8 *pc;
@@ -270,11 +271,18 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 
 		pc = pcan_msg_init(&rsp, pum->u.rec_buffer,
 			actual_length);
+		msg_end = pum->u.rec_buffer + actual_length;
 
 		rec_cnt = le32_to_cpu(*rsp.u.rec_cnt);
 
 		/* loop on records stored into message */
 		for (r = 0; r < rec_cnt; r++) {
+			if (pc >= msg_end) {
+				netdev_err(dev->netdev,
+					   "record header exceeds response\n");
+				break;
+			}
+
 			pr = (union pcan_usb_pro_rec *)pc;
 			rec_len = pcan_usb_pro_sizeof_rec[pr->data_type];
 			if (!rec_len) {
@@ -284,6 +292,11 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 					      actual_length);
 				break;
 			}
+			if (rec_len > msg_end - pc) {
+				netdev_err(dev->netdev,
+					   "record exceeds response\n");
+				break;
+			}
 
 			/* check if response corresponds to request */
 			if (pr->data_type != req_data_type)
@@ -727,7 +740,14 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	msg_end = urb->transfer_buffer + urb->actual_length;
 	rec_cnt = le16_to_cpu(*usb_msg.u.rec_cnt_rd);
 	for (; rec_cnt > 0; rec_cnt--) {
-		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
+		union pcan_usb_pro_rec *pr;
+
+		if (rec_ptr >= msg_end) {
+			err = -EBADMSG;
+			break;
+		}
+
+		pr = (union pcan_usb_pro_rec *)rec_ptr;
 		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
 
 		if (!sizeof_rec) {

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

