From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] MAINTAINERS: Add can-gw include to maintained files
Date: Wed, 02 Nov 2011 21:55:13 +0100
Message-ID: <4EB1AE31.3080305@hartkopp.net>
References: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1318506157-10329-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Commit c1aabdf379bc2feeb0df7057ed5bad96f492133e (can-gw: add netlink based
CAN routing) added a new include file that's neither referenced by any of
the CAN maintainers.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 479beaa..abeb3f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1716,6 +1716,7 @@ F:	include/linux/can.h
 F:	include/linux/can/core.h
 F:	include/linux/can/bcm.h
 F:	include/linux/can/raw.h
+F:	include/linux/can/gw.h

 CAN NETWORK DRIVERS
 M:	Wolfgang Grandegger <wg@grandegger.com>
