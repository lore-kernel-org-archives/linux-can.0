Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAE39A808;
	Wed, 29 Jul 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320970; cv=none; b=B7F6IWUWoyzkA3ceZgRQmSeeEhBBC7XqeM0AZiOPN9SGPXFRqO7YR/OwgSsWkulNKGili0un6skYnJfPx4CRmwNJ0EKdc7xdvbr9tIy/J6i9b/CnHHOJDmKji/jFVPDf+JvJ1ohF0VvlCo5hWc3J5yymZznevk6a9vq0F2awFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320970; c=relaxed/simple;
	bh=CWqaLAdOKW2jJBXUdBlbSKbqelns1IlSgNTNBGec1ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D17vNrpRo6QYAaUrwiBvHApFYE1mqpoMqcW6bMVkc1HP/BDHB1HN6em57ho3dKxRgFXm7fwe6MMgZqbMgt0g5svEiurgKoUw3+KQvHhsXOfIa3eftfKz9pXJFreXIoHuhgOC01zXkCpdmK4J5YlduB7U2jPyw0kflQ1XAn9EsYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D9031202B4B;
	Wed, 29 Jul 2026 12:29:25 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XR-001rmq-26;
	Wed, 29 Jul 2026 12:29:25 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A71F575DC6;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Avi Weiss <thnkslprpt@gmail.com>,
	Pavel Pisa <pisa@fel.cvut.cz>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 08/20] can: ctucanfd: use self-test mode for PRESUME_ACK
Date: Wed, 29 Jul 2026 12:12:48 +0200
Message-ID: <20260729102802.505168-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avi Weiss <thnkslprpt@gmail.com>

Use self-test mode for CAN_CTRLMODE_PRESUME_ACK so transmitted
frames can complete without receiving an ACK.

ACK forbidden mode prevents the controller from acknowledging
received frames and does not implement the presume-ack behavior.

Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source IP core - bus independent part.")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Acked-by: Pavel Pisa <pisa@fel.cvut.cz>
Link: https://patch.msgid.link/20260722192726.230729-1-thnkslprpt@gmail.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 10ebcc13ea65..07d4aa43c700 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -340,8 +340,8 @@ static void ctucan_set_mode(struct ctucan_priv *priv, const struct can_ctrlmode
 			(mode_reg & ~REG_MODE_FDE);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_PRESUME_ACK) ?
-			(mode_reg | REG_MODE_ACF) :
-			(mode_reg & ~REG_MODE_ACF);
+			(mode_reg | REG_MODE_STM) :
+			(mode_reg & ~REG_MODE_STM);
 
 	mode_reg = (mode->flags & CAN_CTRLMODE_FD_NON_ISO) ?
 			(mode_reg | REG_MODE_NISOFD) :
-- 
2.53.0

