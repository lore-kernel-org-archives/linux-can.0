From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v7 03/10] isotp.h: add explicit license information
Date: Tue, 21 Jan 2014 13:59:57 +0100
Message-ID: <1390309204-19854-4-git-send-email-mkl@pengutronix.de>
References: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44829 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbaAUNAK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 08:00:10 -0500
In-Reply-To: <1390309204-19854-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Marc Kleine-Budde <mkl@pengutronix.de>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

The copyright suggests to use the license used by the other files creat=
ed by
Volkswagen.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 include/socketcan/can/isotp.h | 36 +++++++++++++++++++++++++++++++++--=
-
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/socketcan/can/isotp.h b/include/socketcan/can/isot=
p.h
index 6ba5ef1..541369a 100644
--- a/include/socketcan/can/isotp.h
+++ b/include/socketcan/can/isotp.h
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
+ * 2. Redistributions in binary form must reproduce the above copyrigh=
t
+ *    notice, this list of conditions and the following disclaimer in =
the
+ *    documentation and/or other materials provided with the distribut=
ion.
+ * 3. Neither the name of Volkswagen nor the names of its contributors
+ *    may be used to endorse or promote products derived from this sof=
tware
+ *    without specific prior written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of t=
he
+ * GPL apply INSTEAD OF those given above.
  *
+ * The provided data structures and external interfaces from this code
+ * are not restricted to be used by modules with a GPL compatible lice=
nse.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS F=
OR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGH=
T
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTA=
L,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF US=
E,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON A=
NY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * Send feedback to <linux-can@vger.kernel.org>
  */
=20
 #ifndef CAN_ISOTP_H
--=20
1.8.5.2

