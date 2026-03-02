Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0ED41B370
	for <linux-can@vger.kernel.org>; Mon,  2 Mar 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465299; cv=none; b=qC0tu7D50zZhXtv1zXXp/KrCc4S91xbS+kICtFCAq9BLikxZcMt30vx/yP1ExIdEIdSCDzIEm/6UCUfMMAYLiN+nhbs2HhUILXNc76d8N+NxcczhRgTJEruX1Mm9YBdpoMeS0uE/fc8+R+T/16UaWPTCLtAUerUxfJUnSTwo2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465299; c=relaxed/simple;
	bh=7A6prLBJfxDSQTw2aC75TrF6vdn2kOhfSGHYl4DSpgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWZoYPxejL90SX8Klwb0kc9accpcS8pMRNNTy44atexNyzpS4vRJOrovSsaqLW6BI0+QpgUri8HHhsMoELhLbgm9RPQ7giXEZ/FdXvQyhPaEW2jXuFDLQu8h/9k9gj0nuOiYqLidX51Hia7fPbMFXfIJMVMp7W7nW7r9dPL0rfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bj-0004kR-Gu; Mon, 02 Mar 2026 16:28:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vx5Bc-003P0x-34;
	Mon, 02 Mar 2026 16:27:58 +0100
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0E9DF4F5473;
	Mon, 02 Mar 2026 15:27:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 10/12] can: usb: f81604: correctly anchor the urb in the read bulk callback
Date: Mon,  2 Mar 2026 16:16:16 +0100
Message-ID: <20260302152755.1700177-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302152755.1700177-1-mkl@pengutronix.de>
References: <20260302152755.1700177-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

When submitting an urb, that is using the anchor pattern, it needs to be
anchored before submitting it otherwise it could be leaked if
usb_kill_anchored_urbs() is called.  This logic is correctly done
elsewhere in the driver, except in the read bulk callback so do that
here also.

Cc: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022334-starlight-scaling-2cea@gregkh
Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/f81604.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index 1cc927d79b6a..f12318268e46 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -413,6 +413,7 @@ static void f81604_read_bulk_callback(struct urb *urb)
 {
 	struct f81604_can_frame *frame = urb->transfer_buffer;
 	struct net_device *netdev = urb->context;
+	struct f81604_port_priv *priv = netdev_priv(netdev);
 	int ret;
 
 	if (!netif_device_present(netdev))
@@ -445,10 +446,15 @@ static void f81604_read_bulk_callback(struct urb *urb)
 	f81604_process_rx_packet(netdev, frame);
 
 resubmit_urb:
+	usb_anchor_urb(urb, &priv->urbs_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV)
 		netif_device_detach(netdev);
-	else if (ret)
+	else
 		netdev_err(netdev,
 			   "%s: failed to resubmit read bulk urb: %pe\n",
 			   __func__, ERR_PTR(ret));
@@ -652,10 +658,15 @@ static void f81604_read_int_callback(struct urb *urb)
 		f81604_handle_tx(priv, data);
 
 resubmit_urb:
+	usb_anchor_urb(urb, &priv->urbs_anchor);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV)
 		netif_device_detach(netdev);
-	else if (ret)
+	else
 		netdev_err(netdev, "%s: failed to resubmit int urb: %pe\n",
 			   __func__, ERR_PTR(ret));
 }
-- 
2.51.0

