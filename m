Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A797242668B;
	Mon, 20 Jul 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555325; cv=none; b=Vnm+O1qviKDkKfMj8MjZxaRRaIXhrrDUw8rHeeI0ooEA5S1uqwk0WePhf8LjZBLtYCCkatVK0JFUWp00on2I1EAn1KcEzH7o3JXCDPziERg13NUeo6WNa9ipAuZ0SMpGVaMjjUUizuuxP58puHVT6SDhc7c0xzGhxm0HsO+GEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555325; c=relaxed/simple;
	bh=6E7hFTRSFelsYB949Wf8RtYAc7VuJ6L3GuSCf3VtYpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NjXBlqKBOLlOy69xwaalHE4MEr8Y73yUJ0AQFESHEMvcs27FjQ9D/MMTceM8zMOyPiBVk9oIWD8DgkRjEonyjBoK5QE3PySWeQymlhoGOXV4qLWmLMHSBWBKsv9cJ+AT5HnrFlCBFiHdEEzjPHUcGDiKWkN+era3Sy+SXBFp/Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AFCBE2028E0;
	Mon, 20 Jul 2026 15:48:29 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wloM9-000Pn5-1z;
	Mon, 20 Jul 2026 15:48:29 +0200
Received: from hardanger.blackshift.org (unknown [IPv6:2001:678:ed0:ff00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1723956E52A;
	Mon, 20 Jul 2026 13:48:29 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jul 2026 15:48:11 +0200
Subject: [PATCH can-next 10/13] can: gs_usb: gs_update_state(): set
 CAN_ERR_CNT if device sends CAN error counters
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-gs_usb-new-features-v1-10-427a8013c380@pengutronix.de>
References: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
In-Reply-To: <20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6E7hFTRSFelsYB949Wf8RtYAc7VuJ6L3GuSCf3VtYpQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsiKU1dUexdUvWB144OlsVOk/xh2ODr+uelh//7s5VYB+
 Zz175uZOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAnCTZzP8s5Sa0SVYG2G4/bPb
 r5I927Pt3n04ZKo5u3z1ARu+8lB7Zob/XkZW2XIair9cZjSHrfRuWnvB9ZKk04nVH+d7G54oLbn
 CCQA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Some gs_usb compatible firmware send the CAN error counters in CAN error
frames, but doesn't set CAN_ERR_CNT in can_id.

Fixup the CAN error frame by setting CAN_ERR_CNT, if RX or TX error
counters are greater than 0.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 2848cb1a75f0..186abc95c977 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -540,6 +540,10 @@ static void gs_update_state(struct gs_can *dev, struct can_frame *cf,
 			 CAN_ERR_CRTL_RX_PASSIVE | CAN_ERR_CRTL_TX_PASSIVE |
 			 CAN_ERR_CRTL_ACTIVE);
 
+	/* some firmware sends CAN error counters but doesn't set CAN_ERR_CNT, fixup */
+	if (cf->data[6] || cf->data[7])
+		cf->can_id |= CAN_ERR_CNT;
+
 	const enum can_state new_state = max(rx_state, tx_state);
 
 	if (new_state == dev->can.state)

-- 
2.53.0

