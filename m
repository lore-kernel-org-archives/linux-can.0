Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994337;
	b=KWAenxtJIvXRTv1V0ZMM08dG+vOwmhfHzNU6RFhiH7EKj8gSUNDDLPh7ZWxuniYFrnh7
	 4emdH9NbFWYv2C39eDUnUZZdUX4owb4oKml3G1aC5dnijOcRQmMoV4zFReXJlvEJcEGvj
	 cqZ1J7GEhhvB/4aTi90xlbDW7HDgel1om9v4+O3grmD8TNQqk4V5LtgmLfVy8m8D8MB+7
	 lVCXBxLterLVd9UA8qKwhFFG3LLdcqlGszsptE7rLZalmuBRH64uJNl3mGpjVyYyesCtw
	 18HiHsPNetcUU2axScuHbAjgfmjLYl7EU4PEd/KPI9MbSGwCH/eXohMHMmGeBwVNiqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994337;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=pfP+c1mSxiA5U3MRmanJj+B7z5cw/Er78RDU08p317U=;
	b=vq8sLD91SQmQcZV1IbTgQUobvx/VWl/2XOAVuMZtf+ZQRdqe1qEw9XAod14HNVmC6Bq6
	 lEyU3DjnyZOuOipsMKMBwaiCihnTWs9mBiYYd8kH8lzxmGKO2MbSADU+XHR67dlMr7e3X
	 Tzi1zqojmkXjfn4w/Oy4fqRfpcBRSB4irXfoaHgULlST9G5W1MyU4r+ktSGx6WVu6v7pZ
	 VbgHnLrO4eQK+VXPOHcqNV+Z0QKLcD6NyCIx6m1deek/eerW5gBoaN1D+LWfGh5buh9AL
	 yb58WYeQC1JO9qI54Pw7fMfeTWGZ3IrLXqXDsAyFZS+K/+zzg4yqbk9tUs9IFdeqgpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O4L6CFS3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28393606A31C;
	Wed, 18 Nov 2026 09:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28393606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=O4L6CFS3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3D7D5205A71;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfP+c1mSxiA5U3MRmanJj+B7z5cw/Er78RDU08p317U=;
	b=O4L6CFS3hHZIoAww0lIcgpkhV4pDy6cjI9uRaaI1X6mvERszz58vtMRfs4SejGu8AbD4kW
	b68Y1wT1fZbU2xfw/zPCi2HEjpslRlPI8vJTV7bp5ogMSsD65Qo93A67LZCWk1k/Ry2aSY
	2seoJDTni3Z6qsRdntjwcgZK89+a3wkGIdapJO89LMxBK1yCYv6OfQ9twU4kUYUza/uI7t
	mDkElXOvtQqO6l7ZCQnJfUcZXRJixqZl5BJpX77B3Gz84/UU+MyyimH3wHHPTu4Xyz92gu
	7M1Rx/XSb73OYNH7qHUhgquJEjf4aamB6FvQg+I9PmwhUi6QH5SlNpBNboKemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfP+c1mSxiA5U3MRmanJj+B7z5cw/Er78RDU08p317U=;
	b=GfIT1v7PpVfuTeTpA0TSAg43hBSgmlSVy9+mL65GuVRYEH+NBxLiDpPzWLjAradTA+cDpV
	4O1XGuL+XAIs3QF17jhWd0FYDduzy0foI74X668V6AMqxHPDjfFp2Cyhv/vkyFrTRgFWjp
	qRryaurarXajsAVbhba+LFRWT93sB7WIOjGeVp1bPJ3UoWZL/VjJncLPf4UYuKjaNmnL+e
	JCECMwWjifW3u05J/w3DouNJ0dpAfHvi6D9TWcv6jD2JW737gM7g1GoAi6SeExNw0/D1kx
	S9lSCqLwikkp2JXXNzJurp/pxYFNRQUl5qYugI8WKutrtpTsm9RY4ieetewmRQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=e5484lWjUK64vMBCIdlSzGzwUl+EXe3plNkitO/DqI5hxhOxCITcryczIT+qgYwHzW4tyF
	6s3mTOPf0SGRv3rFG2jxd+r3U8gGkZWyEFXoPc0IQguD5+brtmz7bhI6SenSNqgKCgg87r
	vOYzhmMIa1m6356yd82ElacWhNFymaWTxsAJcF2QSxJ8IQp5qssnzF33z2R7dlBLSBsQRH
	Ix/B70h8eG4gwDYNr+6YDLZsQcE04xx3tAb78SXOrSaKWWKeyduXPzvQ3jY/eABqMplWkb
	KYpWwjF6nFZpVJSYqTnKNVcebA1cJOyep/IzygVqSCnUIeJfeHKBeg+zPRH08A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KHz-1v;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 613AA5EDC85;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/12] MAINTAINERS: add entry for PEAK-System CAN drivers
Date: Wed, 18 Nov 2026 10:11:34 +0100
Message-ID: <20261118092955.1283165-2-mkl@pengutronix.de>
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
index 7d8b59ae6ea6..3e2be24e2da3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21932,6 +21932,18 @@ PDS DSC VIRTIO DATA PATH ACCELERATOR
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

base-commit: d6816d9a93b66a12bf01e10037e377f3333ad6cc
-- 
2.53.0

