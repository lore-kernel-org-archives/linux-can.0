From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: [PATCH] Add license to canframelen.h
Date: Fri, 31 Jan 2014 11:39:26 +0100
Message-ID: <1391164766-28324-1-git-send-email-sojkam1@fel.cvut.cz>
References: <52EB7830.2080604@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from max.feld.cvut.cz ([147.32.192.36]:37582 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932256AbaAaKkU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 Jan 2014 05:40:20 -0500
In-Reply-To: <52EB7830.2080604@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, Michal Sojka <sojkam1@fel.cvut.cz>

Signed-off-by: Michal Sojka <sojkam1@fel.cvut.cz>
---
 canframelen.h | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/canframelen.h b/canframelen.h
index 39b7706..4f39404 100644
--- a/canframelen.h
+++ b/canframelen.h
@@ -1,3 +1,48 @@
+/*
+ * canframelen.h
+ *
+ * Copyright (c) 2013, 2014 Czech Technical University in Prague
+ *
+ * Author: Michal Sojka <sojkam1@fel.cvut.cz>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of Czech Technical University in Prague nor the
+ *    names of its contributors may be used to endorse or promote
+ *    products derived from this software without specific prior
+ *    written permission.
+ *
+ * Alternatively, provided that this notice is retained in full, this
+ * software may be distributed under the terms of the GNU General
+ * Public License ("GPL") version 2, in which case the provisions of the
+ * GPL apply INSTEAD OF those given above.
+ *
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
+ *
+ */
+
 #ifndef CANFRAMELEN_H
 #define CANFRAMELEN_H
 
-- 
1.8.5.2

