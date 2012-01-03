From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] CAN MAINTAINERS update
Date: Tue, 03 Jan 2012 19:40:28 +0100
Message-ID: <4F034B9C.2030106@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:32320 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2ACSki (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Jan 2012 13:40:38 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux Netdev List <netdev@vger.kernel.org>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <oliver.hartkopp@volkswagen.de>, Urs Thuermann <urs.thuermann@volkswagen.de>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>

Update the CAN MAINTAINERS section:

- point out active maintainers
- pull the CAN driver discussion away from netdev ML
- point to the new CAN web site on gitorious.org
- add CAN development git repository URL to submit patches

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

CC: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
CC: Urs Thuermann <urs.thuermann@volkswagen.de>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: linux-can@vger.kernel.org

---

Hello Dave,

this is the updated MAINTAINERS section for the CAN subsystem.

As Marc Kleine-Budde will send upcoming git pull requests we discussed, if we
would need an additional section like this ...

NETWORKING [CAN]
M:	Marc Kleine-Budde <mkl@pengutronix.de>
L:	linux-can@vger.kernel.org
W:	http://gitorious.org/linux-can
T:	git://gitorious.org/linux-can/linux-can-next.git
S:	Maintained
F:	net/can/
F:	drivers/net/can/
F:	include/linux/can*

to make sure for you, who's sending the pull requests ...

Is this really needed or is it ok for you like it is below?

Regards,
Oliver


diff --git a/MAINTAINERS b/MAINTAINERS
index dbf3d94..59ce369 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1698,11 +1698,9 @@ F:	arch/x86/include/asm/tce.h

 CAN NETWORK LAYER
 M:	Oliver Hartkopp <socketcan@hartkopp.net>
-M:	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
-M:	Urs Thuermann <urs.thuermann@volkswagen.de>
 L:	linux-can@vger.kernel.org
-L:	netdev@vger.kernel.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
+T:	git://gitorious.org/linux-can/linux-can-next.git
 S:	Maintained
 F:	net/can/
 F:	include/linux/can.h
@@ -1713,9 +1711,10 @@ F:	include/linux/can/gw.h

 CAN NETWORK DRIVERS
 M:	Wolfgang Grandegger <wg@grandegger.com>
+M:	Marc Kleine-Budde <mkl@pengutronix.de>
 L:	linux-can@vger.kernel.org
-L:	netdev@vger.kernel.org
-W:	http://developer.berlios.de/projects/socketcan/
+W:	http://gitorious.org/linux-can
+T:	git://gitorious.org/linux-can/linux-can-next.git
 S:	Maintained
 F:	drivers/net/can/
 F:	include/linux/can/dev.h

