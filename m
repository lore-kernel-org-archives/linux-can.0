From: Andri Yngvason <andri.yngvason@marel.com>
Subject: [PATCH] Consolidate and unify state change handling
Date: Mon, 20 Oct 2014 14:36:24 +0000
Message-ID: <6532730f-bc8c-4094-bef7-46c99d063a25@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0087.outbound.protection.outlook.com ([157.55.234.87]:7511
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751342AbaLCRyx (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 3 Dec 2014 12:54:53 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com

This follows a patch-set by the same name for the kernel.

Signed-off-by: Andri Yngvason <andri.yngvason@marel.com>
---
 lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index 2c8df32..973be52 100644
--- a/lib.c
+++ b/lib.c
@@ -446,6 +446,7 @@ static const char *controller_problems[] = {
 	"tx-error-warning",
 	"rx-error-passive",
 	"tx-error-passive",
+	"back-to-error-active",
 };
 
 static const char *protocol_violation_types[] = {
@@ -455,7 +456,7 @@ static const char *protocol_violation_types[] = {
 	"tx-dominant-bit-error",
 	"tx-recessive-bit-error",
 	"bus-overload",
-	"back-to-error-active",
+	"active-error",
 	"error-on-tx",
 };
 
-- 
1.9.1

