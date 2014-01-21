From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 07/10] include: can.h: remove unused include of version.h
Date: Tue, 21 Jan 2014 14:00:01 +0100
Message-ID: <1390309204-19854-8-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44838 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbaAUNAL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:11 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch remove the include of version.h, as it's not used.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 2f77ab3..5802cb3 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -13,7 +13,6 @@
 #ifndef CAN_H
 #define CAN_H
 
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/socket.h>
 
-- 
1.8.5.2

