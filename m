Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311479;
	b=fIYcAJB9TT6o4A3X6tbkUMFytKlyv6VvanvLFlT1LUOuTiXegCa4ctAz2CXsU5svtCbg
	 j/IpYJR576z8q4Zb6xLtPykYc2AHlAltfRO/vtiJocE4IuX2Jp6OMoFyWt6d85arGJXdf
	 jvKPZr7epCNFdu2DclDeyutQD6USxjXjKirggdOjaCKW4pj7BYgGdlrtlCXx0RAX2Lj0I
	 wsriD2fq9mdza0cotelQaoUoSsQgMZbtCP8ycoKu7OQHQ6fuSQCl5RUBXamG1GMIyaAPF
	 lcQPyq6CezNQzSXF0OwNIHiNxkYUswQEwfwz8OsssyJU3HEe3qJqnVB7fhufhntLyzQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=TxMLB+yO45DRypK/wX7xz1hctfbIf31/XMffGhm99YAtu9M0SyynKGk+/AsA6q16EAlx
	 sgiPnqkvGlFB2B6wMy32CCWoavy19H8Uhz2IxLzfaSZTC9TftLdSJXAdqaQv9+1I3EyTF
	 6l+I2er3FvS7PEzulP/KAcbVChK2sG/NUdWrYeQnHIXdg2i0E17aqjD0qHheR/OskEcef
	 /7g9ExcWm7CuazyDKOk57Ud6cLvaTNsF24RGnNr8Tb6KhJ0SHKRzDOgnEf7WGsOfdVAxu
	 zYhYqCh2tdQtxxSltbcXwQdZtXHnMYPoPbxkJsnLqb1WuWqBZX801F16b6S9IMdZZAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LgZwHA7B;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D260A2615;
	Tue, 10 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818D260A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LgZwHA7B
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BBBA0201F43;
	Tue, 10 Nov 2026 12:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=LgZwHA7BBWQo//4kgOqJmxiBmDylHI/0dw6HEtd2LweL8B1pUIxjV59lVBxqCGKSqcX/zJ
	DCPclS7F6HhDfvPLvnp32cIlDUYASe+7N8VLoaY5QwQMaxHmnZRhtkQ3U1vkLe7dToP//q
	dJyXGpheOeE0vX4Y6maov9S1I4rTKvJyWhsLW2ZKnsKRzAEmU/929EXbMR7d7c8vms9YeO
	yhWDLGHfKV6oizHV+N3kpmInGcAjSOIp2Dq+Ga+ZmuIspt6y+hNWTzOhtohJ5AMY2j7+Pz
	G5fPytmHCj81IOTkFAMAow5ZXKsjW4SMon/xBqrPItY5lonQL1AYqyTJbMwFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCs3jym0XNFnfrLFXL0S112gkjhJSSwjd7o96tiFaSM=;
	b=O3TxbYfJzDB2Rf7fsCu+21whtcpjO8ynRqrrFkBIrYydYDA8KQ3wMMTH6fXqFi6WjKXsX7
	vJYQUgrC75YjVBtbZ0fGN0JpN/mXYfT/RJF2b26Yr60b4nXp+b9MKrLSDLkEDQ7H28V2Fo
	YAc7yA6QAjRUf2Sx5rUIHG6S4ZqHJxS8kp74mBF+FC1dXxIyGJjtXBbUdeYaJLdNOC9UYF
	mDEZOBwTMxhhN84N0ybLRdY2PnxdwocaKkwPO1fEmPCNpE1WJdHFnKw74eRHJkLNuqIZnE
	8uCgXdzU/XED/VzxxNwebi9d/XS0J0BYnHQw2RrvCRPvskNck8vXkfMYOiU3wg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311476; a=rsa-sha256;
	cv=none;
	b=EsE5WwTZ7diU1hQNYxS74A0ZL51SOJzry8ITJrIRa7VnLK0mBHyakFVNFzoqtwhvXCKjfw
	2QR5DHg/EkMfEoeNkAfDxDN+6QlpRdQeuwhojPnICGW5tdAOJV+dvTi6P47l+wzU7rnofq
	8OiFsUrV1/AWkhQLwuWioRoaQSr4xOrJaswJ3Mm62S3CMAdGBmrJ+jXTbWf3TPCTmKJyNt
	yaj4IHbr5crQXatYMJWiYphj3gr04d4WmsL9K9W7yaq+rmW1PNJEFC+y3y6dkTT+ZnxmTl
	duB4Lh1qhdLxeFJm5Te8/ib6zJsnkWVIK2BDImOlObOBir/kCNccmuAC6hm47A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEo-27;
	Tue, 10 Nov 2026 12:51:16 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 62B225E688B;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/12] can: rcar_canfd: Fix typos in macro names
Date: Tue, 10 Nov 2026 12:41:25 +0100
Message-ID: <20261110115112.3807247-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The bits 1..0 of the Channel n Control Register are named CHMDC (Channel
Mode select). Fix typos in macro names by replacing DMC with MDC.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-3-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fcc37b73ed43..b7c4fe3477ac 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -132,9 +132,9 @@
 #define RCANFD_CCTR_BEIE		BIT(8)
 #define RCANFD_CCTR_CSLPR		BIT(2)
 #define RCANFD_CCTR_CHMDC_MASK		(0x3)
-#define RCANFD_CCTR_CHDMC_COPM		(0x0)
-#define RCANFD_CCTR_CHDMC_CRESET	(0x1)
-#define RCANFD_CCTR_CHDMC_CHLT		(0x2)
+#define RCANFD_CCTR_CHMDC_COPM		(0x0)
+#define RCANFD_CCTR_CHMDC_CRESET	(0x1)
+#define RCANFD_CCTR_CHMDC_CHLT		(0x2)
 
 /* RSCFDnCFDCmSTS / RSCFDnCmSTS */
 #define RCANFD_CSTS_COMSTS		BIT(7)
@@ -828,7 +828,7 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 
 		rcar_canfd_update_bit(gpriv->base, RCANFD_CCTR(ch),
 				      RCANFD_CCTR_CHMDC_MASK,
-				      RCANFD_CCTR_CHDMC_CRESET);
+				      RCANFD_CCTR_CHMDC_CRESET);
 
 		/* Ensure Channel reset mode */
 		err = readl_poll_timeout((gpriv->base + RCANFD_CSTS(ch)), sts,
@@ -1504,7 +1504,7 @@ static int rcar_canfd_start(struct net_device *ndev)
 
 	/* Set channel to Operational mode */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_COPM);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_COPM);
 
 	/* Verify channel mode change */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
@@ -1578,7 +1578,7 @@ static void rcar_canfd_stop(struct net_device *ndev)
 
 	/* Transition to channel reset mode  */
 	rcar_canfd_update_bit(priv->base, RCANFD_CCTR(ch),
-			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHDMC_CRESET);
+			      RCANFD_CCTR_CHMDC_MASK, RCANFD_CCTR_CHMDC_CRESET);
 
 	/* Check Channel reset mode */
 	err = readl_poll_timeout((priv->base + RCANFD_CSTS(ch)), sts,
-- 
2.53.0

