Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2D541A565;
	Wed, 29 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320976; cv=none; b=JPzJylOi0yjXoeypPpDeX/lrv8zKg+uhZ+Kt9C21leZGSKuQovLeON0uHsuC0ES0es01JE4pTz4FKIGxwQ87vtHrgiXauN/yW+yox56hqflRx3OmWBDHZ+AOX92Pmy0tsAgciywRUauM3t4k2wcUltM7dN5IZ9fsr2wNfJeKdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320976; c=relaxed/simple;
	bh=tq4xQFCZr6jFSoSuIBjFsaq7uLT+yLRZOTTspGvwA1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElZaS+DHgymT4+8hOI9GrYvoqjrqtBfyOxE6RxnYouPLcdkqXEyWp+WNrOBhqIggj5KK01Kqq24RXcmo6opY5Lg2IE5+NGQpZYTj8H370dA112ZNxJcJ7zc6r9B4P1cGXE0PlopnRzHR4FZZI2blPRq7wKRZC7Irk+w+wLEOfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6F719202B61;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rnC-0G;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BBA73575DD9;
	Wed, 29 Jul 2026 10:28:11 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 16/20] can: softing: fw_parse(): validate firmware record spans
Date: Wed, 29 Jul 2026 12:12:56 +0200
Message-ID: <20260729102802.505168-17-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

fw_parse() reads a fixed record header, a firmware-provided payload,
and a trailing checksum without knowing the end of the firmware blob. A
truncated record can therefore make those reads exceed the blob.

The same record also supplies addresses and lengths for writes into
DPRAM. The generic loader uses wrap-prone mixed signed arithmetic for its
bounds check, while the application loader does not bound the staging
copy at all.

Pass the firmware end to the parser and validate the full source record.
Use a signed wide offset for generic DPRAM records and validate the
application staging span against the mapped DPRAM before copying.

Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Link: https://patch.msgid.link/20260722044347.2708-1-pengpeng@iscas.ac.cn
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/softing/softing_fw.c | 46 +++++++++++++++++++---------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softing/softing_fw.c
index 721df91cdbfb..282570daf3ef 100644
--- a/drivers/net/can/softing/softing_fw.c
+++ b/drivers/net/can/softing/softing_fw.c
@@ -91,12 +91,12 @@ int softing_bootloader_command(struct softing *card, int16_t cmd,
 	return ret;
 }
 
-static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
-		uint16_t *plen, const uint8_t **pdat)
+static int fw_parse(const u8 **pmem, const u8 *limit, u16 *ptype,
+		    u32 *paddr, u16 *plen, const u8 **pdat)
 {
 	uint16_t checksum[2];
-	const uint8_t *mem;
-	const uint8_t *end;
+	const u8 *mem;
+	const u8 *record_end;
 
 	/*
 	 * firmware records are a binary, unaligned stream composed of:
@@ -114,14 +114,21 @@ static int fw_parse(const uint8_t **pmem, uint16_t *ptype, uint32_t *paddr,
 	 * endianness & alignment.
 	 */
 	mem = *pmem;
+	/* A record needs an 8-byte prefix and a 2-byte checksum. */
+	if (mem > limit || limit - mem < 10)
+		return -EINVAL;
+
 	*ptype = le16_to_cpup((void *)&mem[0]);
 	*paddr = le32_to_cpup((void *)&mem[2]);
 	*plen = le16_to_cpup((void *)&mem[6]);
+	if (*plen > limit - mem - 10)
+		return -EINVAL;
+
 	*pdat = &mem[8];
 	/* verify checksum */
-	end = &mem[8 + *plen];
-	checksum[0] = le16_to_cpup((void *)end);
-	for (checksum[1] = 0; mem < end; ++mem)
+	record_end = &mem[8 + *plen];
+	checksum[0] = le16_to_cpup((void *)record_end);
+	for (checksum[1] = 0; mem < record_end; ++mem)
 		checksum[1] += *mem;
 	if (checksum[0] != checksum[1])
 		return -EINVAL;
@@ -139,6 +146,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	uint16_t type, len;
 	uint32_t addr;
 	uint8_t *buf = NULL, *new_buf;
+	s64 dpram_offset;
 	int buflen = 0;
 	int8_t type_end = 0;
 
@@ -153,7 +161,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	mem = fw->data;
 	end = &mem[fw->size];
 	/* look for header record */
-	ret = fw_parse(&mem, &type, &addr, &len, &dat);
+	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 	if (ret < 0)
 		goto failed;
 	if (type != 0xffff)
@@ -164,7 +172,7 @@ int softing_load_fw(const char *file, struct softing *card,
 	}
 	/* ok, we had a header */
 	while (mem < end) {
-		ret = fw_parse(&mem, &type, &addr, &len, &dat);
+		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 		if (ret < 0)
 			goto failed;
 		if (type == 3) {
@@ -179,9 +187,13 @@ int softing_load_fw(const char *file, struct softing *card,
 			goto failed;
 		}
 
-		if ((addr + len + offset) > size)
+		dpram_offset = (s64)addr + offset;
+		if (dpram_offset < 0 || dpram_offset > size ||
+		    len > size - dpram_offset) {
+			ret = -EINVAL;
 			goto failed;
-		memcpy_toio(&dpram[addr + offset], dat, len);
+		}
+		memcpy_toio(&dpram[dpram_offset], dat, len);
 		/* be sure to flush caches from IO space */
 		mb();
 		if (len > buflen) {
@@ -195,7 +207,7 @@ int softing_load_fw(const char *file, struct softing *card,
 			buf = new_buf;
 		}
 		/* verify record data */
-		memcpy_fromio(buf, &dpram[addr + offset], len);
+		memcpy_fromio(buf, &dpram[dpram_offset], len);
 		if (memcmp(buf, dat, len)) {
 			/* is not ok */
 			dev_alert(&card->pdev->dev, "DPRAM readback failed\n");
@@ -237,7 +249,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
 	mem = fw->data;
 	end = &mem[fw->size];
 	/* look for header record */
-	ret = fw_parse(&mem, &type, &addr, &len, &dat);
+	ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 	if (ret)
 		goto failed;
 	ret = -EINVAL;
@@ -253,7 +265,7 @@ int softing_load_app_fw(const char *file, struct softing *card)
 	}
 	/* ok, we had a header */
 	while (mem < end) {
-		ret = fw_parse(&mem, &type, &addr, &len, &dat);
+		ret = fw_parse(&mem, end, &type, &addr, &len, &dat);
 		if (ret)
 			goto failed;
 
@@ -279,6 +291,12 @@ int softing_load_app_fw(const char *file, struct softing *card)
 		/* work in 16bit (target) */
 		sum &= 0xffff;
 
+		if (card->pdat->app.offs > card->dpram_size ||
+		    len > card->dpram_size - card->pdat->app.offs) {
+			ret = -EINVAL;
+			goto failed;
+		}
+
 		memcpy_toio(&card->dpram[card->pdat->app.offs], dat, len);
 		iowrite32(card->pdat->app.offs + card->pdat->app.addr,
 				&card->dpram[DPRAM_COMMAND + 2]);
-- 
2.53.0

