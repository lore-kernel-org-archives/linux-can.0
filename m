From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 04/11] sllin: Add version dependent access to termios in tty_struct
Date: Mon, 16 Dec 2013 08:54:07 +0100
Message-ID: <1387180454-1738-5-git-send-email-alexander.stein@systec-electronic.com>
References: <2633616.0o8t6AGOQY@ws-stein>
 <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:46018 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752646Ab3LPHzy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Dec 2013 02:55:54 -0500
In-Reply-To: <1387180454-1738-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: =?UTF-8?q?Rostislav=20Lisov=C3=BD?= <lisovy@gmail.com>, Michal Sojka <sojkam1@fel.cvut.cz>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, linux-can@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sllin/sllin.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/sllin/sllin.c b/sllin/sllin.c
index 3e020b1..e05564c 100644
--- a/sllin/sllin.c
+++ b/sllin/sllin.c
@@ -62,6 +62,7 @@
 #include <linux/can.h>
 #include <linux/kthread.h>
 #include <linux/hrtimer.h>
+#include <linux/version.h>
 #include "linux/lin_bus.h"
 
 /* Should be in include/linux/tty.h */
@@ -206,22 +207,31 @@ const unsigned char sllin_id_parity_table[] = {
  */
 static int sltty_change_speed(struct tty_struct *tty, unsigned speed)
 {
-	struct ktermios old_termios;
+	struct ktermios old_termios, termios;
 	int cflag;
 
 	mutex_lock(&tty->termios_mutex);
 
-	old_termios = *(tty->termios);
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+	old_termios = termios = *(tty->termios);
+#else
+	old_termios = termios = tty->termios;
+#endif
 
 	cflag = CS8 | CREAD | CLOCAL | HUPCL;
 	cflag &= ~(CBAUD | CIBAUD);
 	cflag |= BOTHER;
-	tty->termios->c_cflag = cflag;
-	tty->termios->c_oflag = 0;
-	tty->termios->c_lflag = 0;
+	termios.c_cflag = cflag;
+	termios.c_oflag = 0;
+	termios.c_lflag = 0;
 
 	/* Enable interrupt when UART-Break or Framing error received */
-	tty->termios->c_iflag = BRKINT | INPCK;
+	termios.c_iflag = BRKINT | INPCK;
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+	*(tty->termios) = termios;
+#else
+	tty->termios = termios;
+#endif
 
 	tty_encode_baud_rate(tty, speed, speed);
 
-- 
1.8.3.2

