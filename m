Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAED3839B2;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029230; cv=pass; b=tJqh1Rtb1DL1WOtq2yFgmPJFHZFI7ycJOSzQY+rSRvxEGWlhw0Ctwn9btjQbMs9YShZ/uc0iluOu91kuSDRyaHbHyB62DfLsA020aKVC8XgoL46k/qerPJhVsblJThgh7DgB3t3GHckng5jNNOG79Wph9WxoRN3/7YXSNIwX/TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029230; c=relaxed/simple;
	bh=cVv64f5BQoSA8JZMbM3oCGMWHhPHO6JQHImCr9SPqrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBomVENbks4Nk4RhJfNE4amRKp3WrRuWeHoWPxj52Y9zMoK1L1kYO5rE3TzzBX8Gv52bAAVzZlzmKzcEjswfnWHvw1si+3aCV1md9LC/FKBRFT4perU3FZwyVZQQRvCqtsG0KnP7zVTwQKSYv8TZ4HnuGn/O1wHbGEud8pWhX0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=X0ewJVzN; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="X0ewJVzN"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id EB1D72027DC;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=X0ewJVzNK8usNZMUMzi+DH971XPIzjv047hqFiVyR0LwZXE0OIzC5ZXHZK/LIzr78dGxv0
	iK6BEepVoXEKnmnqPL30rRXsGVrVhWzCdEAFjnogXxVQ4YqVU8kH4i81iLBo8q4rDsVgB2
	33FyUo2DGLtUq6gaFbf4CAF5kkI9jC1eS01Dm3WLe9gp6Px7QnjTIiRbKxW17RjnVBE1TA
	p6t7ZJbpUSBJqDj2APPJ3+8GhKIfaTRhyNbI3XgxU4PqojCZNy4ULN1P+gIiJoTkF7PV6B
	umyWEwy7fKDlIu/rEYIrW8G4aF/jCo09RTOEI9ul4lilOdL+7JRryOuIppQWyg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=Vt7jhHtVVahiK+ZfNzjEybLYlITnxFJjYGbF1wCCdY84yI+eCe3LR8YKL5BRuE6zF2vEq0
	L9yBpdOw+OcETFI7YogzwMA4HI19bdnCFbQL+uGtdO9WcseI3F8pZGxJhG3iZQ8uQMqkDA
	by1QOOjaXaCAG9YK18cYg0GACgnyk6m2zF1HprFPjPzg2RGNpgQdUh8Sc6KlrZMUGQORrE
	8bw9f9rn8PRIA8Vsy7kWv827BTxrAoNNxwTYDuMw3hLbq7u82ZQRFJRBwEqvvaPvZd4pAq
	ZaS3Ion9ZV0j3lViPiaN98jru7z0np+74d4BgltjDH3hEooHUC2/ezY5mx0fYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=bLFzpyRJJ6YPbGptibYxvRxDGRhyEWF0gDFTi6A1x184aFKzoXb8SMw5XknSleaE4Xa76t
	nikoAGBENeNE/2pFvsA2e7fEgq5ForPGTApHbxUk9v2NaoF7nCLZ3eh1LSJARgrOA+p6kS
	0am8A2CVs8q6aAlAb7UGcKUOKcs09MKQshVPyMD31Kv2K2Pw109QlCs2Q+koOv/JwC5uY7
	WqD1f1HV883NNBtP5YRPMbLUNgELYZU1Vf0oz7hmmz/R7tl+XqK5tDU4Tyv2NZ77Mice2/
	socqVbEmet2s5Y9dhXFH9X6gI7aQRQeD4+LNGreqHLnwq1QfLKE7CywDkQRqag==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqj-2m;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8FF2D5C4785;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
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
Subject: [PATCH net-next 18/37] dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level
Date: Thu, 15 Oct 2026 03:40:16 +0200
Message-ID: <20261015015336.816543-19-mkl@pengutronix.de>
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

