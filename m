From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH can-utils v3 5/5] isotp.h: add explicit license information
Date: Mon, 13 Jan 2014 22:13:21 +0100
Message-ID: <1389647601-10622-6-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1389647601-10622-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40272 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbaAMVNn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 16:13:43 -0500
In-Reply-To: <1389647601-10622-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>

It seems this file was originally part of the Linux kernel as it was created
by commit 77de10356fe0 (include: import kernel header files into tree) but I
couldn't find it in the git history of the kernel. Anyhow the copyright
suggests to use the license used by the other files created by Volkswagen.
---
 isotp.h | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/isotp.h b/isotp.h
index 5499ca8e95c0..3540caf1b9b2 100644
--- a/isotp.h
+++ b/isotp.h
@@ -3,14 +3,44 @@
  *
  * Definitions for isotp CAN sockets
  *
- * $Id$
- *
  * Author: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
  * Copyright (c) 2008 Volkswagen Group Electronic Research
  * All rights reserved.
  *
- * Send feedback to <linux-can@vger.kernel.org>
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
  *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible license.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
  */
 
 #ifndef CAN_ISOTP_H
-- 
1.8.5.2

