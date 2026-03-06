Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E333D512;
	Fri,  6 Mar 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814599; cv=none; b=L+f1V8YKIjem7VK8qCPSAzWVyhTpcRz2DXGpsQIKdxMxfgnlDgzwcA9uG73YoGqpliifUUBb6Fwkp3mA2Z/T/mJx1sW6aMULwKoxtrAyDJsK4Tya/D96Y/zZicbC0WsChyIshSpKgycN1B5whPuxlctaD4qDYrnweP4SroXoQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814599; c=relaxed/simple;
	bh=hn2JXeogaIuqlSuRpXcL50R/H5l6JhWQSQ9knZLQLwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp3Zy6Bl607lDt2tdYXswhKZRQoozufxShz+PvxrHjMzfE0y1mLJn+pSgh1jt32uqVQuXrlhNa+ozWKAXEWzJz3tX0mSWUJHHnCfto96/p+0zqwKhcl9JlilE0XcF0GTZ9bE9Ct346V0w2kVV/Qm7jGaqJ2WhuW07fLU9vnBcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=W89/n5xL reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="W89/n5xL"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBh90X6hz1Fg9K;
	Fri,  6 Mar 2026 17:29:45 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBh85Mwbz1Fg8H;
	Fri,  6 Mar 2026 17:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814584;
	bh=PG6Ar2Kiv+3KQmNKtPVULbEJgKNRrIjdmfNlwHZcMEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W89/n5xLNQosv3MMet61JewRZCa8plMisGQHMsSqDNM8iNSuM3wsotLiBG0uhqIXR
	 FM4sOvHA/MmFXGDJe1qvjircHI5Lh6XGmnlwfQ1eY6K1Fnlw9n2ls5JIA5H93vRiXy
	 iNiGl6V0jKAt5LCR1dCr9NgzxxW4T6ActeM7RMaBo8yEXb6CdkKHweJwdU8Bl5FOQX
	 XU7FLOgt6MJA7sOkk4IdtUbAkp0PhbH0b7830mEHhUZJhxe5ugCkqAjwglPrZe2Nrh
	 8OX5vXxZy+rehF6N0EnRkqVOM7mFev8PVqPRNCxXSx3POZAmY/Lq3Z4PIiPFRhicEh
	 P7vqmIEwA4T1A==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v6 01/15] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Fri,  6 Mar 2026 17:29:20 +0100
Message-ID: <20260306162934.22955-2-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
References: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>

Frontgrade Gaisler AB provides IP cores and supporting development tools
for embedded processors based on the SPARC and RISC-V architectures.
Some essential products are the LEON and NOEL synthesizable processor
models together with a complete development environment and a library of
IP cores (GRLIB).

The company specializes in digital hardware design (ASIC/FPGA) for both
commercial and aerospace applications.

Web site: https://www.gaisler.com/

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 424aa7b911a7..4e1b4eeff9ff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -594,6 +594,8 @@ patternProperties:
     description: Fujitsu Ltd.
   "^fxtec,.*":
     description: FX Technology Ltd.
+  "^gaisler,.*":
+    description: Frontgrade Gaisler AB
   "^galaxycore,.*":
     description: GalaxyCore Inc.
   "^gameforce,.*":
-- 
2.51.0

