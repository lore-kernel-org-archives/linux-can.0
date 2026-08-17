Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676293F329B;
	Mon, 17 Aug 2026 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009675; cv=none; b=E2AP/FXMN4KEJ0wFxI0Fu8Uh41cQNyLDcRfYnZzOhPV6UDYh3pNkLjBrlOSolHM1ov7SSH9SV1C5TjS2KB41c5Yrl+ixL1LUhxVpHBYqdKMA/tXJ4mMxP7oQ96B1OOx7Vu2ADjq7VBgTvvJK1k9VEmZNEKfbcc6yA1JwydRdW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009675; c=relaxed/simple;
	bh=mrPOT3EUrOPfLgYfF6hC1iUbJU807OU2Fc0B4TblrcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGM4LTXBTj0WXtDLP1PNDjZ+r2e2zqaQEFO3iZgG/tkocrHNgICERDn63w/M88jl+aPUIWABzjnNt1TwV9RhwIN/OhoD75IMteoRftig3gMjEHAc2PyInpJRp91tvucTM8YONdfcL218o8B9uJzHzdqeVAnhmiznrQMhkjGq/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3799720228F;
	Tue, 18 Aug 2026 01:34:23 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww6qV-002216-0C;
	Tue, 18 Aug 2026 01:34:23 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CABBA58515D;
	Mon, 17 Aug 2026 23:34:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Fanbo He <hefanbo@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/11] drivers: gs_usb: gs_usb_probe(): fix typo in error message
Date: Tue, 18 Aug 2026 01:24:37 +0200
Message-ID: <20260817233420.2068204-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817233420.2068204-1-mkl@pengutronix.de>
References: <20260817233420.2068204-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fanbo He <hefanbo@gmail.com>

Fix typo in the error messag.

Signed-off-by: Fanbo He <hefanbo@gmail.com>
Link: https://patch.msgid.link/20260702031306.18988-1-hefanbo@gmail.com
[mkl: add commit message]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 82508a865095..3b9b2f104d86 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1565,7 +1565,7 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
-			"Driver cannot handle more that %u CAN interfaces\n",
+			"Driver cannot handle more than %u CAN interfaces\n",
 			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
-- 
2.53.0

