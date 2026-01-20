Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82E429808
	for <linux-can@vger.kernel.org>; Tue, 20 Jan 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768915331; cv=none; b=se+3SufAl5QEueUvboV+qJplp2ksDsJ/nfqDLlmkNrOmk03s0EcGjF0W6AZL3BKA4alIWhk3Ecukw9yqtEWANl8epkPTcBypxYfGDNxY6Lfy6iyHx61ACgTs8ye1QS7uv+10811vkpSc4XinEHFgJr7zqOMFvm+8FArNGRpA1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768915331; c=relaxed/simple;
	bh=VwB2WuG0nLlJck5gZT6KO38Nkp4JD1zUrmdA7DBTOn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p844llr+o7ukYrAXTSAnfuyyaO84ETIITKmmefNhH5vgLDmDTtTUVsLoGyyQitVoaCwWR7Rro24uG9vfn0Epgeg+saiBzG1isiifDFp7quFhwyxi2F6UphnizatcumTS0zP5wD/r1XzMTaZzP8IpnZzxvYoaAKKg28tpMSzTx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1viBgL-0004wA-VG; Tue, 20 Jan 2026 14:22:05 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1viBgM-001ajB-1P;
	Tue, 20 Jan 2026 14:22:05 +0100
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8589F4D3401;
	Tue, 20 Jan 2026 13:22:05 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: stable@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.15.y] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
Date: Tue, 20 Jan 2026 14:21:56 +0100
Message-ID: <20260120132156.746174-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012023-ranged-machinist-edb4@gregkh>
References: <2026012023-ranged-machinist-edb4@gregkh>
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

In gs_can_open(), the URBs for USB-in transfers are allocated, added to the
parent->rx_submitted anchor and submitted. In the complete callback
gs_usb_receive_bulk_callback(), the URB is processed and resubmitted. In
gs_can_close() the URBs are freed by calling
usb_kill_anchored_urbs(parent->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in gs_can_close().

Fix the memory leak by anchoring the URB in the
gs_usb_receive_bulk_callback() to the parent->rx_submitted anchor.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260105-gs_usb-fix-memory-leak-v2-1-cc6ed6438034@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit 7352e1d5932a0e777e39fa4b619801191f57e603)
---
 drivers/net/can/usb/gs_usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ffa2a4d92d01..e36745fd2d3b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -402,6 +402,8 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 			  usbcan
 			  );
 
+	usb_anchor_urb(urb, &parent->rx_submitted);
+
 	rc = usb_submit_urb(urb, GFP_ATOMIC);
 
 	/* USB failure take down all interfaces */
-- 
2.51.0

