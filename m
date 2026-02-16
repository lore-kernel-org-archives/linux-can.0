Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52B29BD87;
	Mon, 16 Feb 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250041; cv=none; b=HFUaPJke327m7Fpq07vttC9n4mFCyLHOBFxlygdpP6GytAymwV8OGYNSzX+GyWpnDkNLcm54EcaPBUl1C2JwyyXgrAYualFQj0n8BHGn72ESlp//Wnne2O0ryrNHkab6bvJJ2Nj6+l+8utFCpUpmeB3nubq5qB9Jv1y6mM3kzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250041; c=relaxed/simple;
	bh=sUnVK+abi20szbRu/TsbyEYH5sKS317ncvgswyDJETQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FETHBtCs9vbuH2Ml4MXYpxUaVJQWHyS0NjxVlgCwjd4Qciew70bn9X8aKH0wUexY1Pg/Xm5F/nuMSKM+BYd7STBKKdOh4CjvjlXcyIVNP7qvDk7EQISd6/ID7KnJknQQ/0IZfdz+le9hy8HQxxzYW0N4Jqa1LehAarB9ik1bw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=pOG/WYTI reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="pOG/WYTI"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44X29Brz1FbwK;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44W6grFz1FbbB;
	Mon, 16 Feb 2026 14:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250028;
	bh=iX7VqUaWibeG9wCWEco8lmK+AEYcMSSoBfhahTDCOrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pOG/WYTIQnO7kVOdNm2Xvyu8YYfhoLKE4qCzNqNTPxPLy+3poYF/RVIFm0j45rGYo
	 yrgcdIbOSexPIgTlkY5txe0IoQ9dcaZyFZvu30xfFOAM5355UD+vQtEAf3MpLUZJq5
	 t4Jr5yWJ3Cl2cOOVDPbAqwhhO4DSrokuOP04H24uE9265J/aMwtSpoD89P+K1Di1Tt
	 ZKys7ewBR6h4hsguoKwrJwL9v6w8DTB6Lj9vNhoVxf1aL9Bxfeuwr4bjtXytJUAOdo
	 xBrtU9UHbDompMW6FubkZ9T7GrP/ITaywQ0zfTC/U14SppYxcK9F2P4KH+zhKhItNB
	 vwg/ugC76uqrw==
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
	Arun Muthusamy <arun.muthusamy@gaisler.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 01/16] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Mon, 16 Feb 2026 14:53:29 +0100
Message-ID: <20260216135344.23246-2-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
References: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
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

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
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

