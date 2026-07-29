Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEE3CF694;
	Wed, 29 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320976; cv=none; b=iagpQ3rvHRuD/MZcSh2ssVRntfvdapagiqKeiH5hYjjePawFu2P4nzTd2vwqXQwhWJ2ZY4oywBUdU51RkGphsEHNYjS3p7IFN3oyXpI9UliPUeN+5YG8uTpXL9N2aEDWzz1Roj3bCRyfSccQ0jTE+WabbYHRIzIRVT4mwcC2QkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320976; c=relaxed/simple;
	bh=ZOntL7Xd6lMfk0ApAMAARRP6whZ61uExssfx7Miznfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSrYLGCiAcdLVPdkZvG4Y35wePEeFpCTRR/dawp4Yb6vYWdeWliQpn6DzUh9d+FnZKy+hOHQAfl24JigVg/yGOQJuiurh6w+LmuRjOglC37WV4mYWaxqiPmrdbogS0NrvNbsUM+aCx/KSJErltGZcYqTjTg1X0vqisfHD+HHfPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4EE44202B5A;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rn6-00;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 5876F575DD3;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 14/20] can: kvaser_usb_leaf: kvaser_usb_leaf_wait_cmd(): validate received command extents
Date: Wed, 29 Jul 2026 12:12:54 +0200
Message-ID: <20260729102802.505168-15-mkl@pengutronix.de>
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

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

The wait and bulk receive paths walk variable-length commands from a
USB buffer. A nonzero command shorter than CMD_HEADER_LEN can still be
dispatched, and the wait path copies a matching command into a fixed
caller-owned struct kvaser_cmd using the device-provided length.

Reject nonzero commands that do not contain the fixed header or that
extend beyond the current USB buffer item. In the wait path, also reject
a matching command that exceeds the destination before copying it.

Fixes: 080f40a6fa28 ("can: kvaser_usb: Add support for Kvaser CAN/USB devices")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260722042221.44066-1-pengpeng@iscas.ac.cn
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index df737cfc5ea0..a876c7819b81 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -691,13 +691,22 @@ static int kvaser_usb_leaf_wait_cmd(const struct kvaser_usb *dev, u8 id,
 				continue;
 			}
 
-			if (pos + tmp->len > actual_len) {
+			if (tmp->len < CMD_HEADER_LEN ||
+			    tmp->len > actual_len - pos) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
 			}
 
 			if (tmp->id == id) {
+				if (tmp->len > sizeof(*cmd)) {
+					dev_err_ratelimited(&dev->intf->dev,
+							    "Received command %u too large (%u)\n",
+							    tmp->id, tmp->len);
+					err = -EIO;
+					goto end;
+				}
+
 				memcpy(cmd, tmp, tmp->len);
 				goto end;
 			}
@@ -1737,7 +1746,7 @@ static void kvaser_usb_leaf_read_bulk_callback(struct kvaser_usb *dev,
 			continue;
 		}
 
-		if (pos + cmd->len > len) {
+		if (cmd->len < CMD_HEADER_LEN || cmd->len > len - pos) {
 			dev_err_ratelimited(&dev->intf->dev, "Format error\n");
 			break;
 		}
-- 
2.53.0

