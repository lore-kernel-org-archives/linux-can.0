Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=rPmvcXS35QM+W1sY2MFxVXu+I4XrjeMQWi5IqPvMriubpMX6VS5WIMP+d7oP8MFJw2/M
	 7pODvY9P1kjJZnGlVcVc3pn2x7mJhXnjsFuxZBudXs6stTge1emsQ8ShIkiX2ahbjw9mv
	 fHIvQIC36ca1cvn6ao1xmCsoXk/N8RMLt0p4fV9H1E6u1sYlwIh0LZn55AarUMjba8kTy
	 R8znES/YJfprojj0wZOEnQMu0iDegi0cavPhgv2ivW6ttCdpyB8eOJOZ5N/xOBwSzwijJ
	 /p1vFMJewZGWu9ldY87ElQX0AFjDHI5XxF6IOoRQANR/Ss8+GDYU7RhggsfReVqgaag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EY1f8XaAsDLlS40lZeAZxoMvm02jGIEpDJYq8bcoyS0=;
	b=mHBxtDIAENQLTiJuD1OFCGChuq69Goq26yR+VIOwLxvBa9ZXSz3es1h2UBFyiUb3yOSM
	 8P08rOobVRvNfj5Onfr1Pjp1KVdfAfFdd6Z15c1v/ZXWK1C3I+E04ol0Ioon6sBhBl26R
	 IrPBfZgQt+BCKyLaRZQGjoP1a04XQu7kSX/Lw7PJpLbrSLLlCKB67bduDGVR/IN4m2TlB
	 57+b0JfZWl32b+jddc65ov/ulZVkGVAN91Q55NupyY2KG8twHvDrQQDQ3dRyNjo08CK1C
	 UyBY3SJ4eJ9oqYX+aOZq7bcs3tE7wZFb2aF/YHBix4VwZPdxcojlRN7TG2c4hKzdvLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="BwjxCT/C";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3960606A895;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3960606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BwjxCT/C
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5ABED205AA3;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EY1f8XaAsDLlS40lZeAZxoMvm02jGIEpDJYq8bcoyS0=;
	b=BwjxCT/C+McvMY/cQWygbhxUnvc3w2brLBmfDFhbzRiZ8Y/QsczoiDwFLBTuSln1ybqG0b
	e/pJc4DPzPnvQaNVoFHykxeW9LRZ1LNKQq5VV7+Af38mMtfsW2OQcVbBnuaZqHTDse2nlb
	MugQclV+mq7natl9zNX5n/yV7eYmhPa9W/GXMPBaqjEfgGMTASfyijarIhgFEZndTMAtKr
	GwoOdUeys3IkuNgm3Y3JeUmYs1N/8cWJmG2piK8igDRYMzOLv+zKBqSoC26M1N7O6QWub5
	2BipocFDm2mMzMb2kdJxfut06nMGa+wzztkoqakCjShv7ZjHNol5UVjHZRjHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EY1f8XaAsDLlS40lZeAZxoMvm02jGIEpDJYq8bcoyS0=;
	b=NJMwKlqQdxOTJ/1AJJxiGFyYfnDIltwyVOLOPI8T8ZitZ5areKPanvnTz2xFlCnZPNx3CH
	nt4fHms/yHNgOh51F1ZmK6AcKH0aKK6A/UFa7V1vSFEYoKXQ6RMwaABt5eiEkakObie83+
	i2Z/zNTG5xoDij+o/pjZFDYmj69rY/okpOBVWBTNLKxwk01CSxtrDrOWSX75/I8MrkRLpa
	cIpeNXHBvG8rJjX/i7nVEF8/oluX77FDKYX1qYuSN2uD8bXe/+DkN5e5N/6RzymzKQqQa6
	8vl4TOFm2oWJf5yDpFs/Uv12wSN5lRyKPEPmAH8qy56zBqyRecSwifLwm+IVog==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=DiiESIWJVmuw5BZlYd4vN8xDwsWNIxRLqfFrTuflnmusbarn3ndsc69gN/wyS9KMdnH2Ph
	y1vi4KJ/3/3IxP9GlUJv4p3ku/g5z+oBigadxUN9XWAlTyM33O2Ce6/kMXTTgicGWnVhk+
	fMhrrJ5NGepTz9NawfyDIRMyw5yOmzX0tnteVqJUQyMwdJUSOW0lPt8dKUjqnweUtJmfo1
	Uuoxc1FwdpmembAHdTr6uRmkMx+a6gG2xE/tyouxmQVVpIi2Ms4A9ZF3tAaDBnzmsZ9n7Y
	tuVMEWe0SQi1fOa7T4fs+qI8+B4Ajk6dC1jkXrx4g3Bzy2vD5a3AwDorgBdK5g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KI6-2G;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 881CC5EDC96;
	Wed, 18 Nov 2026 09:30:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/12] can: ifi_canfd: don't discard the IRQ lookup error in probe
Date: Wed, 18 Nov 2026 10:11:42 +0100
Message-ID: <20261118092955.1283165-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

ifi_canfd_plat_probe() maps every failure of platform_get_irq() to
-EINVAL:

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return -EINVAL;

The driver matches through an of_match_table ("ifi,canfd-1.0"), so
of_irq_get() returns -EPROBE_DEFER while the interrupt controller has not
been probed. The probe overwrites it and the driver core stops retrying,
leaving the device unbound even though the interrupt controller appears
later.

Return the lookup error unchanged, as the neighbouring CAN platform drivers
do, e.g. previous commit ("can: cc770: don't discard the IRQ lookup error
in probe").

A device tree without an interrupt now reports -ENXIO rather than
-EINVAL; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/165f3fccb8faf1db65e8f18dbee4694c95266e31.1792118040.git.chaosheng.qu.linux@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/ifi_canfd/ifi_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 9eecfe5a87bd..e0f5abd934fa 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -965,7 +965,7 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -EINVAL;
+		return irq;
 
 	id = readl(addr + IFI_CANFD_IP_ID);
 	if (id != IFI_CANFD_IP_ID_VALUE) {
-- 
2.53.0

