Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C813B1EC7;
	Sat,  3 Oct 2026 22:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068044; cv=pass; b=TnbUIWmzcRLbBP9MyWqf/tZvqWTCLsW2FSRQadvTCDDUmTPVVdzzfnCJW4Dd3HVKejVUF9Z72BP7I7Lt0vEhRSk8kTQKnzfCmwy2hNtdPcNIfTMrAlcqw4f3XAVhUBMFaqko1gjv1I92qk4Vsu03xmXDupip5//v9a/q0E+fLwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068044; c=relaxed/simple;
	bh=ecUcEEgqWdjkLWS02kH5Ts40IzFNUqFU+Uv48CsB7pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A8w03M5WG2FJuD70mPQjoXgchPIfQyaM0I5nrn/3x1d7k8TTILtrI9RSzgHsMLE+2VTfC04D2qY/LiZaG2PlV31edPxi63jjt0+bR7CqFvPUKRTZj2X4EUncleHlIixmDHuUrae0usPuSYlCi3oBUq2+/suqvk/huBXNF1rg5e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=GjXfVmA4; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="GjXfVmA4"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5904420234D;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rY+/5jL0OsdQWRX3leggbPE1APv/i/nZS49Q+Jj/5Nc=;
	b=GjXfVmA4E7l0B79wR7l9hOD3VPmqBVi3DKBbq+Q6d+dkd53De+eO3b5q3iwSZYMyjpw9XM
	SzF2WllaPIODUVQ+nVGcoa9Kn7qJOLMgLsRw7OGU1dDHy0JuvcWWz0J8FXMLSN2ZR0PjzZ
	YiCdpXVQEhYKzIIYHVSig6SYblRayqzZEY4khrd5lXMCfNqK/8tfVnyy3gFC/KWgHnwhON
	aZ/VvhDvFvGW2cQdZtTEMloS5AVU0nNBMvhGBDE1QLBXrX2sm889VLbJ5WvAcVrwBS0Rnh
	dHlnl6Y1GAIiCxoyNAaVBujjc6M++n+ONtzdcK4zaUR02M4uwUfCfRNSmkEDQg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=b9FAEYJ4SMmE4fslVXaN3FxRcDC+X8G/gGGEzcioA5we4OOQry0LV4duDUfHm1WaWeADr8
	YsYp92HN/4C6y+iDrMLK5nDob96KDwLjsa8+X5b2XKSbb7vnsFSi/IIubimXGjMx31er2u
	FZUfwyDHDIiJiMSjrQkB7Sy6bOei1nVoD/5dcqzw8gkD322zOmveY8SomlEWmTOGaYfrcN
	6bog6bfxyxZj8kLslxQkPRgyWonOeGLNRSqIGsA3jbfyhTaKOj1o/QoRNz6iqgjG7kkL2i
	vFRU87rq4Cf/3Iz+YEOlaVg1gyP+kE1/7fm45B1Rdmw2vCGYKp/CS1WoT3Bhlg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rY+/5jL0OsdQWRX3leggbPE1APv/i/nZS49Q+Jj/5Nc=;
	b=JNqqtnNoge9yTxoBPpv6QmzEzBCphAbAa4xA+yKnH77MiY3r8UBMrKC3JGG9BCL/CKbbnN
	SCr6g1uqhxDXUa0J3ZF1ghgX1NDX39K0DDtXnnbOvjZFhqia167GJ8cAjrP56Nd/l1+p5T
	COonHG6WQeq8B/md9k7UVq7xZFWzLzRCGFY2fwDwAX1GKrF3+omxSf38YDY64F07l7FgpV
	1oED6kiYACYS1/OVFKJoTivr3+pFvllVLLNnRI7NGhgePD2UH/u+yoly9xBGF2HhzPzhvR
	JEXiD4duuSCXnqmlfd5GtSYpOQtXEmQIiALA/o5mL0DPVIwrRIHKEdtuYbZsxA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mv-0n;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CDD425B93AC;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:19 +0200
Subject: [PATCH can-next 10/10] can: gs_usb:
 gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes for CAN
 error frames
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-10-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ecUcEEgqWdjkLWS02kH5Ts40IzFNUqFU+Uv48CsB7pE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F5m+P4cZ53tkdL+1bHiOS5PTu0+Gm/8Ra0+lS1Y+
 bbxVkPLjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEykRY+R4aRHQVahztQmy4Ln
 PNcr9mioyzNLs6a7LVf8vdLvfrmwNyPDweU7H8QnTOJLZA6RS9GIa4lTt5m0isVgn93LO3qTo/S
 ZAQ==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

By definition, CAN error frames have a length of CAN_ERR_DLC (= 8) bytes.
The gs_update_state() function accesses the data from CAN error frames;
therefore, for error frames increase the value of data_length in
gs_usb_get_minimum_rx_length() to CAN_ERR_DLC.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 3c0464edb5d3..9ec6fed45b81 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -576,8 +576,12 @@ gs_usb_get_minimum_rx_length(const struct gs_can *dev, const struct gs_host_fram
 			minimum_length = sizeof(hf->header) + data_length;
 	} else {
 		if (hf->echo_id == GS_HOST_FRAME_ECHO_ID_RX &&
-		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG)))
-			data_length = can_cc_dlc2len(hf->can_dlc);
+		    !(hf->can_id & cpu_to_le32(CAN_RTR_FLAG))) {
+			if (hf->can_id & cpu_to_le32(CAN_ERR_FLAG))
+				data_length = CAN_ERR_DLC;
+			else
+				data_length = can_cc_dlc2len(hf->can_dlc);
+		}
 
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			/* timestamp follows data field of max size */

-- 
2.53.0

