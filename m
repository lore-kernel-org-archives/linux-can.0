Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=jXHN7DwmTaFU53Im0xwhltmf5V/tRCU/UmTyOdlIYDJNamAy01Hq+CqIc8UfHl1MgI3T
	 eCow7e/R/9TTgPlyGaI1lu0Cl0h/z75G89xM4sh9kB4vzzw0+BvdUXHjZ9zANKUSkkB3M
	 mUUC4dNDFPxRsQjkqVeGO4ZdI7gL0qy+KWS44sUsMd7UTfas2Xj2PUh0+L3vKcDaH7K0q
	 LkC0wggR9TMrdoWi2NBs0v62aJkdBN+8xvOUnUaRjl/vJK0K0g5ZctVI1V2lT89KXyplT
	 M+xBQoi5Xjmaql6a1/WK7DEzywRln0N1hEC5HfWdmMoR6pgc0eLAmV1vlJjPMyBch/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=ABNIRh38xl8PUag1yHL+i5r1ydaE7nYJHcJYl7v2j/9mi9dsdMInLSgTMKV6C9xUiDry
	 ZonwmXlfN84lMIqQUj69R7GG9n1NNzTH/5lTvizXbFWZn2mgFjCTtpJw3d4+nKpEfOSBH
	 6H9XqodZtH+Dg9fcMAseY6crT3oTZx/LNGxBpwYDzCbVJNEmqXWdTDoveurrk/O0AtkVM
	 ZSjpSsIRu5euSF7wm/C4ZjhEtlQNWU7uQSzaE/gW7iaN4ipRTFiEvwZG/mJPMf/FX4leJ
	 PG25BkzQ/BnPyEOrUWkADSRz+wxP2DlasuTAAH3g4Gw2Sl6i7Lk9yM6IGhrbAZZehDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L+Qx0CUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185F606A336
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9185F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=L+Qx0CUk
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0FB5F205A28;
	Sat, 21 Nov 2026 23:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=L+Qx0CUk8tmbnu104ktxnpE8tTU8KL2ltFXO9/VX959oNKdvTiJyDolo4UgwRdD4QNp/Pi
	Uc0uQOFDN3Qs2XFNzFMHorrgwXG2iMm4vEIQ9OMfMLT02gUqWTFEHLYQ4j0aBVagjiVHV2
	n2y9kf84Tv6crinCfMuHldPYNiw5RX2kr63FpH/roCUj7sye/6RWvQbHrYVN4YBWsmFMxK
	C3UyzSbTQcHAzkd8xe6CuyvAqdbTGzDT+OnTe4sJmp1BLnUXOOTqwYlNBE6n8Ij9geUmRy
	kz2JkEIgOawa/Y4Ea1Jyi3QM6vOsKBlA40BqD5BPr6Yg5tuSCCqZmWOXoLh4jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=VT1lYnnk2sOyxSbvHmnnNWrXcv28N4iBXTc2wmk5MJr7VyCv8lBzgb1leHYk3TDSSRPiNL
	xnhETmQYOoNmLHUP89KN89gNDvYpIGedVgnyKbh5beoYzVrBAm4DCIah7ekXOn7MfMkXV0
	1NeDGxUvNTzB4Hoou5RvV8dmfHUfMLhaOp6ciVW/2oJZnMtt578yiO9wnWV3Zwc+SzSqPr
	og4fEldDt764jQK1jsETHUtSLg6b0rTJbr2YfEx6gKLk/Gcc+4vGAS/rXC5Qu4trgy7TZC
	4CAt8GBL+w8uiRBl7WLmwzdTRMjYBVeBdNCGliAD+tdHuaW/MwQRzqYvwddE5g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300581; a=rsa-sha256;
	cv=none;
	b=bq8dHl0r/l6c2YzSE0PH34ZQRvzCNKWKIDeB8yv/nPQGKNwcEc8bhEfacHZDNehnaWYTTa
	ZgPFZn31iK0CCvt1eCYlHE49iNRWHipVhl1s6yqTzADCKSLaP0XA9IA7RGjvrdLdbKyY24
	C8r9lkA1j41yenT4OOXOv9QOWbDcUMINz9ee2T//7QTiEVxulm0x02DwBmWCDoCm8hs7Rj
	XXHIYY1NovcK+hz17cUqc2yrkl7CARgW0aK1myo8DBmr75jGMTPedzBATpdh0jZSOE3TFG
	L6djqVlIS9F0xKBdNIFN+e3iw61X5afXi98lWKLlbSeVq22qmISmqdFTDS2HaA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:05 +0100
Subject: [PATCH can-next v9 07/13] can: gs_usb: gs_make_candev(): check
 can_rx_offload_add_manual() return value
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
Message-Id: <20261121-gs_usb-fixes-v9-7-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=umwuiygkz+GlsP+TXLbZeiVlj3Vb5MSZo7ti7igGEY8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrldKOD5eY7K7bUmRr45m5ev9FibNeWnVtuXJLtb8
 z5orajq6ChlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBEtlUyMswq+Jt/sLHhWtP3
 H2cDeq9IX3731XPj9NMzVy27OFnE5IYdw3+PDadXntwSJXXGTykw29UxIWb1rTOfvGLjI87dDXX
 vYWcFAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

gs_make_candev() ignores the return value of can_rx_offload_add_manual().
In an upcoming series can_rx_offload will be improved and
can_rx_offload_add_manual() can fail.

Check the return value and exit via the existing free_candev() on error
path.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Link: https://patch.msgid.link/20260907104942.17089-4-ciprianmarian.costea@oss.nxp.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ab82dc07f3f5..308daa2645ad 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1553,7 +1553,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	if (rc)
+		goto out_free_candev;
+
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	return dev;

-- 
2.53.0

