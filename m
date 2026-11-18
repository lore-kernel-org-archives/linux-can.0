Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794994337;
	b=EgYP53JqCqttchcwm+qh+Hl1MrRh2yKB4fidCo1w/E4U456UJOS3tmDhDfnO04ksT+Yd
	 CTj2al9Rek0MpdyQYRB/YIEzipMIksJtBXQbGY2nr1/IH9ReKB4tQm2k+rTJr7oEtLuBX
	 ilDAXoPktPLZHJRA7ovXSXNCGhtARdqMga6ISS4WJP1Z5vCuCKCB5tZjhfMurhoULzZy2
	 zH7703yJs9DJdhbZ5nPlLFr3xP0BiqSLE7W04mBgq/dzZNaSVEHN1RgGYPUFmrKUXPvMD
	 nwBlGeF5ZV7Wd1uarZ/yScfOVD+FMGxQc/P/4wrvbs9S+Sg4F6qUgTYE2TkfceXbWbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s6ZOZeOKeQI9zuroBr1JmtOxRhVNsBt4JfM/a1Aoho4=;
	b=cdMqw8MRw/700myH4OSRj9TPwUqhkkGXBA5iFHuqZanMm7L6O2bA5b6eN39iW2t59nND
	 oFt+lbkvccPeY1Brih8hU2s3wwn17SCH3ru1EwZ6HVcjVZ9rXDdTfVr+sgMQfz+7UQYIZ
	 28MM/Uw91ESHBttQxIn8ralr9MZoYWSXVWPXktrvXQUcU2ZnCg1WQ2zHBIXk+SrAbpAm4
	 /tcR++TPXvVF5PU1+9OLZZU7hcmxJ6BEMQQajBO9EB5AUZ7eBMBzmHpJQUiQWf/KLDfUq
	 uVSeGtxZRX1zQK/SqjmxJkJWswVFwTocL8A8EpRULmCjZnXaY9oYndJbepbfmrUnj7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GuO+40ql;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850F606A32A;
	Wed, 18 Nov 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2850F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GuO+40ql
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 268F9205A24;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6ZOZeOKeQI9zuroBr1JmtOxRhVNsBt4JfM/a1Aoho4=;
	b=GuO+40qlYJFej2n1xRn8H2v1GqwcEZN0017+pykhYhO1lLrDfh8IiS8vYAaETHvbFE6iHy
	yi4LdMdcvj462sMPrx3swIBgOjU1L6Dfu+jyPvFH8NnjeNhnjBd9pfZb4MS47sDw3V30OQ
	eZLYNdl7c+ASdzMjr+OTUgCQKktp8HQwpML14JDTZnEWpgn5pXNWp/RrR53KQEqk9YvtYx
	DGy5GugzUqZatQhg71zDpFA6/fzDAUs2cYV+hcwZyNmus7NXQYHKvUvAcjbjDmVXjT8uFF
	IVxMjtAr2bzZxVRi/rw78oEPjbxALYhpjgeKU5u3VtunBedJ8edI7VNYq751WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6ZOZeOKeQI9zuroBr1JmtOxRhVNsBt4JfM/a1Aoho4=;
	b=GFlh6Mrm4hN6RDzkG2dMTQs4elp2bYK6L8lG+L59ym/lyZxp5uFHmIj9P5FQXL90/QV/kC
	AXHCgxwqT7WrSwUlYfJ3lTOP9Dt93PDfn3SUz5pn4hnMOAzJi4K5bKwjuGrDOYuo7nXzIT
	NaCwMvhdlTmO2bbGpNjepUKF/XMTV/MCKcdzSQXcPNYAXObJVcTeqwKPH8EXezeeweaO81
	G2Im569JI14ecCrUwMQ2NVPKjRlsx0WQOntResZSdFuivmJz7FaHdDqgs8nU4J2niizHrd
	FrWnnW4yoyuJNkAnDsOdr6l5WcJG4As34qOwvPC7Jy5O/Rl3Yo5oAMwLD7V1/g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=D2N2YjdzsCRI0xhygKxB/xRxeMGsmK88bZXz+Cu9Qk1+v98GhSXFcAvmC4VYLHynX3w2hR
	92IGDk9EdNyGVKDhDFdaQLCo39Dnx4EVgh5DcDd70+kyNdPKSmlTS6qhachVvMDo57dKDf
	NrNahAJCwrFcCNi5XzI++z3wwYNiVuYf9OPKbAwL8QrOC8rDo8a5ifKbw8z2gJrj4d38rD
	kNOSbAt6+LhfZeI0Wty+5ciTou689+VpDQ3abdxasrgVx6SXr/tigxxRpcECVT1q2qoZRJ
	/0nOIAFPta8ceEg8PEdrWIQnpBm7nOTKuf4Qv1cyrBcMMh68BxzU9oHu3GFiTw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KHx-1b;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3FDB75EDC92;
	Wed, 18 Nov 2026 09:30:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/12] can: at91_can: don't discard the IRQ lookup error in probe
Date: Wed, 18 Nov 2026 10:11:40 +0100
Message-ID: <20261118092955.1283165-8-mkl@pengutronix.de>
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

at91_can_probe() looks up the memory resource and the interrupt together
and collapses both failures into -ENODEV:

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	irq = platform_get_irq(pdev, 0);
	if (!res || irq <= 0) {
		err = -ENODEV;
		goto exit_put;
	}

The driver matches through an of_match_table, so of_irq_get() returns
-EPROBE_DEFER while the interrupt controller has not been probed. The
probe overwrites it and the driver core stops retrying, leaving the
device unbound even though the interrupt controller appears later.

The irq <= 0 test also covers a 0 return, which platform_get_irq() never
produces; it warns and returns -EINVAL instead.

Split the two lookups: the memory resource keeps -ENODEV, the interrupt
returns the lookup error unchanged, as the neighbouring CAN platform
drivers do, e.g. previous commit ("can: cc770: don't discard the IRQ lookup
error in probe"). This also drops an IRQ lookup that cannot succeed when
the memory resource is missing.

A device tree without an interrupt now reports -ENXIO rather than
-ENODEV; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/303815792800553c34842147941cab083823c212.1792118040.git.chaosheng.qu.linux@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..3977de761636 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1069,12 +1069,17 @@ static int at91_can_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!res || irq <= 0) {
+	if (!res) {
 		err = -ENODEV;
 		goto exit_put;
 	}
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		err = irq;
+		goto exit_put;
+	}
+
 	if (!request_mem_region(res->start,
 				resource_size(res),
 				pdev->name)) {
-- 
2.53.0

