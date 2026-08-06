Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567B3A7D63;
	Thu,  6 Aug 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025261; cv=none; b=glvkV16wFCFp5HEDiKFg1gQPJNfiP8V8JrqyXTCbhUJWb1P3EATDcEK/A4YRD4oSKGFoRJXiWZJP67siUV9x3uaiSt//3s0o4x3rt9eeZ807u18uvEpvPFV0CT9CRf0+XoA+H9zIiG8/GYW+yccHbEyt69U7rus9q4JplNthUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025261; c=relaxed/simple;
	bh=UeLdz+oh4/Ouq2b671/Zz13/poHqfAdkoa1CMYxxFXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b6zoDeIf3+yu5UnySMyE9HmpY6JF5RwjM86llbWzVsoQv7pGdIc68I+F+Px7+FnfUrbpyPR1B6T7UgcLflDOgllRmFm90jeGjZywocga63zMe8UVQ2arTsPNCs4bH+lEYwzEYDhuf/SaiKzu4KfA2hBVqQEWz9NnSXi4kwYzaBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A8773201FA9;
	Thu, 06 Aug 2026 16:07:32 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wryku-0006X4-1v;
	Thu, 06 Aug 2026 16:07:32 +0200
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 52BA957D131;
	Thu, 06 Aug 2026 14:07:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 06 Aug 2026 16:07:29 +0200
Subject: [PATCH] can: ctucanfd: ctucan_err_interrupt(): do not emit info
 messages on Arbitration Lost or CAN Bus Error IRQs
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNwQrCMAyA4VcZORuog5biq4iHLk1nRDtJVhHG3
 t2qx+/y/xsYq7DBadhA+SUmS+04Hgaga6ozo+RuGN0YXHQeaW2UaslocudKjF04NUNWXRQfbJZ
 mNvTkJ8ohBlci9NpTucj7dzpf/rY23ZjWbx72/QMK93l/iwAAAA==
X-Change-ID: 20260805-ctucanfd-silence-can-bus-error-messages-5c5bcd6860f8
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>, 
 Vincent Mailhol <mailhol@kernel.org>, Avi Weiss <thnkslprpt@gmail.com>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=UeLdz+oh4/Ouq2b671/Zz13/poHqfAdkoa1CMYxxFXs=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsgqmar07lz3jzA1NV/1sHP2ghrz/wjP1nC+tSqiIkPjx
 g7mnKifHaUsDGJcDLJiiixLf5xQFAh0KO19mTAJZg4rE8gQBi5OAZiI2w5Ghhtp9pu4L3YfP9N+
 sUXFM7va61vthzfH3kx4F/xyp5YZlznDPwumeGluhd2V4l9TD/l+ZHh/d//yOu758om1F37f/5R
 3lxkA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Since commit e74bae899529 ("can: ctucanfd: handle bus error interrupts")
CAN bus error interrupts are properly handled.

With activated CAN Bus Error reporting, Arbitration Lost (ALI) and Bus Error
(BEI) interrupts are enabled. These can occur at a very high rate (~10kHz).

To avoid flooding the system, don't emit a netdev_info() for these.

Fixes: e74bae899529 ("can: ctucanfd: handle bus error interrupts")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 07d4aa43c700..9aec18681fc5 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -884,8 +884,6 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	/* Check for Arbitration Lost interrupt */
 	if (FIELD_GET(REG_INT_STAT_ALI, isr)) {
-		if (dologerr)
-			netdev_info(ndev, "arbitration lost\n");
 		priv->can.can_stats.arbitration_lost++;
 		if (skb) {
 			cf->can_id |= CAN_ERR_LOSTARB;
@@ -895,7 +893,6 @@ static void ctucan_err_interrupt(struct net_device *ndev, u32 isr)
 
 	/* Check for Bus Error interrupt */
 	if (FIELD_GET(REG_INT_STAT_BEI, isr)) {
-		netdev_info(ndev, "bus error\n");
 		priv->can.can_stats.bus_error++;
 		stats->rx_errors++;
 		if (skb) {

---
base-commit: cd0784790d921ff4f7438d3b7ccda86068c8b766
change-id: 20260805-ctucanfd-silence-can-bus-error-messages-5c5bcd6860f8

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

