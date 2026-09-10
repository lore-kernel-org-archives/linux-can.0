Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB62931CD
	for <linux-can@vger.kernel.org>; Thu, 10 Sep 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053867; cv=none; b=MA44FyfoccG/zC6BmQ7uWPmcZlHEFyOhIgDZwmbN+xkMp+Tk7roou3eBLtyb84WEJ/Qnj79/wW8EJg4HbuVehKaELH0DxgZiaZgsWe/tNmrMB5ZrZV2S/DBiL/PbHe8xSRo4Z7ZwnOPRByjfeyf4D0T0i8W0EvLGSYMsQBFpcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053867; c=relaxed/simple;
	bh=d7Q5M1vI7/120q4pHA5b5xHQjtrAs56xYi6z/xR6of0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWa0gEc6pj1nWAzFsjrLfpWYQ8K1Lz5TNzN42XVA66ujS7sFcooFTZHEGhXS6zxpMffgVzt8DwMlfnt7SzeLzx0E/pSPTfr3Cxr04zc1M+UamqPaEgdnbaGJ+sdCxodjs90DZG4aNk7BCZmNzD3CX8QOiUJg+SF/1oR39Wlp5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4NW+Iq/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4NW+Iq/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2dcff8f44f2so26044955ad.1
        for <linux-can@vger.kernel.org>; Thu, 10 Sep 2026 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053865; x=1789658665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qSoq+0T0RQWwUv3FBS9ojV1fof/Vt3X7sSwGsvkfUEI=;
        b=T4NW+Iq/vixBGsmM1hS6Hrgvvxg0rZFI6VDfgZYs3Z1F2ipUcng77CRuUu0hnqllwL
         Z52SmyEFWGGNkuP+dCn0Gl7c98fF0aU8NZhFgyubVKJFwYW16GLKSJih/U3OuEiePPUO
         rdb6+LA+HZfdLd7mfGah/MS9lNqKnUbF+XVZ1yZ3YAylPCOIYpVaADaNry/gBCssBQmc
         YmUFYOUO9dim+KoSKlN57rzWLuQSH9mqWCCRO0i8dh69naiihMNpQvonxK36jgCmudww
         67OW+VCbqjQs0qFy93lG9gniiSul7M7SP8RzaTrSk+VriTXtDVVywVF4q8qWJaihKRoQ
         jFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053865; x=1789658665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSoq+0T0RQWwUv3FBS9ojV1fof/Vt3X7sSwGsvkfUEI=;
        b=KApMOO1JVpotFGZ1Wrnr/t63c8g4b0p7jgmZ0vo+/vSMikt2Azd7DYyLYSWLl/JMX3
         iZeM2kMG8JtJa0h2kFIINbBbAscWJ1/QPqRPgg7nedGVkJXTaZdmyLpTK/YqkNLEDdfV
         YRWjas1MFKpkSsGrb12fEjSekKJJg6YVZwEm9xjMShoMYopVlRJVnxVRPJv4fejuI0Z5
         aE8VAKbA/SGBIODa7xOJRU2oKTdTfstMgTjQGLqaa5+KF/UkAxw/eWZvP/7Q2v/SWxuE
         V8aBPtu7kwUWomv/u73S15wDZ/VMFUQ/CwqfDM56BnVBWBWZwC6zXwM/I39vpabuRNue
         Fraw==
X-Gm-Message-State: AFuF++kvNRP7CIXqiAfIo0oNOz5TxH18CXlriX01icZPxSPVZZlbwr3x
	f9ToLVVL4rk7Dw9hx2VON3Q35D/jwVDUwLV4F4fqG8yP83wv1/POehwq
X-Gm-Gg: AYBFou2a9Kxakw8rtAAW2NyXqKdvF7DxaVkbBP0JQg5r/pwlzQ6LFjc0NJBnIEKuH4x
	2C6mlByAdmctEyEZbp57h4H0ewV8G6oZxS4gV2wSwDwkwGCTD3BNMT+oVEhQZbsjG95QSIgeFy/
	617QuPPaeQSYl7h+P6dnaCjoFXhNJPcwjHgXvMlnj//jxTG8G1bCKqD+kIF1IQSwDOMSDMlTY61
	/WaPrppP5CmxIIvL5fU+B7k4Hp43Db/aO4Wrxi2u96ViFSa2JM2wY3RCP3KKLf/WjBgVmudPUTu
	GJhb/3UPzOHOTJicuYO+tckq94siTOy50HT0rqOK3HjECYeHkkXyAUoFI6v1Kd4cr2xJNOQlqF1
	w7uJP3+6+Qo0VC2RCWSy3/G8YEKZEarSKSVDY1lzKnUoKtZ5JvU5DG0nJYFm4WkqJ0F6dpZZHUn
	hi3UYKgl3jBWnSWc68FgDlx9xz12Yyq4sry4P8nwcamryHcq42nLsdGz7IXcgmgIxRD2gRgby1D
	3Q/DsFlPFl3Ri5tgV9ZOodycTRWJ2Hv
