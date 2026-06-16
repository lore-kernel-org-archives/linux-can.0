Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784EB42EEA2;
	Tue, 16 Jun 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605866; cv=none; b=B+3YF4FAp400qKBXDsj8BH3gW7MjQx5C9LUEomZevsfSJxKBqkrBOnz7k/wmgg51uNUqMVCQ413acGaDHTVmq1ElY4qm5ddhjhw9YpWxHDYYkcx7xKt6vGkRmiqYE54YBoYmUGzYCHEKKrgFbJVlU9/DpsVTw9XVSmr+lFLM/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605866; c=relaxed/simple;
	bh=cqOjxDGzVeBxs6zy8kgxNbggYoD47iaMB4/f2gHj0QY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c4NO9yFtkTXIPnHgeL013unZjJub4HBPc9efgKMUA0CPv41rmPWxgzuR+fr6Oxc7FlOY8bzyTGY11PEwwS+SxDcBuqk+I6k5nlUDHOZlAhLb/yO9B3JAQfvLZQ5o3o32SrU6Ihe24HccxGw/C1gX1k01hryNllyO9nwXm/h+6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dChSsKnw; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dChSsKnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uB
	iz5AeQPmYg1Yr33SDLUeePjjMYfAg/rzpbrEhs8HQ=; b=dChSsKnwx3VwTIpIvr
	v6nLYHg1ZwlNfmyuyj27IOAiGmO5h2Akq9qV/1gDnHInW5DhGjJo0botCKYYiEDe
	tM2VsVRuZ+PEG2dIq4D5+pU2LRxPvDxLN3P9mRQz7dTR3kJ7yDmRsxeyujGtMNu3
	Y9cu9EIVCxdNo597qQtQ47fJA=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnrK69JTFqGSqCDw--.29972S2;
	Tue, 16 Jun 2026 18:30:22 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: sashiko-bot@kernel.org,
	mkl@pengutronix.de,
	Mark Brown <broonie@kernel.org>
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	mailhol@kernel.org,
	o.rempel@pengutronix.de,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net,
	linux-spi@vger.kernel.org
Subject: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 18:30:16 +0800
Message-Id: <20260616103018.105612-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616092614.00ED51F00A3D@smtp.kernel.org>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrK69JTFqGSqCDw--.29972S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RuXdbDUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-h5fx2oxJb5aGgAA34

hanges in v4:
- Split into two separate patches:
  1. SPI core: add internal NULL guard for spi_get_device_match_data()
  2. mcp251xfd driver: cache and validate match data pointer in probe
- Remove duplicate spi_get_device_match_data() invocation and unsafe dereference

guoqi0226 (2):
  can: mcp251xfd: mcp251xfd: Cache and validate match data pointer in
    probe
  spi: Add NULL check for spi_get_device_id() in
    spi_get_device_match_data()

 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 8 +++++++-
 drivers/spi/spi.c                              | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.25.1

