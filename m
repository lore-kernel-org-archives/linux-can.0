Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E0C433E9
	for <linux-can@archiver.kernel.org>; Fri, 25 Dec 2020 19:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EABB22252
	for <linux-can@archiver.kernel.org>; Fri, 25 Dec 2020 19:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLYTOU (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 25 Dec 2020 14:14:20 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:23490 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLYTOU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 25 Dec 2020 14:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1608923428;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:From:Subject:Sender;
        bh=EaTZMYup884BzWi92+HHYjKXVVZIKnErZ2yMyFuBn8s=;
        b=D8aw2eGSgRAeSclml9hoM8iGR1VpDfCNNH4cbEumId6J9u4wf9/mKEMZCoLQAbW0E8
        50Od1AlQqc2rsXgb8L8fJOOaXsxDLhQk9lY/ATTeIj/Zel+UVIytZ30MsHBkh2G6oQRK
        L0jdkr+0RR+SjUI57yG9f6ac9LzJpC64qFja/3ut+qUVnrl4Lh67ZRyyyAlFCRaLer3d
        DzdhyB3Cs+fWTLvCP48PIazjEdilYcsW0NPfGCBOqEj+Ziqe7DNLlcVLorfK7vub9yIR
        672DsOifbSP2FkY2pxyR9PdCFFAKlohxQJ6xs9qOJ6JEoChSBgitKg78NgC8tZhUrSXR
        lR0Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0lO8DsfULo/u/TWn4+x4="
X-RZG-CLASS-ID: mo00
Received: from silver.lan
        by smtp.strato.de (RZmta 47.10.7 DYNA|AUTH)
        with ESMTPSA id u00528wBPJAR3is
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 25 Dec 2020 20:10:27 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     netdev@vger.kernel.org, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH iproute2 5.11 1/2] iplink_can: add Classical CAN frame LEN8_DLC support
Date:   Fri, 25 Dec 2020 20:10:14 +0100
Message-Id: <20201225191015.3584-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The len8_dlc element is filled by the CAN interface driver and used for CAN
frame creation by the CAN driver when the CAN_CTRLMODE_CC_LEN8_DLC flag is
supported by the driver and enabled via netlink configuration interface.

Add the command line support for cc-len8-dlc for Linux 5.11+

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 ip/iplink_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
2.29.2