X-Received: by 2002:a17:903:3803:b0:2d7:7cb:a44a with SMTP id d9443c01a7336-2db127bf3damr666893425ad.11.1789053864925;
        Thu, 10 Sep 2026 08:24:24 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db148404b8sm91545235ad.2.2026.09.10.08.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:24:24 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	co+4bda3bf8e1a2b780@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] can: peak_usb: validate PCAN-USB Pro receive lengths
Date: Thu, 10 Sep 2026 23:24:07 +0800
Message-ID: <20260910152406.3865455-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCAN-USB Pro decoder validates each receive record using the size
implied by its type, but copies CAN data using a separate device-supplied
DLC.  A zero-data record at the end of the 1024-byte RX buffer can
therefore make memcpy() read up to 15 bytes beyond the kmalloc-1k object
and write seven bytes beyond can_frame::data.

Convert the classic-CAN DLC before use and reject non-RTR records whose
converted length exceeds the payload present in that record type.  Keep
RTR records exempt from the payload check because they legitimately carry
a DLC without data.

KASAN reports:

  memcpy: detected field-spanning write (size 15) of single field "can_frame->data" at drivers/net/can/usb/peak_usb/pcan_usb_pro.c:562 (size 8)
  BUG: KASAN: slab-out-of-bounds in pcan_usb_pro_decode_buf
  Read of size 15 at addr ffff888021468800 by task swapper/0/0
  Call Trace:
   <IRQ>
   kasan_report mm/kasan/report.c:595
   kasan_check_range mm/kasan/generic.c:200
   __asan_memcpy mm/kasan/shadow.c:105
   pcan_usb_pro_decode_buf drivers/net/can/usb/peak_usb/pcan_usb_pro.c:562
   peak_usb_read_bulk_callback drivers/net/can/usb/peak_usb/pcan_usb_core.c:267
   __usb_hcd_giveback_urb drivers/usb/core/hcd.c:1657

  The buggy address is located 0 bytes to the right of
   allocated 1024-byte region [ffff888021468400, ffff888021468800)

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Reported-by: co+4bda3bf8e1a2b780@bugs.sh
Closes: https://lore.kernel.org/all/XNNBJQCVSRi1dUNtFoqHoHlP3XDSNifVcPOu%40bugs.sh/
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index b6be8c19e537f..84ebe2904f6ef 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -531,7 +531,8 @@ struct pcan_usb_pro_interface *pcan_usb_pro_dev_if(struct peak_usb_device *dev)
 }
 
 static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
-				      struct pcan_usb_pro_rxmsg *rx)
+				      struct pcan_usb_pro_rxmsg *rx,
+				      u16 sizeof_rec)
 {
 	const unsigned int ctrl_idx = (rx->len >> 4) & 0x0f;
 	struct peak_usb_device *dev;
@@ -551,7 +552,14 @@ static int pcan_usb_pro_handle_canmsg(struct pcan_usb_pro_interface *usb_if,
 		return -ENOMEM;
 
 	can_frame->can_id = le32_to_cpu(rx->id);
-	can_frame->len = rx->len & 0x0f;
+	can_frame_set_cc_len(can_frame, rx->len & 0x0f, dev->can.ctrlmode);
+
+	if (!(rx->flags & PCAN_USBPRO_RTR) &&
+	    sizeof_rec - offsetof(struct pcan_usb_pro_rxmsg, data) <
+	    can_frame->len) {
+		kfree_skb(skb);
+		return -EBADMSG;
+	}
 
 	if (rx->flags & PCAN_USBPRO_EXT)
 		can_frame->can_id |= CAN_EFF_FLAG;
@@ -750,7 +758,8 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 		case PCAN_USBPRO_RXMSG4:
 		case PCAN_USBPRO_RXMSG0:
 		case PCAN_USBPRO_RXRTR:
-			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg);
+			err = pcan_usb_pro_handle_canmsg(usb_if, &pr->rx_msg,
+							 sizeof_rec);
 			if (err < 0)
 				goto fail;
 			break;
-- 
2.55.0

