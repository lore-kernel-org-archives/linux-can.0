From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 08/10] include: can.h: update comment about introduction of __kernel_sa_family_t
Date: Tue, 21 Jan 2014 14:00:02 +0100
Message-ID: <1390309204-19854-9-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44840 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754548AbaAUNAL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:11 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

This patch updates the comment about the introduction of __kernel_sa_family_t,
while there get rid of C++ commenting style.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/linux/can.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/can.h b/include/linux/can.h
index 5802cb3..e7b1029 100644
--- a/include/linux/can.h
+++ b/include/linux/can.h
@@ -122,8 +122,10 @@ struct canfd_frame {
 
 #define SOL_CAN_BASE 100
 
-// typedef unsigned short __kernel_sa_family_t;
-// introduced in Linux 3.2 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf654c
+/*
+ * typedef unsigned short __kernel_sa_family_t;
+ * introduced in Linux 3.1 commit 6602a4baf4d1a73cc4685a39ef859e1c5ddf654c
+ */
 
 /**
  * struct sockaddr_can - the sockaddr structure for CAN sockets
@@ -133,7 +135,7 @@ struct canfd_frame {
  */
 struct sockaddr_can {
 	sa_family_t can_family;
-//	__kernel_sa_family_t can_family;
+	/* __kernel_sa_family_t can_family; */
 	int         can_ifindex;
 	union {
 		/* transport protocol class address information (e.g. ISOTP) */
-- 
1.8.5.2

