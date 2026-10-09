Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB74E3EFB;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=dOpbUub69Z/rBLJTkzlAkN42cIS/9nkc/dl96PDUV6L5reTeNICw9sNN/BnslAeamF6LmbVrngO2mvr56wVOK5yImAFZMN/3g152VXh2i0SxjpqKGuyfP134WSaqs22hmv4qhH3ZoUo6DgNk9yj2AsXPnIpj/3mtwKXvXMZsY6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=fwBT7oJptnof8QQ2fqMUv0jW8BE1O0h7Z0Gsq5ashYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MznGjoNGo3bZjFhRk6rpxCIsDTzXUwzOyKn53P3yT3dv3egVMgd9DGirnIYzummWLG1NLNSivaJTidZWgNi8qeOo6/T6VolkHeUq2kX2SLG5OV0kLIWb1QSCN+VUgvr8BwXGVMSbs3+tVs1JKF0Q/waqPqDJ4t/lvkq3WfD51ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=VQ9P4lQY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="VQ9P4lQY"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3921B201CFE;
	Fri, 09 Oct 2026 15:43:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=553R12nP08CYMv930kDDoHha3RmvYHCeyeQdl4a7nqw=;
	b=VQ9P4lQYxv/XLejauya/KCchN0fCr9QT8JALisjpWDekv1d+GdgYtBqghVcJD6ffwJcPOl
	mnxL+3ihPza9MFcwMN5AAiWjpgqYSvCIm3JxXdp6TZ/3HnmqcaK6G6e823CKzIQ9Qv4YmG
	nB5j5ptVJd7mLHmCGKwOtIbKdk3L03L2lr4HGWQlXlGAuITvp6DUIzTlvHBGbwkNiRVLmh
	u7yrHdVo8N9QJ4I/YVQjI//qxV8B+M/qu9vEE39AriY4+68yR/Y3CWSzzqnGvW+QUdIO0r
	PbEnRevPm2fB4iAqxPIkVlwPhCgVC6oSNenvY1S3QDi5pzRZM6OULxEFdb+5uw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553416; a=rsa-sha256;
	cv=none;
	b=HRYORJDgl/mJGVQXrXrSf3+puv0I1fBL5+WtfCFKfksAr++ot/KYyHK10aExNBOkpq2dxS
	U5Kiijg2BKS60DCpLbvApbMHo96xTKjIyv1IVdzxNleF+ideDFhQxuOy8YhlgBo1gEIaXp
	ILaC4xeB8b/ILR6pALjXqo7hk867UMH7ArJjaHXbtSnsl6obKl1/8h2m0lxsJ+bSqBMYis
	PhvkoVZRQyvVU0jx5NDTkCkEqoWb9bPbxuRQ6VrFipx5gxJe2/Ul2Eo5djOBQOeTSnc3N8
	PdsEygh/ucCff6Kus3Rs3/jsyCq11USlHO+pHAdIck9PvQNPmPG4k4m2sohNCQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=553R12nP08CYMv930kDDoHha3RmvYHCeyeQdl4a7nqw=;
	b=NI848Xt3OD1BZe8vBcFE16J6ZPy+GlAkxyLi8NVt7wF21uBxA4c71hsDHGiZ0VeTDyTb5M
	qP2csPvV5JtLUoWq0zVUg/9ceSaYXgBwHgeaDSKn6QLtXR5acQp9WfyXr9DMMAGwbBybgy
	0xGQ1LOw5lje73vbrMGoQrLJZvSv59S7+YdVcMJwhJqABbCMsYT7BfLbct/z/HyCoCe2IO
	1pYpmFPE4rC1TR1uDQDNkhy/tU9+9X+ivLuR8OhYLfXAZigacfAKPRTX0IL8LRbnyusi4x
	tk8zrl6wDiS6c2MUpknrGofcZ8RdE5n0v4vmrtKmcgQRRGaGsIKr+5JhJK+cOQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsq-0053SW-0R;
	Fri, 09 Oct 2026 15:43:36 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B05315BD8BE;
	Fri, 09 Oct 2026 13:43:35 +0000 (UTC)
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
Subject: [PATCH net-next 16/37] dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
Date: Fri,  9 Oct 2026 15:27:48 +0200
Message-ID: <20261009134323.64064-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
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

