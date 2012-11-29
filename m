From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4/5] can: Kconfig: remove 'default n' from CAN_BCM and CAN_GW
Date: Thu, 29 Nov 2012 14:58:10 +0100
Message-ID: <1354197491-31205-5-git-send-email-mkl@pengutronix.de>
References: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42781 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab2K2N6O (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 08:58:14 -0500
In-Reply-To: <1354197491-31205-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

As 'default n' is already default, remove it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/Kconfig |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/can/Kconfig b/net/can/Kconfig
index c017121..0d52416 100644
--- a/net/can/Kconfig
+++ b/net/can/Kconfig
@@ -30,7 +30,6 @@ config CAN_RAW
 
 config CAN_BCM
 	tristate "Broadcast Manager CAN Protocol (with content filtering)"
-	default N
 	---help---
 	  The Broadcast Manager offers content filtering, timeout monitoring,
 	  sending of RTR frames, and cyclic CAN messages without permanent user
@@ -42,7 +41,6 @@ config CAN_BCM
 
 config CAN_GW
 	tristate "CAN Gateway/Router (with netlink configuration)"
-	default N
 	---help---
 	  The CAN Gateway/Router is used to route (and modify) CAN frames.
 	  It is based on the PF_CAN core infrastructure for msg filtering and
-- 
1.7.10.4

