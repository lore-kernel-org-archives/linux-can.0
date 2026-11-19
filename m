Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126295;
	b=E2XeCzzOlMhR8K2bapZi7VfNRdy4gb8hMX+iE/RSBrJOBq+co2drYwaIwD9gJipQBMTt
	 fsqH5A9IkBP+1iXu1imwdeHzPGcJGYtNaHx9yqTRVzMkCkNXP3e89uwFQIRTeIWjLhCWB
	 zAG+fUTMO/tfjozg0yXl6ia8FvUmkkOL9Ajv3XF9fQuCwk31uunPeQ2APyMHQgZpSHqT8
	 QI0aw1HO+QYPUD+roCLUbHWVwg/jVOKCXBwmWP7bpLz3rNPLLxWTjrDlLORmYy5nzRHFH
	 XYNfzPnB2wfDUGoPxXkFgDTO/lrBmIwWbqA4GDqZs/buYBgv+/vS3SEwfDcfQzpIx4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ho5lg76jEfP/UfqeQSx/vugYbc/WmBL8RFwWpvEZ+Kw=;
	b=QTs6Bn2jFD41/biFGhpft+eMFGQglMkxC0H7RKxQm2X3QMZQlwF0P4hfclPWU4x4s+fq
	 fiOr7u56+BcXPK5snBFcWQsawSmWJFwDp5GhsWHh3F58oaZ1UUnqZS5uH5/b5GCi2LkMT
	 7yu+dENLMGMioy9cqry1eNMI601jwZTZ+BvDRiTKvVJJ7vFjT6tQGu8DzJLNwAcceDp9r
	 1XOGV2BT1xm30SrmOqtarlBdxQ3MmMJ19gWaocRYX3cq8jNLsrJu8iU7tEDZn8jQ7AQmV
	 uOzM4OJ4pppJ/BBuDZ5Rd4KlwDoQf/hp0zixPmBgftg08MNN0PBFyNNSmngY37+NI3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LSiVU8aE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F15606A32C;
	Thu, 19 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F15606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LSiVU8aE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 00E81205B31;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5lg76jEfP/UfqeQSx/vugYbc/WmBL8RFwWpvEZ+Kw=;
	b=LSiVU8aErttbXrhbko81vsvFDBzVBnqnipMbEjCHBDNbnboAEyfPp0pH6vX2Kf/sMdgg5f
	uEN37f0MHBlg2PTt0F/I/YARnKZl7eZk9mzkZqdNsVbBsVpLOofWSXh92mVjkLK/dNGgZ3
	ONz2hfVReKY2kM8dITg3HhY+5E0lmMyM97RzGl8vyQZr1vC/v5bnHhmtnGo+t6qoVfRp5f
	iAsiLoHomMr7BDzjJ0+mlStlDvGG7nrK3LHhIA+x8pqhCAZnESpGh6bk2CIoHRfxRm3EEN
	QE1G1da/InrUbRb1SxjUc9nLDpaSAXL5KaPn3n8mBJu+UVYzAlkOSeBzA9bnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho5lg76jEfP/UfqeQSx/vugYbc/WmBL8RFwWpvEZ+Kw=;
	b=OaFY2KMv7uVbw0PAG+Azasl3Quho4DqYW4TCC7C0IIxjocEU503ZlBuJISgGxhc7scVwnU
	egDmSHXZpogHueUdrS8av2Q9qw2J5bSQZFZ4dTS3Y0HxDSd2+JYiZSiusoakelW0PG1OKT
	w8+y/sWOefosOV0NugsS3fRcgdGxY1jhwRBVgEjfla2X/Rd45zt1s9ymlx2MWR6+Ob0XQU
	nQYVpsQESYS/7JQWDvZ+Ya7ixcEcAZ0auqNhFZEy/fMvdk8H2ts8m2otJWCQpCdONvQu07
	M27NTl7QR4CdM2UFAeV38IIRsb8rgkgnCx/MRGRcXUlkMkJHWEChw2wTfMSk/w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=Pu3Mx9oLnMRkZoEIfxB4+ri99deQaXLaiYzlBGsUUvLc+NIrq21Gv40IMAkWPkKtNJny8M
	bqry03u+anXjl1cw6QzoWazrrbHYFdqnX+a0rNZwH3rw1an65FNK+ybNXVbD99BWuK8C74
	KoJcwsO3SJ7xdaT/SMgZ1BYodq0Bn4lma5+dY0E8SOieyBZ08GV86gCwXI85HlC2P9WDos
	N+LOlvEF+24gm1AACuSWvvIxS/AoJdcv48YLCaLsEIhQVdTWqcEsE3JqoEO14Yabs0YoKr
	kOVSkXLVG86dY31Uy+evwmoy2OCNWJ0pFuCgkJPgQRkL8YgKlufe78SBDHN8ww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z62-18;
	Thu, 19 Nov 2026 23:11:27 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 985AF5F0994;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/13] MAINTAINERS: add entry for PEAK-System CAN drivers
Date: Thu, 19 Nov 2026 22:58:37 +0100
Message-ID: <20261119220936.155728-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The PEAK-System CAN drivers (peak_canfd, peak_pci, peak_pcmcia and
peak_usb) are only covered by the generic CAN NETWORK DRIVERS entry, so
get_maintainer.pl doesn't Cc their author on patches and bug reports
touching them.

Add a dedicated entry. I wrote these drivers and maintain them as part
of my work at PEAK-System, where I have the hardware and the firmware
documentation needed to review and test changes. Patches keep going
through the CAN tree, the entry only makes sure they reach me.

Also list the PEAK-System Linux support address as a reviewer, so that
reports keep reaching the company if my own address ever goes stale.

This patch has been created with LLM assistance.

Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
Link: https://patch.msgid.link/20261112-new_maintainers-v2-1-794b73ce8685@peak-system.fr
[mkl: convert Assisted-by tag to prose]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f1a6024ff20..b5cb13f88cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21942,6 +21942,18 @@ PDS DSC VIRTIO DATA PATH ACCELERATOR
 R:	Brett Creeley <brett.creeley@amd.com>
 F:	drivers/vdpa/pds/
 
+PEAK-SYSTEM CAN DRIVERS
+M:	Stéphane Grosjean <s.grosjean@peak-system.fr>
+R:	PEAK-System Linux support <socketcan@peak-system.fr>
+L:	linux-can@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-class-net-peak_usb
+F:	drivers/net/can/peak_canfd/
+F:	drivers/net/can/sja1000/peak_pci.c
+F:	drivers/net/can/sja1000/peak_pcmcia.c
+F:	drivers/net/can/usb/peak_usb/
+F:	include/linux/can/dev/peak_canfd.h
+
 PECI HARDWARE MONITORING DRIVERS
 M:	Iwona Winiarska <iwona.winiarska@intel.com>
 L:	linux-hwmon@vger.kernel.org

base-commit: 24630ff92eff08500ec4772728d4b1fa08c28f47
-- 
2.53.0

