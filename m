Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB13B530E;
	Thu, 22 Jan 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083856; cv=none; b=IaqHQTFdODbnpcL6Ox3cgcjHijM5L759HW7GsJx6bkvc54o3xYqrndPSGqqP9GdrhC40IsmEm/UCf2LshMKUlkcs3k0mye277O1EWJMrEoNK1BSYi5kTQueMppL8YymYNsvlxTRCpdbGwLTtG7OjFRP5TFxFtGUk42kVOxSVzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083856; c=relaxed/simple;
	bh=hG5KSuPtLiBtHjq424HSyAbeOdsq1PzCy6qL7NHd2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgffIjX27oLigRCkp7sMeiQ6O8YsOHwnu34dFZwel7ikqOmAf1FCGJskV49wc6zBc2FGS6YLd1IsHYkHwBe6CCkvBeBjIZdOm8ucwaRSUzP3CpD5APrhG/iP+2DBZD4DuNr4PuQiJbE551sxJhjZXlsAZssDv19WswtRb/4c3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=c7Yptj0l reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="c7Yptj0l"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfzB31slz1Fgd0;
	Thu, 22 Jan 2026 13:10:46 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfz956CRz1Fgcp;
	Thu, 22 Jan 2026 13:10:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083846;
	bh=lDfZgx61aSWUJ1n5uo3C1KLCGawncX5ACzgdlX+fljk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7Yptj0l/vbaClo29pXsJ/WdqRR/uLT9oFIn3tV5b87uPiHYzi6yHGxGg+/uVJ/uD
	 H24EwpR0K71MpjDjq0P/o8I5WTyX8Rw7XZMuwulpEdk4o6KRmx7iD85WFfxvNX7mzC
	 l87QBiT9/xmypfP+SLb1jstuSRTBqkmJXLUyb7CvVkjuyaKT6Aqg2Ur42Byp9xu5IM
	 TTBJLO3SDfMXS55NkbAi2QIquyWFANcsB0QAywfyKWupQqDHSRsK6nUiZQrbQ7TA5v
	 rSoUSsF0DWi4KEiGWU2tZu6kP429nd8fh39K4dbVKCRaOsXEk49sNX2NdpmlFVRpOB
	 I17SfFIsfS8iw==
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
Subject: [PATCH v3 03/15] MAINTAINERS: Add maintainers for GRCAN CAN network driver
Date: Thu, 22 Jan 2026 13:10:26 +0100
Message-ID: <20260122121038.7910-4-arun.muthusamy@gaisler.com>
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

