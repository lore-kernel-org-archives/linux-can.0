From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5/6] MAINTAINERS: linux-can moved to github
Date: Mon,  9 Mar 2015 10:36:20 +0100
Message-ID: <1425893781-10867-6-git-send-email-mkl@pengutronix.de>
References: <1425893781-10867-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50362 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbbCIJgz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Mar 2015 05:36:55 -0400
In-Reply-To: <1425893781-10867-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>

As gitorious will shut down at the end of May 2015, the linux-can website moved
to github. This patch reflects this change.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42f686f2e4b2..ce4380d7ab1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2370,7 +2370,7 @@ F:	arch/x86/include/asm/tce.h
 CAN NETWORK LAYER
 M:	Oliver Hartkopp <socketcan@hartkopp.net>
 L:	linux-can@vger.kernel.org
-W:	http://gitorious.org/linux-can
+W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 S:	Maintained
@@ -2386,7 +2386,7 @@ CAN NETWORK DRIVERS
 M:	Wolfgang Grandegger <wg@grandegger.com>
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
 L:	linux-can@vger.kernel.org
-W:	http://gitorious.org/linux-can
+W:	https://github.com/linux-can
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
 S:	Maintained
-- 
2.1.4

