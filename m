Return-Path: <SRS0=+ffn=ED=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74496C55179
	for <linux-can@archiver.kernel.org>; Wed, 28 Oct 2020 21:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE1E24680
	for <linux-can@archiver.kernel.org>; Wed, 28 Oct 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SVi2Czi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgJ1VkB (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:40:01 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:27562 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgJ1VkA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 28 Oct 2020 17:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603921196;
        s=strato-dkim-0002; d=hartkopp.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+EwYHsyP/ujanmkr16VmrZcP5N+3A2Gh/sBGP7WiYdY=;
        b=SVi2Czi9u9mWkTOS4NwQlkVEF02xX12+3XW+Q7eN5J6JkZdlU7xlpeybcArSViV/WH
        O42KKVxPvHV0+6sGNwfwb7iDO0XpSnPMorrfn5LCJHZjy2JcgxC0ZcEGOMRnv0hWG8K0
        WTycY4aHPkQeN6kTLYLUjTptR4itGGdtp+7jDJUEqHLAcVvDGevo5b53KfctZ0BzLyyh
        iuYMWPjQQSe1TLJqTYhnyrYwPSui8rasgrapb7P65cVl9ANRNEpo2PjykFMqBAUMqcxo
        fQHVW1w6e9LQQpw/cRd5XJiPv0BCSiqQsU6mR3PZs+PSIt7dQxz0WZGxH2N9/M3y4zNO
        d5Ig==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3UIh9dyKNLCWJaRrQ0pDCeGtVbNHMQ98lI/DcPKMT"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 47.2.3 AUTH)
        with ESMTPSA id J01b14w9SI9v1qQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 28 Oct 2020 19:09:57 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 1/4] can: add optional DLC element to Classical CAN frame structure
Date:   Wed, 28 Oct 2020 19:09:37 +0100
Message-Id: <20201028180940.2071-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028180940.2071-1-socketcan@hartkopp.net>
References: <20201028180940.2071-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

ISO 11898-1 Chapter 8.4.2.3 defines a 4 bit data length code (DLC) table which
maps the DLC to the payload length of the CAN frame in bytes:

    DLC      ->  payload length
    0 .. 8   ->  0 .. 8
    9 .. 15  ->  8

Although the DLC values 8 .. 15 in Classical CAN always result in a payload
length of 8 bytes these DLC values are transparently transmitted on the CAN
bus. As the struct can_frame only provides a 'len' element (formerly 'can_dlc')
which contains the plain payload length ( 0 .. 8 ) of the CAN frame, the raw
DLC is not visible to the application programmer, e.g. for testing use-cases.

To access the raw DLC values 9 .. 15 the len8_dlc element is introduced, which
is only valid when the payload length 'len' is 8 and the DLC is greater than 8.

The len8_dlc element is filled by the CAN interface driver and used for CAN
frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC flag is
supported by the driver and enabled via netlink configuration interface.

Reported-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h         | 36 ++++++++++++++++++++------------
 include/uapi/linux/can/netlink.h |  1 +
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index 6a6d2c7655ff..b131617d60ae 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -82,34 +82,44 @@ typedef __u32 canid_t;
  */
 typedef __u32 can_err_mask_t;
 
 /* CAN payload length and DLC definitions according to ISO 11898-1 */
 #define CAN_MAX_DLC 8
+#define CAN_MAX_RAW_DLC 15
 #define CAN_MAX_DLEN 8
 
 /* CAN FD payload length and DLC definitions according to ISO 11898-7 */
 #define CANFD_MAX_DLC 15
 #define CANFD_MAX_DLEN 64
 
 /**
  * struct can_frame - basic CAN frame structure
- * @can_id:  CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
- * @can_dlc: frame payload length in byte (0 .. 8) aka data length code
- *           N.B. the DLC field from ISO 11898-1 Chapter 8.4.2.3 has a 1:1
- *           mapping of the 'data length code' to the real payload length
- * @__pad:   padding
- * @__res0:  reserved / padding
- * @__res1:  reserved / padding
- * @data:    CAN frame payload (up to 8 byte)
+ * @can_id:   CAN ID of the frame and CAN_*_FLAG flags, see canid_t definition
+ * @len:      CAN frame payload length in byte (0 .. 8)
+ * @can_dlc:  deprecated name for CAN frame payload length in byte (0 .. 8)
+ * @__pad:    padding
+ * @__res0:   reserved / padding
+ * @len8_dlc: optional DLC value (9 .. 15) at 8 byte payload length
+ *            len8_dlc contains values from 9 .. 15 when the payload length is
+ *            8 bytes but the DLC value (see ISO 11898-1) is greater then 8.
+ *            CAN_CTRLMODE_CC_LEN8_DLC flag has to be enabled in CAN driver.
+ * @data:     CAN frame payload (up to 8 byte)
  */
 struct can_frame {
 	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
-	__u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
-	__u8    __pad;   /* padding */
-	__u8    __res0;  /* reserved / padding */
-	__u8    __res1;  /* reserved / padding */
-	__u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
+	union {
+		/* CAN frame payload length in byte (0 .. CAN_MAX_DLEN)
+		 * was previously named can_dlc so we need to carry that
+		 * name for legacy support
+		 */
+		__u8 len;
+		__u8 can_dlc; /* deprecated */
+	};
+	__u8 __pad; /* padding */
+	__u8 __res0; /* reserved / padding */
+	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
+	__u8 data[CAN_MAX_DLEN] __attribute__((aligned(8)));
 };
 
 /*
  * defined bits for canfd_frame.flags
  *
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 6f598b73839e..f730d443b918 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -98,10 +98,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
 #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
 #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
+#define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 
 /*
  * CAN device statistics
  */
 struct can_device_stats {
-- 
2.28.0

