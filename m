Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99F3F4DE4;
	Thu, 16 Jul 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217402; cv=none; b=F9WA5OtnAIUPR+1OBhn4/v+jpONrwQvpgDsTOpEf6Zc9+xgQh9f+y25xuOpAQMgIKHPzKkO3uoEP17SRHxuizBTUFhe0Hr6q3evEV0Iju3lyvtJe+VEiDZhtJhn2HOXzDfWi64kQlNwuP2myaYb8aw01nkdo3tjx3X7AZWRpQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217402; c=relaxed/simple;
	bh=t9wiEAX5Bqv1EWhKlNJ6ax2/6OIJiYcTi8cIE1/Vai0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdQSDyMuU87JRTKTZwl1e5EAFhmc1hIuub6uUwUpCE6Ar/3Biff13+S6XdI1Rn5x/ZgoMFlq1mqCgz7GzE8fKNIROiif/qxksLHLD/3ipNYqhBq/O7uAgkhlyvCzGxj71t+I2pq8x9N5qjqAWi5PMN986iGBgtysjuZtQPbTUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5B75E202281;
	Thu, 16 Jul 2026 17:56:24 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wkORj-0027ob-3A;
	Thu, 16 Jul 2026 17:56:24 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B8C256C3D2;
	Thu, 16 Jul 2026 15:55:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 01/19] can: vxcan: Kconfig: fix description stating no local echo provided
Date: Thu, 16 Jul 2026 17:47:26 +0200
Message-ID: <20260716155528.809908-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716155528.809908-1-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Hölzl <alexander.hoelzl@gmx.net>

The Kconfig description of the vxcan kernel module erroneously states the
the vxcan interface does not provide a local echo of sent can frames.
However this behavior changed in commit 259bdba27e32 ("vxcan: enable local
echo for sent CAN frames") and vxcan interfaces now provide a local echo.

Change the description of the vxcan module in the Kconfig to reflect this
change.

Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260619090035.17769-1-alexander.hoelzl@gmx.net
[mkl: rephrase patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/Kconfig | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index e4058708ae68..a8fad6fe5302 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -40,11 +40,8 @@ config CAN_VXCAN
 	  When one end receives the packet it appears on its pair and vice
 	  versa. The vxcan can be used for cross namespace communication.
 
-	  In opposite to vcan loopback devices the vxcan only forwards CAN
-	  frames to its pair and does *not* provide a local echo of sent
-	  CAN frames. To disable a potential echo in af_can.c the vxcan driver
-	  announces IFF_ECHO in the interface flags. To have a clean start
-	  in each namespace the CAN GW hop counter is set to zero.
+	  To have a clean start in each namespace the CAN GW hop counter is
+	  set to zero.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called vxcan.

base-commit: 3f1f755366687d051174739fb99f7d560202f60b
-- 
2.53.0

