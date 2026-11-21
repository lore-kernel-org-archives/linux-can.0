Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=ErYgV57D09ZWrr+KAgPLF7hI6N3GK1qq1iJcx8kVwH1jHo2EbmkDDCHr28m0cgcn3OpC
	 PvRXCKNHzLo97rrcX2DmvXVMpF0LTVXQpNRC1DCrqcc0u9iA0ekcFt8B7VR0+EDJidbvY
	 AOap+p9m7Qg8r/ckDu1Au3Fmi4vfsAShbbmWErc/zNoqlt7EXs0OxdTS76n0lzt5oyW0n
	 QPMsIq76fT8fIt9IyFIBp/TlBo/s7oqX6nTQiEWfODqFSfZkeq4jb4MOMz3Mq75nZvD4D
	 /ZNvT+VnFQnFEJRl65j0Y9FcOUhSSGxvwX8cv3UCkJXGl839gmRiTGu5mmV8ufUB/5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/UmeK1a0wlmzNtLpgzX3As6yTNE8riS29MwLgGCpGio=;
	b=qwhxPztSv8qmPKM1zzegFVBaBL0GuMT9aYOW6t7GEx4v5qsoBfPXSvcH0zNfohb5LZIB
	 BzI6Thkcu/WLbJZrGdhA0lVW3Vh7Q+qtEVmBZYrPiN0Vy+7pLOlFbUfBuPufCMJyJ0eDP
	 RPdwSiuZIp2+61HDZVdvVHpMQ/ywwX5Jq4q8rnSlafTQSB/0t9fY/bQtpgM9Rranu13Zf
	 X5UxSXGR1/SC27tlvtItLd2fLHfeMPtlCvaWQtMvfdavTVITl6exWco8QyUUXUicZoZZS
	 +JVXSoiSc1+QNvT8hmW9oCOeyqbFtqVaoue7IdJPyxJ2QyQLL++djoFxRLC6tuLW/0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dwXC9HYa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98323606A338
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98323606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=dwXC9HYa
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3924D205B41;
	Sat, 21 Nov 2026 23:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UmeK1a0wlmzNtLpgzX3As6yTNE8riS29MwLgGCpGio=;
	b=dwXC9HYa1RFT+ZvwHc4UXoqKMe37/wCu3VXUHKmEIxOp7z/3OVNJqzFo1g0yYLa/i0vMIZ
	Xb+dM7BCQuO3M0lNdqIAidS8Vp+JMKaL7oo85KC2ONADPzbatoqMSEvR6im4S+eqg46wtM
	xn30SzFqoSx7tp2zh6ja2GscUwcz8mCembejBa/lak1+MVpMLmUaNU192AXZ8kNbi/4DHw
	zEseDg4S7ppAqDVrLAWrMdy9zpBb+BhKqrbolFeUPMVPGn9Bla7rqZZZRFK/XsUEeoVGoH
	sQdfyoG3t1udO2t1YYjjCNwf5mgd4jqanbCOJ1ZQaTxsqbPhSktq1jEB+/G++g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UmeK1a0wlmzNtLpgzX3As6yTNE8riS29MwLgGCpGio=;
	b=SqvVsxDuHhHpq0IG7FLe71OW6dtgwecB2QuTsoIaorxHzX5W7ImXXgVp03vCWji17tT8j6
	n6kzGnf5GfxgYIqBN/hmTppu+OzK99N98hQZXGpVf/EjHrquwC0G/3lnLtWexl4cTe2/OY
	FBleWRWgB5B7YT2CbCfJQLRQUS7oVlUgSPXE88zlOVDet29iXT4ZWSti1R3FKtNRTycTjv
	Wc6CgIuOfSSZm2e+sYPKY9rbahMLv6kxdRCuhiAItGj1P9W5fdEy7RbUOykkX0sFM+8KA4
	1pkzGlQ8nHSeKu42Cha4jqgqyk40m/1jjzTw3t/DyiggiCCvHmeJeg7gL4etmw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300582; a=rsa-sha256;
	cv=none;
	b=VpUtcrtEzZthpe25CiUVzlm+nPRyCZdLT0c3OriYJLpwVIbNt9vFHxb3hacIDBe7aGAJXD
	olCiqu4zGck++a0BGQTr0n7/qU6aokuuecJ7T1xaS9ljUvM/tN4w/ozDz8bbVRYW/uKAIY
	yJg5q/7oS8LC2H3P8LhVYNo5+j1vAaVVa+VnOR8IuPEbDcETOyQlPCYcQmEEXO8KpnVjYC
	Sb/wTz6qfb2BFkHPX3UDYDeh+mckt2NqSw0SDpQhPqvSw2Fi44FSHMqWbs7+1F9UbB9pH+
	bTZ7ijTMkmLCJzyBo3dShf/23V1I4H3OCdPNmRLvACgMFijguZCbJjPbO5qk1A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:10 +0100
Subject: [PATCH can-next v9 12/13] can: gs_usb:
 gs_usb_host_frame_header_valid(): drop invalid CAN error frames
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
Message-Id: <20261121-gs_usb-fixes-v9-12-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=bbWyPFRANdeI0LeIBI6nRw7JHFilUEtKCOglAgMl2RQ=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmknlwUCp2FrPEUcdFUzr2/b1UvcxQ6MZ+n2u/j9wTe
 6ykfmTi245SFgYxLgZZMUWWpT9OKAoEOpT2vkyYBDOHlQlkCAMXpwBMJEyAkeFc0M9XtsZT2tYF
 MG+VV5+xPCWt72HAogWSe+Q2bOKMf2HI8N/x5EmzYqOMSeeWFSyzcXM7uZnlQYGmG3Mww868lwe
 e57MBAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

By definition, CAN error frames have a length of CAN_ERR_DLC (= 8) bytes
and the RTR flag is not set. The user space expects the frames to have this
length, and the function gs_update_state() accesses the data from the CAN
error frames.

In gs_usb_host_frame_header_valid(), ensure that CAN error frames have a
length of CAN_ERR_DLC bytes and ensure that the RTR flag is not sent. If
this is not the case, output an error message and resubmit the URB.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index e4e177aee48b..a1192867e49b 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -639,6 +639,30 @@ static bool gs_usb_host_frame_header_valid(const struct gs_can *dev,
 		valid = false;
 	}
 
+	if (header->can_id & cpu_to_le32(CAN_ERR_FLAG)) {
+		if (header->can_dlc != CAN_ERR_DLC) {
+			stats->rx_errors++;
+			stats->rx_length_errors++;
+
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "invalid DLC in CAN error frame (can_dlc=%u, exptect_can_dlc=%u)\n",
+					   header->can_dlc, CAN_ERR_DLC);
+
+			valid = false;
+		}
+
+		if (header->can_id & cpu_to_le32(CAN_RTR_FLAG)) {
+			stats->rx_errors++;
+
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "invalid RTR flag in CAN error frame\n");
+
+			valid = false;
+		}
+	}
+
 	return valid;
 }
 

-- 
2.53.0

