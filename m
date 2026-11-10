Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311482;
	b=f1v5/Jviz2bcBic5Z9abutKqc5wpzkNJq2/NsNqkxOVQRVCD7Ev/yZOV28kIy1lzDq9S
	 s1eDCMkTckjklG/oAJpl1LZAPg6G4vwfzBg0KcRYjw3J8hfZ/uDNz+pofQ5jVWpMigdXe
	 L+TAuzSP4zHlc4PAXD37N/70U2CCZJ3QXrLZ5WlG4hlak6J89e/kHHJGiF9uRlct+9eML
	 /HdDPvs1SOMi6ByYSihKZztvYTxYe+fBKb/PehrMLxsKV/SCZuDBPgd1N0uhUJKWmfmMv
	 OoIZCmP4mqDh/ZG5dknNMopE0Z2x3uAtFobgNt6CQWLQ92dS24//8UH0zZY2O4ND4UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=gV+Q2dBRyZdeh4BqPZGGCmcaiTGqFzh7qR5iFTf8qK+c6OF92mey3ZaR0yEOX8FXZwCS
	 btekI3RrR/i6JIeAETQi0K8kGr6f625b+D4v4acB6HSJEFfErG9lvJg5VWSk1NsS6/xxl
	 HCWaVYE13ACKqCjxYJjmDCRB08G86OhMmvRfb0aSTSLPWfMiqCAlzcQvi5DlY8VAKyYSF
	 Y3W+uJwcyFBVj6Ph9WSSLlBvaE9UtWBYDwKG7WVu/wm+vDLBXr07fFObQSZqu0hKyobam
	 gdudg7DW7sxzeepO7V9NcyGZncRAuG2uazQtZYfT3zUi4qmcR86qmVkdXzLnO7nvSIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U16zCeGT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1460A380B;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E1460A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=U16zCeGT
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3271120282D;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=U16zCeGTxeZBizJpVnyA9GSkAS6N0n/hdLnNVZE9VzpcKq13lZPHZRmpY4KFy9u2fLWFFX
	PB0sKseJtrPtlnhG5BnWhn7QV40ZyRzKNKg/f+JIcwXVJTr4doa63b+Y6s4MGP/PXKo5Es
	3kNNORiVjih8iDJ2B+aAsAHFRlaCA5d7KBnkwX2AYxGRBoA6cpzv7uWUThYwLbPDAwQ6Xu
	UawbwnNfGpsnzF2N5CCizGAsDcqpq5UTiQjQEMjlPSJwVpzhw/sjJmLL6A0ltxnc8QJ2Ov
	rN1K7+komKjp5Jw3puAzIIzI5E0po6q4tcHRSMNg/iYkgeFVSl3MP9HCwzmFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=f0rAwK4PlGRfbfJijbccGl/zrNPSQ9qEUdNjNW7GQSccbBLR4gVstBEiKnbQsLKpvrLpmE
	wMpJ1oxIV0scJUux2kaednucE8oHrq6Y9D/rFbptGLCZ55A6Btezh8VX1E8xyJDqJ2ZftR
	h7eK9xz45CAWYC+t6qAlJCDxK4TWcwox+0o58pkISijD3KZsS+xEytxIl/F4BKlAKhgUjn
	FXx9h7Nvxyft+PnVY2LDR80wkIkux28sFObGH5hsuZqPNVLO9or3SPPbce6bFmOty2fh4H
	WPgwLxZPufrqjPIAkPM1L2UtH3SzIgZg8/1jXKz5BxWg8lVoOmactR2UOKLQpA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=JdXD99r/20D/HQmoMeUvPiGGfJ8aZG7VPRoZmtuLaOe3UWzqRK5m8smaEvSbE8GFjvIvPg
	c8DX/kRg9nlk1w9e8IQ3WSqHIqVCiqSNr2cR19vLo9/i2/owHK8mjydsPsN/mmeh7KXdJu
	7TayiMhH2GW+Mb4t3hct4koV5lKRgxAIaooRb/7sv0IwPyjmzmC2j4ArO4SKHIwmpNrlAN
	BPidSGyQqYeDRJc+44WHiw+6AE+1+gJAB6W25fBFCdLkwODCfWmVpudyhuZR+D6NaCeblW
	C10hNM7yzmzbOacM6d0JAPwzMenUXOFvIrg50s+WN7k/FOi6Dl+M2KatwpXiOA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UF1-0I;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A2DF05E6891;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/12] dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level
Date: Tue, 10 Nov 2026 12:41:31 +0100
Message-ID: <20261110115112.3807247-9-mkl@pengutronix.de>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Properties varying per variant of the device should still have the
broadest constraints set in the top level, so add such for the "resets".
Since top-level part says "reset-names" cannot accept one item, disallow
it for the two variants which do not use it in practice.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index bbaaef8f4282..1a7a9ce45e97 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -133,7 +133,9 @@ properties:
   power-domains:
     maxItems: 1
 
-  resets: true
+  resets:
+    minItems: 1
+    maxItems: 2
 
   reset-names:
     items:
@@ -209,7 +211,6 @@ allOf:
 
         resets:
           minItems: 2
-          maxItems: 2
 
   - if:
       properties:
@@ -231,6 +232,8 @@ allOf:
         resets:
           maxItems: 1
 
+        reset-names: false
+
   - if:
       properties:
         compatible:
@@ -246,7 +249,6 @@ allOf:
 
         resets:
           minItems: 2
-          maxItems: 2
 
   - if:
       properties:
-- 
2.53.0

