From: Shawn Landden <shawn@churchofgit.com>
Subject: [PATCH] can.h: make padding given by gcc explicit
Date: Fri,  1 May 2015 12:54:20 -0700
Message-ID: <1430510060-3504-1-git-send-email-shawn@churchofgit.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33023 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbbEATy2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 May 2015 15:54:28 -0400
Received: by pacwv17 with SMTP id wv17so99711955pac.0
        for <linux-can@vger.kernel.org>; Fri, 01 May 2015 12:54:28 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Shawn Landden <shawn@churchofgit.com>

The current definition of struct can_frame has a 16-byte size, with 8-byte
alignment, but the 3 bytes of padding are not explicit like the similar 2 bytes
of padding of struct canfd_frame. Make it explicit so it is easier to read.

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 include/uapi/linux/can.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 41892f7..bc1b937 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -100,6 +100,7 @@ typedef __u32 can_err_mask_t;
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
 	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
+        __u8    __res[3];/* reserved / padding */
 	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 
-- 
2.2.1.209.g41e5f3a

