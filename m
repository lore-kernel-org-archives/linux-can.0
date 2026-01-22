Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F92D63F6;
	Thu, 22 Jan 2026 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083855; cv=none; b=sT8TxxrbggeX8KbzFIYJYVu9S10gAV+9iJ64ichlZSzKUCdPiDhQvNQKgnXjxDYFU8RLHMfpNBivwWwRCQmKsISpiIVtTH48IZ39E2efxcGzVI5xtOKhJT2hbr3t2ZynVjsSm/HP2pxfKOnT0v+zbz7oZzdNrhDzoWnwqw44frQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083855; c=relaxed/simple;
	bh=4ABjbAD5+98MZmYAf0gnMH/kj3xedfLBF+h1XtnXyYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKt7CzGMcIbrDMb28yuLWMBjuDxDknGQsnlEVAo0YwxT11Ni4KHDDuGIKMaHGBixGHMC1mW2pQNoXe0MNXODy1UkOFtKAxq9nOx1a/rdsD7JmBNB1T2/YAhrldDZzV3gE8wL0DDHz9fZC/XMCZLLq+HbUYBBezX8pXQgXa/cI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=StkKAlRb reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="StkKAlRb"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfz90LSNz1DR2r;
	Thu, 22 Jan 2026 13:10:45 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfz82Nlbz1DHbp;
	Thu, 22 Jan 2026 13:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083844;
	bh=5SH078nohE+9Gm+77QrxCwdEF5+Vk2JfRQSsr5Vqm0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=StkKAlRbbnCId/tMEIBl2XQgLAuoElIuesov3YclhRkNyd3ytDklqXoJ/7nUkObjn
	 nwsAHMJG3SroZpazm82oqQ2bNdgP0X2CpgUL6WWXd11wqRVYILq04AUELYAbUCBxpO
	 buiGklzGBA6jz1a5VhJdd8gwX1jnD/oJzRlYzt5yI1Sb3T2dvk1YvumqIXc8M16h8u
	 ByHMoIKFosnSFL+jnROGFjDKoeVfDrRbQUvwi+0bHhyhC2XM+IRRIqletFYTQfNj/T
	 zdicTUmgKQLdolb0ziiZ3WZWpizONANXA8KM0HkEvQ9VD7vkN1+lDrsCAIk0Tvg/Oy
	 e6WvXfAKgi4vA==
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
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 01/15] dt-bindings: Add vendor prefix for Frontgrade Gaisler AB
Date: Thu, 22 Jan 2026 13:10:24 +0100
Message-ID: <20260122121038.7910-2-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
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
Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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

