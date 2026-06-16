Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33742EEC7;
	Tue, 16 Jun 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607180; cv=none; b=LvwJ2fL/ngcx3y6FkSQlhV+CGFFwe7Uwzp4S4FV4DaZLO/8JaaEL4boT5+lBN0NWnjom6ZcBZjZHmNgcx00zvnR8DnfM9zdv750a4N9ecDAg67uLZOYeCiBjxAaO1QpRsZPWkQR+tx3/MZXetnSEVihAsFOZHJXiJxjOtQjKEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607180; c=relaxed/simple;
	bh=Z5LSD7vYP5onXf7YoiAJPpPZXCSado6hBcvPjxlIXfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfOcMk1Mz9FUbdLrFhDWmLZ2cpjBN8hReAcvKglB1sjWwqYIJSfv2kUJVmxI+jJTuQS9kMZ0B0bRaex1ftKN8MHU1f2DXLfqNbZAPl3MTN/+5E45Y+RQ2PKvcp7FI+6L4fN4C7DBpT8a+ndQoYbTq8mBdnbyglrPtsEtY/gDtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J3q2xuKn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J3q2xuKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/f
	NuUMlCAps98ctZ2uZPHbDjC+ymBw4KmZ3nK8pyl7Q=; b=J3q2xuKn+KIuwbBOtZ
	1WCkcUJi71gDGqBpunhWZHYBI81E1+zmEfnX/yW2Svovapnb+zJN7W6ygaExLF59
	Jf+d7wWRSSRu8tVcdPHd8HXsQFs3+ns+vVhFi/zuHOylbAzkQt/bqrCGM7I/gcXM
	uM8BNtl3u+I73wjo6XQAAjKDE=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wA3YpXsKjFqzSQCDw--.28086S2;
	Tue, 16 Jun 2026 18:52:28 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: broonie@kernel.org
Cc: guoqi0226@163.com,
	linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mailhol@kernel.org,
	mkl@pengutronix.de,
	o.rempel@pengutronix.de,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	socketcan@hartkopp.net
Subject: Re: [PATCH v4 0/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 18:52:27 +0800
Message-Id: <20260616105227.109352-1-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
References: <997991e6-0e09-47eb-a6ac-5f455ddc250a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3YpXsKjFqzSQCDw--.28086S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRIPfqDUUUU
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-g2sFWoxKu2jZwAA3S

While fixing the mcp251xfd driver, I found a latent flaw in spi_get_device_match_data(), 
so I sent both fixes as one patch series for unified review.
There is no hard build or runtime dependency between the two patches. 
They can be merged separately into the SPI and CAN subsystem trees respectively.

Thanks,
guoqi

