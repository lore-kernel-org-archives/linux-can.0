From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 09/54] MAINTAINERS: Add file patterns for can device tree bindings
Date: Sun, 22 May 2016 11:05:46 +0200
Message-ID: <1463907991-7916-10-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63833fe6c6cee985..fedc113e17ead8bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2813,6 +2813,7 @@ W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/
 F:	drivers/net/can/
 F:	include/linux/can/dev.h
 F:	include/linux/can/platform/
-- 
1.9.1
