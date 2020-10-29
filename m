Return-Path: <SRS0=J6wA=EE=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A972C2D0A3
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D0520757
	for <linux-can@archiver.kernel.org>; Thu, 29 Oct 2020 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="D1/MG7OI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgJ2Ide (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 29 Oct 2020 04:33:34 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:13466 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgJ2Idd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Oct 2020 04:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603960412;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=K/q7mUA/hDOdgthRfjDfmhgXgQRth7ihvzMGL+VGKv0=;
        b=D1/MG7OIj6spzge9hMrJ8B2iFMOmuK+tbW7J8gRDP9EXtmn3QIA7KaSmoV0tKA0u/i
        4j8rj5ecdqUnP1BvalXfuIJOnwOqj5+SiQ49meIl0HSEMeVAjxnsSlX7vKderkJ8xQ0b
        A3PHcJjtM/lTAVVArH+rpYzIwcgRB+OwGHOfTaaZg8yU64W6i8m1SpjI4gQGnZccpIpl
        jmyUfjy9KgLWS+mAIZSq6YgePDI2lU0D7QzT3/YpP3ERDQ5qSmf5BtnEzG6+TLcd6NCD
        3WypwFQ0dfWuqe5v6EnirWdBpLSqTCGsJE4shGWxh+Lz6Q07bZlvAXtR0K2s9WToq+4N
        wD2g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVIDM8sC/W"
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bew9T8XV0WJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 29 Oct 2020 09:33:31 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     mkl@pengutronix.de, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH testing-only] iplink_can: support len8_dlc for Classical CAN
Date:   Thu, 29 Oct 2020 09:33:26 +0100
Message-Id: <20201029083326.41627-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

In a final version the include file update gets upstreamed separately.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/netlink.h | 1 +
 ip/iplink_can.c                  | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 7159dc67..00c763df 100644
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
diff --git a/ip/iplink_can.c b/ip/iplink_can.c
index 735ab941..6a26f3ff 100644
--- a/ip/iplink_can.c
+++ b/ip/iplink_can.c
@@ -35,10 +35,11 @@ static void print_usage(FILE *f)
 		"\t[ one-shot { on | off } ]\n"
 		"\t[ berr-reporting { on | off } ]\n"
 		"\t[ fd { on | off } ]\n"
 		"\t[ fd-non-iso { on | off } ]\n"
 		"\t[ presume-ack { on | off } ]\n"
+		"\t[ cc-len8-dlc { on | off } ]\n"
 		"\n"
 		"\t[ restart-ms TIME-MS ]\n"
 		"\t[ restart ]\n"
 		"\n"
 		"\t[ termination { 0..65535 } ]\n"
@@ -101,10 +102,11 @@ static void print_ctrlmode(FILE *f, __u32 cm)
 	_PF(CAN_CTRLMODE_ONE_SHOT, "ONE-SHOT");
 	_PF(CAN_CTRLMODE_BERR_REPORTING, "BERR-REPORTING");
 	_PF(CAN_CTRLMODE_FD, "FD");
 	_PF(CAN_CTRLMODE_FD_NON_ISO, "FD-NON-ISO");
 	_PF(CAN_CTRLMODE_PRESUME_ACK, "PRESUME-ACK");
+	_PF(CAN_CTRLMODE_CC_LEN8_DLC, "CC-LEN8-DLC");
 #undef _PF
 	if (cm)
 		print_hex(PRINT_ANY, NULL, "%x", cm);
 	close_json_array(PRINT_ANY, "> ");
 }
@@ -209,10 +211,14 @@ static int can_parse_opt(struct link_util *lu, int argc, char **argv,
 				     CAN_CTRLMODE_FD_NON_ISO);
 		} else if (matches(*argv, "presume-ack") == 0) {
 			NEXT_ARG();
 			set_ctrlmode("presume-ack", *argv, &cm,
 				     CAN_CTRLMODE_PRESUME_ACK);
+		} else if (matches(*argv, "cc-len8-dlc") == 0) {
+			NEXT_ARG();
+			set_ctrlmode("cc-len8-dlc", *argv, &cm,
+				     CAN_CTRLMODE_CC_LEN8_DLC);
 		} else if (matches(*argv, "restart") == 0) {
 			__u32 val = 1;
 
 			addattr32(n, 1024, IFLA_CAN_RESTART, val);
 		} else if (matches(*argv, "restart-ms") == 0) {
-- 
2.28.0

