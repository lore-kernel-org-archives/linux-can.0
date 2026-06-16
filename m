Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F7409608
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600091; cv=none; b=hGmFt3m4fzcC9VBny4HkOsTowbEsbi1up9ODZd8AQOpXwUv30ur9ENcmef66xZEBkM4wVxlsulaq1+GWic5AsWJcqGQVnP9Lk1ay66JX0YxEJtVjQ8/UoS+GoXQoIsSroqyz+t+UqZArnvJsgLZYhu6H766jLhjdBwlOliXARes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600091; c=relaxed/simple;
	bh=C9tICqSQnhcG0dcsD7D6jEAO4/apcu/YfiUFPbavmSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hcYnFoL6g3sQsu87krz5dCEf/WpCZdhg2lUZ5rwBvEdBXZnfruyANPjVl0RLbju0ifLgIwKlHpnV2DbUtmeniLNAjC91BKEfnxpwpMwt601yr7esHKJcdndji5LN0PIItMHalbt9vO+4k4NXr/zgHuFioVkPZsrbc75Nn77ufmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IOGnqxDr; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IOGnqxDr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uY
	5Q5jA4eHj9zzllHhFDtqrHcbMnu37U6FBHIvB8mOw=; b=IOGnqxDrY3QnCJWNUT
	cWAgYjbnPSGtsKzQBu3Ps8QW3JoH5/S7kU2Cv+qFcSIU+ADQpCO3V1CnO+EIv2Hm
	votVLxnn0iYvlh2EyuAHHk2G8Zxk/aK5PD7QOYFDUwoBucmiquh8m3QLLNWe0JRz
	T/Yscm/J/Tt0ZCI9DIdzJ7LQU=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnEpYsDzFqEuHvDg--.40923S2;
	Tue, 16 Jun 2026 16:54:06 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: mkl@pengutronix.de,
	sashiko-bot@kernel.org
Cc: cuiguoqi@kylinos.cn,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	mani@kernel.org,
	thomas.kopp@microchip.com,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	guoqi0226 <guoqi0226@163.com>
Subject: [PATCH v2 0/1] can: mcp251x: Add ACPI device ID table for MCP2515
Date: Tue, 16 Jun 2026 16:53:58 +0800
Message-Id: <20260616085359.89406-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616031332.0F34C1F000E9@smtp.kernel.org 20260616-teal-wrasse-of-conversion-348af0-mkl@pengutronix.de>
References: <20260616031332.0F34C1F000E9@smtp.kernel.org 20260616-teal-wrasse-of-conversion-348af0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnEpYsDzFqEuHvDg--.40923S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RCsjjDUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-g61HmoxDy6oXgAA3X

Changes in v2:
1. MCP2515 is verified, but MCP251XFD has not been tested.
   When testing MCP2515, MCP251XFD was found missing ACPI support, hence this addition.
   Reference the validated MCP2515 ACPI node as template:
   Device(CAN0){
         Name(_HID, "MCP2515")
         Name(_UID, 0)
         Name (_DSD, Package() {
2. The original 9-character HID "MCP251XFD" violates ACPI format rules; 
   redefine it to standard compliant ACPI ID MCHP15FD.

guoqi0226 (1):
  can: mcp251xfd: Add ACPI device ID table for MCP251XFD

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.25.1

