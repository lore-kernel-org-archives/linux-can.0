Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF14183BF;
	Tue, 16 Jun 2026 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605875; cv=none; b=M2ZSYA1jTC/MVQSymu3nT5HZnVlybvZpZfNIMtA4yV5pwbjiDD3Kh3X4HjMT6I4eQGwiR2Gc0WbL1b/7Ezc5fsW6LNuXagd3v7/EBiPzUHA8KZi3n8KorSNv+jO+Oha9ZYFnwuf+0fJ3605ltMReogZS/4JaK7ijg7GDo92tOJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605875; c=relaxed/simple;
	bh=Na/0hInjZlFy+f86HfBHZHKRIRVzmWQctb3rA9JSGr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KyiulCbeWpdVspaQxf8mcPeQVuEagh5nTJ3vSV0Oakbyn5CdNz3QSWERK2S4W/mwklEA9yn2Vj8+o5QvVwlF0wgWpd/5+buzDbkbrRM5osnQetrhNdpBN0b6H8mZeg64uwcLiZQjiMYU3wyAKkoLNseIJLAOIL2BnSDx7VtbmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KrLLQWKb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KrLLQWKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4A
	lWpfHRD20svlbvEuxneUYoPiBFZmx61S/n6SJjTfA=; b=KrLLQWKbSC4EUqbFNj
	Une4N1qJJ7UlCGpaaQoNLkaR7OtAatgExQqm2EGXyRuGtlJc4z3cUGqTdjQW7sBq
	hH43OEKnW+4GiAap1XL10P0ca3PeDNfA0n7Y/TB1peovChqbWGlITU67XYee0ILF
	8/cliWWjnC+vZGOdcOOA5oK6g=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnrK69JTFqGSqCDw--.29972S4;
	Tue, 16 Jun 2026 18:30:29 +0800 (CST)
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
Subject: [PATCH v4 2/2] spi: Add NULL check for spi_get_device_id() in spi_get_device_match_data()
Date: Tue, 16 Jun 2026 18:30:18 +0800
Message-Id: <20260616103018.105612-3-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616103018.105612-1-guoqi0226@163.com>
References: <20260616092614.00ED51F00A3D@smtp.kernel.org>
 <20260616103018.105612-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrK69JTFqGSqCDw--.29972S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Gry5GFWruF4ftrW7XFb_yoWftFb_ur
	15ZryxWr1fKr97JF1Fqr1avryfKF4YyrZYvr4vqF9aqws8ur47AFWvvrn8AayDuFy0yr1D
	WFn3Xay3Ar43ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj8pntUUUUU==
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC-gVhyWoxJcVajgAA38

Prevent NULL pointer dereference when spi_get_device_id() returns NULL,
which can happen when using driver_override without matching SPI ID entry.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/spi/spi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 104279858f56..079ac01a2229 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -355,12 +355,16 @@ EXPORT_SYMBOL_GPL(spi_get_device_id);
 const void *spi_get_device_match_data(const struct spi_device *sdev)
 {
 	const void *match;
+	const struct spi_device_id *id;
 
 	match = device_get_match_data(&sdev->dev);
 	if (match)
 		return match;
 
-	return (const void *)spi_get_device_id(sdev)->driver_data;
+	id = spi_get_device_id(sdev);
+	if (!id)
+		return NULL;
+	return (const void *)id->driver_data;
 }
 EXPORT_SYMBOL_GPL(spi_get_device_match_data);
 
-- 
2.25.1

