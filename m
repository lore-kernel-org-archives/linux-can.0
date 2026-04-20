Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A717A31C
	for <linux-can@vger.kernel.org>; Mon, 20 Apr 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776698558; cv=none; b=VEw/E34HPo2m8PYPQoqAlI0faLfZk6hlnICHyQNF37b4GPV7togxEyUqCpD807E82fuY+6aq2sIBGul2ODkrsMxSWIxqX2xPZ7TC+zTcV3Q+IzoLAeTP8bYoho2ek8gASxk0VhZSyLlIkJxAD8MQ3UM3sMzsQjWALpREDIS8kgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776698558; c=relaxed/simple;
	bh=q/QVc6ij1mBGLl8lUSqFUGhEz8ttoxN7gPO6+7gXinM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiCz0cmQ3qtuQiD40sabo1xc3/QbLXSg/Da03AQuGAvKXuiOaboDQsg7FULaZ5m1nsz+PJx8Fuk9xJvA2HNIUkqu0lswFcvd86GsRIeUlpB0pz1w3CwmMZhoIavYR2UEz7btDV0oeWF7Xqb/5z5+BMawCtvqQDVJhr20ErNAMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-0000be-9b; Mon, 20 Apr 2026 17:22:30 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSE-006MEy-0B;
	Mon, 20 Apr 2026 17:22:30 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wEqSD-00000002RXt-45So;
	Mon, 20 Apr 2026 17:22:29 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] net: can: j1939: move J1939_MIN_NAMELEN to shared header
Date: Mon, 20 Apr 2026 17:22:26 +0200
Message-ID: <20260420152228.581421-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420152228.581421-1-o.rempel@pengutronix.de>
References: <20260420152228.581421-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Move J1939_MIN_NAMELEN macro from socket.c to j1939-priv.h to prepare
for KUnit test infrastructure.

No functional change.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/j1939-priv.h | 2 ++
 net/can/j1939/socket.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index b82706505103..cf646644f538 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -12,6 +12,8 @@
 #include <linux/can/j1939.h>
 #include <net/sock.h>
 
+#define J1939_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.j1939)
+
 /* Timeout to receive the abort signal over loop back. In case CAN
  * bus is open, the timeout should be triggered.
  */
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 0502b030d238..2191bfe117dc 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -21,8 +21,6 @@
 
 #include "j1939-priv.h"
 
-#define J1939_MIN_NAMELEN CAN_REQUIRED_SIZE(struct sockaddr_can, can_addr.j1939)
-
 /* conversion function between struct sock::sk_priority from linux and
  * j1939 priority field
  */
-- 
2.47.3

