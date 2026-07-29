Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DD443E4C;
	Wed, 29 Jul 2026 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320978; cv=none; b=nzX8bbGmefQsynTtVcqtVYF/PpnIAw0EvKRk2hv/6237M111O58Ci2u8uGueLiSJmliIVc8010C0SHlpq0nFN5fgGoYu//BQvYz9Oc3a/sUVrW0Y3pRG4opmUgFlnMxryS6bas5UJ1pOt6mSHFNtl75h0kBfrbkKdYKAjawbOjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320978; c=relaxed/simple;
	bh=0d6q0UVOiWxaaaEbtRyNHTf4Gjfl7Wl8w3HU4c7nGh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMI1BQN2jZqizC5BuUqVPbXue6O1E2j2PDLXouNMFRMmqZ3KJqVioxL1cz8YbHStACK+g+4T1FgKvKJyvWKpM60Ue19aYXuI3g/5VbOFejZmcpPc3wUnc6R9BtZDPDttFCNz1WFW/Y//y+MywnahmlApionWtTt8dvwE3RSVO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A7592202B67;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rnO-1L;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E51D6575DC4;
	Wed, 29 Jul 2026 10:28:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Avi Weiss <thnkslprpt@gmail.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 06/20] can: ctucanfd: mark error-active controller status valid
Date: Wed, 29 Jul 2026 12:12:46 +0200
Message-ID: <20260729102802.505168-7-mkl@pengutronix.de>
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

In the CAN_STATE_ERROR_ACTIVE case, cf->data[1] is set to
CAN_ERR_CRTL_ACTIVE, but cf->can_id is not set with CAN_ERR_CRTL in
that path.

Set CAN_ERR_CRTL so consumers know the controller-status information
in cf->data[1] is valid.

Fixes: 9bd24927e3ee ("can: ctucanfd: handle skb allocation failure")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
Link: https://patch.msgid.link/20260723155543.318414-1-thnkslprpt@gmail.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..8f8b1c097ec6 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -869,7 +869,7 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 			break;
 		case CAN_STATE_ERROR_ACTIVE:
 			if (skb) {
-				cf->can_id |= CAN_ERR_CNT;
+				cf->can_id |= CAN_ERR_CRTL | CAN_ERR_CNT;
 				cf->data[1] = CAN_ERR_CRTL_ACTIVE;
 				cf->data[6] = bec.txerr;
 				cf->data[7] = bec.rxerr;
-- 
2.53.0

