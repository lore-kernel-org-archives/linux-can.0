Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=yVfRTv8kCvwtDndCDKJ9B7ISMBOIAWQ3NpdzXEw5TZdM/h9UqYvDce79/x0acgsti7yS
	 5yCX25c5H7izbSipkZm/atVSHp5bio/XCKd4MHRZG/jio/D+NxOxDITbaewvLGPvvGXc8
	 0baK0oOIB9E/YKLnl/U1JGJRV7hPeFPv1Jc8MG2uaByxxwqq31pJEsUQ8ExT2JC0TeWVT
	 tTy1dU2lGsqfPywYENfXmyOc8Bu4zTleUH/IzIO7owRsPZb4CCs6qHxpdWsgvX/GJQDI9
	 ZRycAGVSBR2vKMNnPukztz25DkX93dRXWZRaiWHDh1K7IVIZzAGuDGetOwzzXeCG5xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pUbz2sgIcf/DT8f8VFK294+iNDE3JbnIJ1+MuiXE9Gg=;
	b=cM0fY4u8FLC6X4my+4Nke7ywHUOpsokDRt+jOzGVWUEj3n2jSpDdpPGQzSSuIybEHvR2
	 tRhgQ3fo3eU/0iP+0DWhkm0A+G+1v1DC3x19qU5vXNX3OTqABRYusEXC/a/DXYMQwXE2q
	 WiGTrzpxeg7IZ9sKN8jwj9kplBuY3cM66NHrbA3Y5W/7izVrBf/5sFp9Yfw2kJdRX8ffD
	 cKbop+3DLVx57i3NDeyYI/sPoo3XG8EI6n07R0I5R2HIsDVcO8ZPWPq7FMXROe+aSpsK1
	 TE7zFhKJC/lZXq1Pv+4ylKMKjQIOcSlCsx8ujRnv4LB3qos7HEE0O1yAUwQpWJqbChA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Pfhuzu+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7089606A33A
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7089606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Pfhuzu+1
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 68A11205B42;
	Sat, 21 Nov 2026 23:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbz2sgIcf/DT8f8VFK294+iNDE3JbnIJ1+MuiXE9Gg=;
	b=Pfhuzu+1g495mTMqvkZA1kYkwCFYSZ7Uc7F3AjPtK0qjM/8w7luYZffiwrXvOQ9nrGN5oe
	/aX9gXOojhgImJf+w8H9+Ap0cZ8SzScXO4+0gW30EWdAvjAHS2ATq4LLrtDUp6bqe6IhRa
	tolzozEKBwLGxsVzXNoSoKYsDbPSwF9XbIpIyF7+t77hyn4pVSuowYRG8eWgniKnBJwg7L
	Fs2SnVSnW4rlN/eu6L9Ymn7UAfOurzI6n0Uq4IU1OQ487uZIyiX6qpFRBEMTR6Gvo0YLXo
	001IBorzMxYKA48od6y5t4WZZJtMchc8HroW3Spa3LXIp8qawZbYmSq3MC3X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbz2sgIcf/DT8f8VFK294+iNDE3JbnIJ1+MuiXE9Gg=;
	b=Td9hFK4YPF/lRIccSXw5j2cNBnJf1EhvTXqdJj5K53+52WZ7M1D+F5an8/clWrp4XlhZA6
	PWvFJRFbKH6Hm0xeeUpEUUtm0vy5G/d07d1VQaOXwc3JKRcifzEN8qjoqh5Lx99OCg0rbh
	KUnKN0zDqGoCBZMj1EEAlcRGIXK8AKtbqskxjqPKfOjcfMVmifdf5AEuUSbLQXSSIjrUf8
	w7NG1OwlZOQzQThv3UwxW1Ym8rJIvPNw+Br3GmC9yC9kwYUaibZ1qNmmZXsclFN/Lea8Va
	TBLCFdGPY2nni7Vh9JeK1gHhgq3z0rDOZQE8WKOe6KPY1ufFynQpuqw4RKXIRg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300582; a=rsa-sha256;
	cv=none;
	b=WkCwamXas6pur6Jdk3YIcPDrP8GRvyRzM7U1LtzK+6AcCMeUMZrms8PFuir4oLTxD3UlqI
	oxbeNh3HNB6iChf5FN/Mbuhtq/QDq9IVo/urZpzamRcyNT0DpU+TXwyJ7bnV3F3x7ZQSQK
	wRTC0T64qEKwA4f+e12ua8r3TiFfXvfQbZQOcMN7pygZB1rHtghMhYx3siQnP2QiWymKiI
	Juozvu0L0uwF75JCZQnu7OC/jDrq67a287fONj20132tLT6uHGQr0KZWxv+9Kz0QDj+QGQ
	kVC5bxiwQWdRA42tSTjNrjakm5wdaGRe4X/19sjVhx5S1JxbXsJPDlDH9KZsIw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:11 +0100
Subject: [PATCH can-next v9 13/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop CAN frames with invalid DLC
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-gs_usb-fixes-v9-13-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1328; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=jYeoQlkoNNElEiYuJmk79RuqiqBqfkt5zH1wj96qUe4=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmknlY/TVHOr3mlHN8VKPpFquXrl73136OPGXts5uTL
 7Xxju20jlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEzE/DnD/yqb2qb3l8vr5O4x
 yXnvP+bRkJFdWHaZw0E17E1T0YtSDob/YXP688T5J/YnGUXl8BwS2K/6n2dDcNWifBarFW6fdya
 xAAA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

According to the respective CAN standards, the maximum DLC length for
CAN-CC and CAN-FD frames is 0xf. The code in driver assumes that this limit
has been verified.

Drop CAN frames with DLC > 0xf, print a error message and resubmit the URB.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index a1192867e49b..2da2f8843e5d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -663,6 +663,20 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
 		}
 	}
 
+	/* we can check for max CAN-CC and CAN-FD DLC at the same time, they are both 0xf */
+	BUILD_BUG_ON(CAN_MAX_RAW_DLC != CANFD_MAX_DLC);
+	if (header->can_dlc > CAN_MAX_RAW_DLC) {
+		stats->rx_errors++;
+		stats->rx_length_errors++;
+
+		if (net_ratelimit())
+			netdev_err(netdev,
+				   "out of range DLC (can_dlc=%u, max_can_dlc=%u)\n",
+				   header->can_dlc, CAN_MAX_RAW_DLC);
+
+		valid = false;
+	}
+
 	return valid;
 }
 

-- 
2.53.0

