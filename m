Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79AF3839B9;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029235; cv=pass; b=l9SRuWs8ns8iq2jSBuBW2TVmFhgCeSMkM+jHRCLo/oX+AwtfJfI1P2ExtN90jriDJQDHKlVww9DYjJTXhwA8PZPlSgNntf1e94tbMhxEo7HFwOUVgv4bwTHlW+dU83uY/nw1fYyv1nRXTLXe19LyavYS1yesui6bGYuBOmHrCSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029235; c=relaxed/simple;
	bh=fwBT7oJptnof8QQ2fqMUv0jW8BE1O0h7Z0Gsq5ashYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sczaMT5a/woiZyta0q/X2ArsrhFKjHIe+Tb9IC6GCLQrxpY2tgma5HCBnOMUzhNmFO6yV3sd8R+GagjnXRzZzVPWcejngUfADRsg1q6ayg+1IdczIveEfYuUDuPNAHoswLR7nNZttjMZQRcpyYKDA6iFffD5lQzOAq2IXLq5G4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=QITinIjB; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="QITinIjB"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3B3452027D2;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=553R12nP08CYMv930kDDoHha3RmvYHCeyeQdl4a7nqw=;
	b=QITinIjBlZhf48JEjQsAwH8yhEr75epvKl98lv5PCFx1WLIuA3WUDTJhQm2WGNCm9AkZKR
	4R7SPXU3G91uYkfyvytgqDRXOvbjjrYk2s1e0AaeiIhZktA7z0+aX4JJ/dhwGCzbZlnqr5
	qUMfVhvwQEvN08Yihl3bAgYiPQdiGGFv2mxo00khgO2W0+SHASQ2mGJ+FnELwAEfMZyX2l
	cyLZnenJfsAh3RNdso1NAE3yBmmBOf/0F3az5mTzAMb1pIefardda9bwlA+8NI96ImBOAP
	s2iwQfb6bnTYY+kxuLz4ntUz3x+ylUR24+VMbujbPMlfyyL3CDIawkVM+8z7gQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=FWj2TWwKQoJrQejpfBdE5LZ2dgfrcQSTxsLUHXJ2NqlqjE4JmzvVswR/D5rdmgg3+xatpI
	SW8dAPs2L1ZJcg2tAsQl3xdxUmpTcNpqWfiQTXlT3cFCHw8fLgR64uBON2xPcpYihzKcm5
	M7EOPrbDb8A6Kjj4xKHsMmbjQ7T7uHIBeSUXFUrdjnJNrNPgepXkEGvyR42AZ1n0ZtLX08
	O//+Kv5dd0G8nHQPk5oR2GWHluLH799S0xcuZ/7HlTxGVx8Zo82YW9kK1MqzbT1+LTxDNM
	2ZPkK5CKiXiCyorQzD9jO2QeNsV9nRfEUZcqTkPhtNo4UbHsDfdUFDULao2HCg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=553R12nP08CYMv930kDDoHha3RmvYHCeyeQdl4a7nqw=;
	b=eNGcqtaKYIEJNbNxqj6rz13JAslypOcikHU8ri429N/OcVy0+zMv8rzbKC6L9cj6BiZJ1x
	kpIHRKphLyTRhHC915yA4s1cz2MVNUqagFCJ7Qa+Q86Lp9YT955FEFnkvRl2NOfMMXxs7y
	B87sbX5mv9SIez2ipQocR68EhdRp1Z6jUf0Thc3kGrTXxmaZNWAasFN51aJdDCk9F/i8E2
	KnygTzATdy30OX+uyvOsc9GuHQYes+kZE5LP9UM639n/MXhWPhC8ecoyeKo2a4lMNSLSe3
	QzRG7bD/nTNub/p2FVwgZ8fcjrYBkEmrknnNTxY8QRCQm/ckTqYJySpD7Dlq1Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wqu-0T;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A9AE85C4786;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 19/37] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Thu, 15 Oct 2026 03:40:17 +0200
Message-ID: <20261015015336.816543-20-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261001075742.21961-2-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 1a7a9ce45e97..4b94bc8d911b 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-canfd        # RZ/G3S
+          - renesas,r9a08g046-canfd        # RZ/G3L
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -294,6 +295,25 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-canfd
+    then:
+      properties:
+        interrupts:
+          minItems: 11
+
+        interrupt-names:
+          minItems: 11
+
+        resets:
+          minItems: 2
+
+      patternProperties:
+        "^channel[3-7]$": false
+
   - if:
       properties:
         compatible:
@@ -358,7 +378,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a08g045-canfd
+            enum:
+              - renesas,r9a08g045-canfd
+              - renesas,r9a08g046-canfd
     then:
       properties:
         renesas,no-can-fd: false
-- 
2.53.0

