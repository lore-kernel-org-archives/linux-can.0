From: =?UTF-8?q?Thomas=20K=C3=B6rper?= <thomas.koerper@esd.eu>
Subject: [PATCH 1/1] can: esd_usb2: Fix sparse warnings
Date: Mon, 16 Mar 2015 09:48:29 +0100
Message-ID: <1426495709-10810-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu01.htp-tel.de ([81.14.242.8]:63290 "EHLO mxuout01.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbbCPJEO (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 Mar 2015 05:04:14 -0400
Received: from mxuin02.htp-tel.de (a81-14-242-29.net-htp.de [81.14.242.29])
        by mxuout01.htp-tel.de with ESMTPS id t2G8mfXw020764
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2015 09:48:41 +0100 (CET)
Received: from esd-s3.esd.eu (a81-14-233-218.net-htp.de [81.14.233.218])
        by mxuin02.htp-tel.de with ESMTP id t2G8mfif010122
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-can@vger.kernel.org>; Mon, 16 Mar 2015 09:48:41 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20K=C3=B6rper?= <thomas.koerper@esd.eu>

The hnd field of the structs does not need to be __le32: the
device just returns the value without using it itself.

Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
---
 drivers/net/can/usb/esd_usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_u=
sb2.c
index bacca0b..e4dc936 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -139,7 +139,7 @@ struct tx_msg {
 	u8 cmd;
 	u8 net;
 	u8 dlc;
-	__le32 hnd;
+	u32 hnd;
 	__le32 id; /* upper 3 bits contain flags */
 	u8 data[8];
 };
@@ -149,7 +149,7 @@ struct tx_done_msg {
 	u8 cmd;
 	u8 net;
 	u8 status;
-	__le32 hnd;
+	u32 hnd;
 	__le32 ts;
 };
=20
--=20
2.3.1

