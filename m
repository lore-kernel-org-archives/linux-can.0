From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/3] Makefile: move cpp related flags from CFLAGS to CPPFLAGS
Date: Wed, 26 Feb 2014 19:28:31 +0100
Message-ID: <1393439313-18030-2-git-send-email-mkl@pengutronix.de>
References: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53107 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbaBZS2g (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 13:28:36 -0500
In-Reply-To: <1393439313-18030-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ab99746..7f5c129 100644
--- a/Makefile
+++ b/Makefile
@@ -43,8 +43,10 @@ PREFIX ?= /usr/local
 
 MAKEFLAGS = -k
 
-CFLAGS    = -O2 -Wall -Wno-parentheses -Iinclude \
-	    -fno-strict-aliasing \
+CFLAGS    = -O2 -Wall -Wno-parentheses \
+	    -fno-strict-aliasing
+
+CPPFLAGS += -Iinclude \
 	    -DSO_RXQ_OVFL=40 \
 	    -DPF_CAN=29 \
 	    -DAF_CAN=PF_CAN
-- 
1.9.0.rc3

