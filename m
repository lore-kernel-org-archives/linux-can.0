From: Shawn Landden <shawn@churchofgit.com>
Subject: [PATCH] can.h: make padding given by gcc explicit
Date: Tue,  5 May 2015 09:07:16 -0700
Message-ID: <1430842036-21509-1-git-send-email-shawn@churchofgit.com>
References: <554797BA.6080506@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35413 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbEEQIe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 May 2015 12:08:34 -0400
Received: by pdbqd1 with SMTP id qd1so200900151pdb.2
        for <linux-can@vger.kernel.org>; Tue, 05 May 2015 09:08:34 -0700 (PDT)
In-Reply-To: <554797BA.6080506@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Shawn Landden <shawn@churchofgit.com>

The current definition of struct can_frame has a 16-byte size, with 8-byte
alignment, but the 3 bytes of padding are not explicit like the similar 2 bytes
of padding of struct canfd_frame. Make it explicit so it is easier to read.

v2: match analogous padding fields in canfd_frame
    update Documentation

Signed-off-by: Shawn Landden <shawn@churchofgit.com>
---
 Documentation/networking/can.txt | 3 +++
 include/uapi/linux/can.h         | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/networking/can.txt b/Documentation/networking/can.txt
index 5abad1e..b48d4a1 100644
--- a/Documentation/networking/can.txt
+++ b/Documentation/networking/can.txt
@@ -268,6 +268,9 @@ solution for a couple of reasons:
     struct can_frame {
             canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
             __u8    can_dlc; /* frame payload length in byte (0 .. 8) */
+            __u8    __pad;   /* padding */
+            __u8    __res0;  /* reserved / padding */
+            __u8    __res1;  /* reserved / padding */
             __u8    data[8] __attribute__((aligned(8)));
     };
 
diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 41892f7..9692cda 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -95,11 +95,17 @@ typedef __u32 can_err_mask_t;
  * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
  *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
  *           mapping of the 'data length code' to the real payload length
+ * @__pad:   padding
+ * @__res0:  reserved / padding
+ * @__res1:  reserved / padding
  * @data:    CAN frame payload (up to 8 byte)
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
 	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
+	__u8    __pad;   /* padding */
+	__u8    __res0;  /* reserved / padding */
+	__u8    __res1;  /* reserved / padding */
 	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 
-- 
2.2.1.209.g41e5f3a

