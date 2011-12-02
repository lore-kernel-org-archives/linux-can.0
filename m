From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 2/4] Makefile: adopt to new location for kernel headers
Date: Fri,  2 Dec 2011 14:16:51 +0100
Message-ID: <1322831813-9729-3-git-send-email-mkl@pengutronix.de>
References: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab1LBNRC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Dec 2011 08:17:02 -0500
In-Reply-To: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: socketcan-core@lists.berlios.de, Marc Kleine-Budde <mkl@pengutronix.de>

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 2c75e42..2ace302 100644
--- a/Makefile
+++ b/Makefile
@@ -43,11 +43,9 @@
 DESTDIR =
 PREFIX = /usr/local
 
-KERNELDIR = ../kernel/2.6
-
 MAKEFLAGS = -k
 
-CFLAGS    = -O2 -Wall -Wno-parentheses -I$(KERNELDIR)/include \
+CFLAGS    = -O2 -Wall -Wno-parentheses -Iinclude \
 	    -fno-strict-aliasing \
 	    -DSO_RXQ_OVFL=40 \
 	    -DPF_CAN=29 \
-- 
1.7.4.1

