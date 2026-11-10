Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311483;
	b=HtcN/NGKmwJ4pSCTXUk4SQPY565x2LhQ5DXy7MY57gDLmkezUN7zTPkl3rUVopKVtMos
	 qjrOkX88o2cls0JWCvwn4ZDtBkZ+5M4DeYkJ4kJP0gDdVxJCkts4eGP3sfqAlW69hiNfa
	 fIuE0tbVxhwwR6NP0azRqKX4/0+EapoutQGAlbam7VFSoQ0ptxx9kkgkujtTRdF5EsZVW
	 wxTLw82PR8wp5UWZJtWO2eEEA4xzRlV/CEdZfcArW0jZx71O+JxMOo+LHePSmnMK4+/2L
	 JPHdLuaode41Cb+lshx5RlxjpJl2OX67VfSGBCz7ShSOGk+76xTGNboi3ZObMiBI+4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WUUlY8KP9jx98U40j4Bemb2QM8e8n/qq7NwYn8gTWGQ=;
	b=vwPO27vy/merE6uTmY0vzkA/d63xfHJwEnKwUT80AgjXV1ea7JXvf8aHJGcJEKuBs2te
	 mw1l5WFX62i8YeNC9mrkgYsnDj+q33gV1hw8z+uPMuSfpjELKgbfi/mRRvJ1vRwatfk2f
	 Hr7bl5Ur7fRUQd1WkF8H91z2UzEh6v5WG/+tjwe4l19JAcUG03iQDmAVgmxwAxY65WJEw
	 TkzIeQTom/XnS9PBzxZ8WOpLP54spbNSYiCk9mDFCv9DHKt8jtG6dnNyXGc4f5AHdMrXV
	 3S/VdSe4Uv9onP5b/SfGtefU04Gwa8MDraTlGLohpm5uhwsuWndOsU74lDuGlLQJ+3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PmZ8+lk7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EA60A381B;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F20EA60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PmZ8+lk7
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 387BF20282E;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUUlY8KP9jx98U40j4Bemb2QM8e8n/qq7NwYn8gTWGQ=;
	b=PmZ8+lk71kmSiuup5gFRkhE8rWfZ2qhNH2Rr0C/sPjn9Bp2UtIczVfNhqjJRbozasRc0Vw
	97+UyAYpGmo01ZynCQ51ysWsfBGc+hsOAwJMJp+kY22bl607vL8Ah47yAAHACRRi+wYQYg
	c4LaeGD0LfzIW5fELOna1geD5qiC3lG86JTG0/PWHRsjyt0ERQ87chPWwQ0cTVFDaqpXwa
	h6y94NV2mDOgZg39EEEu5vSPItP/9Rz8ljjD5ddhLKXmAwPmoVUsbfQ8pkpMdn9i2Bvx4X
	7JCw/BOtFZ0GpP7lEMyu9IHLi1ffh8vQnIzrSd9Q0VOH2PV4dnRmCUT0y4WBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUUlY8KP9jx98U40j4Bemb2QM8e8n/qq7NwYn8gTWGQ=;
	b=Tg8wxBwDr7Sg0LuaLN/sPjJRjJa0iNSHB7G0nfPcyEANz7Zk3eoMhI4ac7v7qHp/ajP6yi
	wzcBr2S2gNg+lVF7gqYaktgZw1pJku4FX0HyUoB7R7tcNiq3qDR+X8OrubZ2kt3ksXnLZC
	MqX4Ig+SUYjN66rzg3J3pw1OZiBy0Jbw/okna6TcqKMwrBgzTZRuzvY+waDWNWVXr+6WUS
	Uu1wLo+5VuPsyBY5dHVJtpRRAqzEikmTTX8eOrBVfyV7khPDax7wbg5oyuOabyHhjMpROm
	3ijE8NJJsV/UpGAEVhOh1x1+DBOZ02ObkiPTov+mHMqexZBiPh1/vEjNXFEJrA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=fJmk2l07SZ4o6NC+5Jq7QxwE5DkbSuaSIMO0x7yh5HKsMzcNcETCQIhHESiL5L3p0LhWrz
	n1kvH9/ATE3ffE98NZNT8UVlvILPjKx7lt0AHNBfhaUADujePFCFc3/zFGssweVxVJb0jy
	LaQhD592nu6hVxot3juQ25578jfb020ZpB3UMBSpb+zWULm0aKDl3SCtxiVUGVffIxt/ja
	FvWNgIaojEVoQLk5fq3SNWouog9WFQBkIy2kwdcl7ktE/D/zIGZLQnvbpCBSaOctvCoRdQ
	dZ0YP2SCwDO73PhjVPxnx6PFmo46f0TZe0k/ss/KcNXjTDqqaQHcOrzE2Q1bRw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UF4-0N;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id ADE585E6892;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.au@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/12] dt-bindings: can: renesas,rcar-canfd: Simplify renesas,no-can-fd description
Date: Tue, 10 Nov 2026 12:41:32 +0100
Message-ID: <20261110115112.3807247-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.au@gmail.com>

The description of renesas,no-can-fd lists the operating modes
(CAN-FD, FD-Only and Classical CAN) and which SoCs support each one.
This is not accurate for every supported SoC, for example RZ/G3S, whose
CAN-FD controller has no Classical CAN mode.

Drop the mode list and keep only the statement of what the property
does, so the description no longer implies that all SoCs can operate in
Classical CAN mode.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-1-b4abfdba8e70@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml       | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1a7a9ce45e97..81674ea4bef4 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -145,9 +145,7 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN-FD mode (default) or FD-Only
-      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
-      property to put the controller in Classical CAN mode.
+      Specify this property to put the controller in Classical CAN mode.
 
   renesas,fd-only:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.53.0

