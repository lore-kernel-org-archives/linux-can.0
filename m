Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C562EBB9E;
	Mon, 16 Feb 2026 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250038; cv=none; b=agKztCdjy6kpKF3SdvIdEiIEfgo8Wa21dA1TvG7g5i0ei9oiTHBJM+qt/hk5IVi4n/l4p85UIK687Ae0Lae0hlREGTg3Io7RSUNZxo9SdRkATFcuLDwfN2TEn7YYJDGug9ZpUKklQ1zh+O0s6PjlAV2pfBLj8mba8hsya7dFXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250038; c=relaxed/simple;
	bh=hG5KSuPtLiBtHjq424HSyAbeOdsq1PzCy6qL7NHd2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZG6rP4VE7E8GnaDs/DHfsVVQXXTo+71NSrnMoq7y/g20GXatK8S/ToB8Si6UG+U7qbBEekZknet5xn25lpYZtAcUktjGoBdhsuckRCT8ayswd7Ubc5BPFaZ3GYohJhlzSr5DdL/YqBr31iWkWERj+4UmXfOBADlfU7AFtFoN9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=VVkhbCSp reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="VVkhbCSp"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44X6CV0z1FbwC;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44X3Y4qz1DPkL;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250028;
	bh=lDfZgx61aSWUJ1n5uo3C1KLCGawncX5ACzgdlX+fljk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVkhbCSp9mGizEQZmushGraMBBr9X2oo3+KU5v9JGbzSXyMsCa1Lks6+diMxhUPSx
	 4NC808aPql3c5+MGxDkwRdYXpptlJCkWDKm16vKMDGa1oN58rkTTF+/8dzVDw2KHGu
	 CM4HOi+Jxy6xNf+5FXZGTtqsmogeIKSSiUWwvw9jTG5lcoDleEmfdUehw6/MC2XQId
	 OSM8JkqvfonjR6W/THJj9CLAS3/P4nWv1iJ3pJp0KxQ6LX41qocPuOxc/uZY53hPEW
	 uyWJyXveEcOvo8gn5+iXkc4qUZl9kjfPZ3U3iecZflTx3e6cOYkMxVebLYCwlTRMDX
	 2H6UIAj8lBpNQ==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v5 03/16] MAINTAINERS: Add maintainers for GRCAN CAN network driver
Date: Mon, 16 Feb 2026 14:53:31 +0100
Message-ID: <20260216135344.23246-4-arun.muthusamy@gaisler.com>
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

Add Arun Muthusamy and Andreas Larsson as maintainers for
the GRCAN CAN network driver, This entry ensures clear
communication channels for maintaining the Documentation
and driver code associated with GRCAN.

Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dc4aa37d903..14ddd48e063f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10706,6 +10706,14 @@ F:	drivers/gpio/gpiolib-cdev.c
 F:	include/uapi/linux/gpio.h
 F:	tools/gpio/
 
+GRCAN CAN NETWORK DRIVER
+M:	Andreas Larsson <andreas@gaisler.com>
+M:	Arun Muthusamy <arun.muthusamy@gaisler.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
+F:	drivers/net/can/grcan.c
+
 GRETH 10/100/1G Ethernet MAC device driver
 M:	Andreas Larsson <andreas@gaisler.com>
 L:	netdev@vger.kernel.org
-- 
2.51.0

