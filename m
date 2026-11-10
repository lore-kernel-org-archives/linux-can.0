Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311484;
	b=mh8IWL2MfXHVJo1pxHEHP4QnyreD4H4quz+ZQG+/oYAPVXyOhy2luIE2Q02tPsLdckym
	 qBj4vp9luw1o1MrHwVAFKVOcWyxrzwzcBDVjAGvzuz8CS/BoYz1iOwwBndYXz5Hd/rUGT
	 X7ij9AfaFRRe6gzErd2+QeHnZkfS4LcOrsj29OdR3TOoWTwcZW/H2YxbilSXdg6KKRErq
	 MyNgum4Qhq26nRwLSgsMYGOdGzI/zUB80IS5/LveWSQ/On2pBzJ8LKZVLCOrjt8Wedrrb
	 ZNLg9j0USDzIxwUwoDLLsNEA6JvR6MiFERP63NHQbXBrx89mxIj4moN3iqhEGQLVFWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311484;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=v+IcOeG/R/MjwOSQEWXu7yRZY85IKbBwcYWGhpCGJBk=;
	b=qSN4aQxbeW4LDmis2jPzZ6L45D93GmImy5f6GqQpiCVAL1Ck1zxbpUKbTNPWcvmynVh5
	 ZNWpH+NjkDETjxE3wq5VUSC3/N8dGJCLDjpx1CNcNN6uQGYQHGlmmJEhcKry70JB0F4Af
	 wbXIWjpM7d4GQ5BIzlhvGqSChWdKxbv33YYV2+rwyG3RiZWOk1i4Zl5+jOp0Q3TFWJjNp
	 8H8Sxeu41JSi2c5RQ2IVH3YGGXRInwk7tPlJp5Ace301vI99vupe4JEisMmGvZFwXKEfC
	 AWr7tkJR2PT03K1XJUvlX6392F0jDuzo/GoD5pRHcES+Wn9Bm92O1acFpEMpVt/9m1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="O/giU1GY";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465D60A383C;
	Tue, 10 Nov 2026 11:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E465D60A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O/giU1GY
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 58961202831;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+IcOeG/R/MjwOSQEWXu7yRZY85IKbBwcYWGhpCGJBk=;
	b=O/giU1GYrgWo5l1Karqnxaa3InFFc8cB+VpE40Bqx0VXI+qLaePMEF+iib1fczxwH9lfDw
	8SfN2ZWVwkbo8h0j4k/qfN0rXJt3yDuC+UG7J/mFBr3C14Y0fFhPYrWauQFmiZJHzLNp2h
	c2GLFUZbwKNpgT7GQ591WXDnqHlRuN3JMDDgHr0kD0ycNK0t6lEcMBVSJbdsX8gxOLSiSt
	QsL0bWHfALTMSJbePNWvJoPChRbYOhXWRcVZCEXxOleJ6lwYbLnpfaRSYAm/p7xQuF5VCI
	tORKvkzwz+lCEQkZ0A5z7HXBhJ9VqqJE+nBBxJv3ikcz3U5m85KhaUxs0vUumw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+IcOeG/R/MjwOSQEWXu7yRZY85IKbBwcYWGhpCGJBk=;
	b=X8tLbTWHCEpzO8eTgZwGWOITmHfYTNDVaLgDhU2GjTWM7/eddofVCc4JEJMDOI0RyKfjhU
	K7P2ZVQNjqafJuVeEIPVUWBGVWsXNF1VJhYMqQmTqAi4GvkWctwJyxi5sJq0Dhx1yKT83m
	dzIQO4NIBmV7SI1rItFlID0yVUcFnapnKASEZCv9V7AMgBlCAgXlBXUYA4erTEZ5/eEXeI
	Vy8/fi2lVbpoHDidfAxCJE25lckq3at05AdCnkIeNWljfB2npXeOYe9jTOGuCNWuaK9FX4
	HAyMi7aQLI8k4aL4qxGfiTNdr4YgeU+lmRSce8XzIQctS75xoKqezGbs6ADdPw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=LbmvGRkg28tdkH1n3JTEmKi+gmap+TcsOxxMLHmlSlyzPRIH52orDH2UQoHkQ/DThVMF2F
	sjaZNfkOytq3gcf6XPoRZqDOqCGwA13u3NpX09soLra1CGHs3Vj0Ig14ujDbJcdI22QxZJ
	ZCr9QEBrozlej5xKG3/Kk4UiZfuC/51A3nMWdKC9UVmOkd3BQNJyqc54ud9xEmtj94wTps
	ETLWtEkCY7L/Yl7wFyaJ70IjirY0Eqjmr9aWCxOauewn58SpMzHUyWWqTnM8hiFn9rXrlL
	8QPDxJ0UN2MvehRKovydZLBErpnBY2U1FpsiX8t8A9fSpmWxWEy96ozKsZWEQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNh-003UFG-0s;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 06A165E6894;
	Tue, 10 Nov 2026 11:51:17 +0000 (UTC)
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
Subject: [PATCH net-next 11/12] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Tue, 10 Nov 2026 12:41:34 +0100
Message-ID: <20261110115112.3807247-12-mkl@pengutronix.de>
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

Document the RZ/G3L (R9A08G046) SoC support.

RZ/G3L has 11 interrupts and 3 CANFD channels compared to 8 interrupts
and 2 CANFD channels on RZ/G3S. RZ/G3L has 288 buffers in total
compared to 192 buffers in RZ/G3S.

Like RZ/G3S, RZ/G3L supports only CAN-FD mode, so renesas,no-can-fd is
disallowed for it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-3-b4abfdba8e70@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 81674ea4bef4..dc7437702120 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - renesas,r9a08g045-canfd        # RZ/G3S
+          - renesas,r9a08g046-canfd        # RZ/G3L
           - renesas,r9a09g047-canfd        # RZ/G3E
           - renesas,r9a09g077-canfd        # RZ/T2H
 
@@ -292,6 +293,27 @@ allOf:
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
+          maxItems: 11
+
+        interrupt-names:
+          minItems: 11
+          maxItems: 11
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
@@ -332,6 +354,7 @@ allOf:
           contains:
             enum:
               - renesas,r9a08g045-canfd
+              - renesas,r9a08g046-canfd
               - renesas,r9a09g047-canfd
               - renesas,rzg2l-canfd
     then:
@@ -356,7 +379,9 @@ allOf:
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

