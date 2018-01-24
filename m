From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH 2/4] j1939: Documentation: use if_nametoindex instead of ifindex substitute
Date: Wed, 24 Jan 2018 12:06:57 +0100
Message-ID: <20180124110659.438-2-o.rempel@pengutronix.de>
References: <20180124110659.438-1-o.rempel@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40561 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932992AbeAXLHJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Jan 2018 06:07:09 -0500
In-Reply-To: <20180124110659.438-1-o.rempel@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, mkl@pengutronix.de
Cc: Bastian Stender <bst@pengutronix.de>

From: Bastian Stender <bst@pengutronix.de>

Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
 Documentation/networking/j1939.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/j1939.txt b/Documentation/networking/j1939.txt
index fbf0d8ae3b01..8e688cc2e1e4 100644
--- a/Documentation/networking/j1939.txt
+++ b/Documentation/networking/j1939.txt
@@ -407,7 +407,7 @@ This file contains
     struct sockaddr_can addr;
 
     memset(&addr, 0, sizeof(addr));
-    addr.can_ifindex = ifindex("can0"); // ifindex is a substitute.
+    addr.can_ifindex = if_nametoindex("can0");
     addr.can_addr.j1939.name = 0x12345678ULL;
     addr.can_addr.j1939.addr = J1939_NO_ADDR;
     addr.can_addr.j1939.pgn = J1939_NO_PGN;
-- 
2.15.1

