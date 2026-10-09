Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6609A4E4308;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553424; cv=pass; b=tyy1fqVYgFw94vYrV3u5vzGhesTmM/aYgpMYvTnuNilGHmR+5uy/84plw1jdV+8LxRi8UP5KVf6fJDZBc4b0U71auwUe23gQCUGuq5cQaL2qrmoTXnUrdze8TWhYP+oXcVYxgvuEXm650flr3MnM+wncHsnwP8KhHxgS013py04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553424; c=relaxed/simple;
	bh=cVv64f5BQoSA8JZMbM3oCGMWHhPHO6JQHImCr9SPqrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEcmxdjD7az0/M/DPzzFX48d8EAfdnM2qMcb4TzgLQA6lON8G5EjUOXVGJXfGhFVmWW9ZGnoHNdilsGFIUid7LfyfTfbZ0BKv42W3Hu0bZKnRw7QbkpQJdr0dObcurl1PsaW6nxcV7287d6CYX90AUYvQEabwldU6GbMdLdhVOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=doq/Tw7d; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="doq/Tw7d"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 65FD320265B;
	Fri, 09 Oct 2026 15:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=doq/Tw7dgwhs0WnQFNnVN8jG+4mvkhFqiE0v8UYsXrs6zSD14gbpEi4AYlp/MbeCePk1+4
	mSBZ8cHWgqRiV1nDai/p93c0VoGwzmjXVyLnG0EI7ucCNAeuhxxj0l+HLHMntq8bZfRkYL
	Eoz4gGdMZaqlYjLYQTAFL7Z9nmMVu5JEs7WCyO+9tUX2cgZiAf7EgsrYBxg7MyIKqHqAIr
	n3c7cXTaZAnRutSFIPnp/cMZraMDNPHXVSNpX+qcgYsNzUTjInYGmC42oCraZwTzbO4hjb
	OD7Idft/o05X1CQVbYoR0+2oEdKI1HUj69aGlgRIW+0qY1xx25EG55ZPjQ8cyg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553417; a=rsa-sha256;
	cv=none;
	b=T91bvkb+boO3YZeIhR+XL5bOAV5FkodewzWfh07SyslTxsjujkfh50nEDrzALyX0TCy4uV
	AW4zZUKjZAflVyQf+eR/YcUJhB4uV3BhUogZxKQPaXwdY67gz2Mp8dtfKx1hX15pcFl2CA
	2T52pJ2baBeM9Pxs5WvEUNIvFMg7kk7C8UHm9HSx7ZdU9P9a6FQYyUUg5evnwSCk/AbXER
	1jvtIVc+kxUQ8H1BUtJRIspW5oDA0ue5wLCLsckJoQyPXqF3ksOaTIURVZN9veolomagcc
	IUBFP+NlA8TEADBDsi//va2FH6I3qm75K2rvkebm2m9ID9w6bHS4Eo7eivGvPw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/itt5lMWrTUK7wO99+ImVfO07iO2rvmAiQrDKdrH09Y=;
	b=IDx9ta4wDqRr0v8jvWHF5cQMM+8Nir+0iD9Alc7l0F5s/VpQoVVA/9t/bsIKwIWiBkFnb9
	5navzEC24/02EiJ/cL+5Ex+DClivfEQdphPFnGcsBPeJQbTsmuVC96yjiUW/WueNmq688I
	6GUb2mRJxKmATCfXZTM0J3wFjaWaEBL4l+jIneknpklSG6LR6XCgNR52lqcflWqP+L5k9T
	Yp8MH6fHV8CA35L3OWvuHEOXmi0OYTDntlSiZzcYKZB0JUemQ8M3dVHdNPdjatvBXYWwmN
	A0qoxf2ffujvs5VGWwNpFyaFSY/EJWypl7QVnlqb7TFHOr72LQmctBRRqBHK6g==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsr-0053Sm-11;
	Fri, 09 Oct 2026 15:43:37 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DEFAD5BD8CC;
	Fri, 09 Oct 2026 13:43:36 +0000 (UTC)
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
Subject: [PATCH net-next 20/37] dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level
Date: Fri,  9 Oct 2026 15:27:52 +0200
Message-ID: <20261009134323.64064-21-mkl@pengutronix.de>
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

