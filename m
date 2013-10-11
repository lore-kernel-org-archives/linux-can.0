From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: BerliOS shutdown? - Fwd: r1278 - branches tags trunk
Date: Fri, 11 Oct 2013 18:10:46 +0200
Message-ID: <52582306.3070006@hartkopp.net>
References: <20131011152958.914C955B0C@scm.berlios.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:24171 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433Ab3JKQKt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Oct 2013 12:10:49 -0400
In-Reply-To: <20131011152958.914C955B0C@scm.berlios.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Yegor Yefremov <yegorslists@googlemail.com>

Hi Marc,

according to this G+ post from Yegor

	https://plus.google.com/111984225231618981770/posts/DcC7deT95zF

I updated some descriptions on the obsolete BerliOS project site and added
text files to the SVN and the released files section pointing to gitorious.

I'm unsure if we finally should shut down the SVN or not.

Thinking about this: There's still something missing on gitorious:

Can you please move the stuff from socketcan/trunk/test to
https://gitorious.org/linux-can/can-misc/test if you find some time?

Tnx,
Oliver


-------- Original Message --------
Subject: r1278 - branches tags trunk
Date: Fri, 11 Oct 2013 17:29:58 +0200
From: hartkopp@berlios.de
To: socketcan-commit@lists.berlios.de

Author: hartkopp
Date: 2013-10-11 17:29:58 +0200 (Fri, 11 Oct 2013)
New Revision: 1278

Added:
   branches/README-new-project-site
   tags/README-new-project-site
   trunk/README-new-project-site
Log:
Add README files to mark the BerliOS SocketCAN SVN as obsolete.

###

SocketCAN has become the official Linux CAN subsystem as part of Mainline
Linux since Kernel 2.6.25 (2008-04-17)

THE PROJECT DEVELOPMENT HAS MOVED TO https://gitorious.org/linux-can

THE CAN-UTILS CAN BE FOUND AT https://gitorious.org/linux-can/can-utils

THE MAILING LIST IS NOW ON http://vger.kernel.org/vger-lists.html#linux-can

SEE MAIL ARCHIVES AT http://dir.gmane.org/gmane.linux.can AND
http://marc.info/?l=linux-can

---

Socket-CAN provides an API for CAN devices based on BSD sockets.

###



Added: branches/README-new-project-site
===================================================================
--- branches/README-new-project-site	                        (rev 0)
+++ branches/README-new-project-site	2013-10-11 15:29:58 UTC (rev 1278)
@@ -0,0 +1,13 @@
+SocketCAN has become the official Linux CAN subsystem as part of Mainline
Linux since Kernel 2.6.25 (2008-04-17)
+
+THE PROJECT DEVELOPMENT HAS MOVED TO https://gitorious.org/linux-can
+
+THE CAN-UTILS CAN BE FOUND AT https://gitorious.org/linux-can/can-utils
+
+THE MAILING LIST IS NOW ON http://vger.kernel.org/vger-lists.html#linux-can
+
+SEE MAIL ARCHIVES AT http://dir.gmane.org/gmane.linux.can AND
http://marc.info/?l=linux-can
+
+---
+
+Socket-CAN provides an API for CAN devices based on BSD sockets.
\ No newline at end of file

Added: tags/README-new-project-site
===================================================================
--- tags/README-new-project-site	                        (rev 0)
+++ tags/README-new-project-site	2013-10-11 15:29:58 UTC (rev 1278)
@@ -0,0 +1,13 @@
+SocketCAN has become the official Linux CAN subsystem as part of Mainline
Linux since Kernel 2.6.25 (2008-04-17)
+
+THE PROJECT DEVELOPMENT HAS MOVED TO https://gitorious.org/linux-can
+
+THE CAN-UTILS CAN BE FOUND AT https://gitorious.org/linux-can/can-utils
+
+THE MAILING LIST IS NOW ON http://vger.kernel.org/vger-lists.html#linux-can
+
+SEE MAIL ARCHIVES AT http://dir.gmane.org/gmane.linux.can AND
http://marc.info/?l=linux-can
+
+---
+
+Socket-CAN provides an API for CAN devices based on BSD sockets.
\ No newline at end of file

Added: trunk/README-new-project-site
===================================================================
--- trunk/README-new-project-site	                        (rev 0)
+++ trunk/README-new-project-site	2013-10-11 15:29:58 UTC (rev 1278)
@@ -0,0 +1,13 @@
+SocketCAN has become the official Linux CAN subsystem as part of Mainline
Linux since Kernel 2.6.25 (2008-04-17)
+
+THE PROJECT DEVELOPMENT HAS MOVED TO https://gitorious.org/linux-can
+
+THE CAN-UTILS CAN BE FOUND AT https://gitorious.org/linux-can/can-utils
+
+THE MAILING LIST IS NOW ON http://vger.kernel.org/vger-lists.html#linux-can
+
+SEE MAIL ARCHIVES AT http://dir.gmane.org/gmane.linux.can AND
http://marc.info/?l=linux-can
+
+---
+
+Socket-CAN provides an API for CAN devices based on BSD sockets.
\ No newline at end of file

_______________________________________________
Socketcan-commit mailing list
Socketcan-commit@lists.berlios.de
https://lists.berlios.de/mailman/listinfo/socketcan-commit


