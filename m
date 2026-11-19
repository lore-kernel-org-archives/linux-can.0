Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126297;
	b=tlfZhPxnOaMIAFwLDt71jMzvCGFQdt2qtNHBFOWV2yCV7KQH0sMEd/Y4hpScV8hbgeIt
	 BnhU66LVV9cdTcRWvdXiYTemDZwxA6AXL7i/rdv+j6YMnatfOnV/W+TzkdSiQaVK60xA1
	 FPsTO+wBCiEo/bq8lintH3SHUl6UFNOpX56VJBN7pUKdy8IyZ/W6UJIkLoqbymhZlhnod
	 KTa5u3pX53uQjd4d9xHHZjvZbnYWJvtMSPgmZrNtaUEcphJt4iOYwLUH/FH3eBtIWroN3
	 pkw9aj9Aywbr5OBA9AK5wiz1zEXnL//BOwDjK6TS6XNmLyzDWyJnowRpGq5vTVTEhbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k0UDyoYgZbZInCM2UaoRCVkpmo5Qkf4N54aVJb+pY9A=;
	b=FxnhBOzXibMqqrvXdsOUuSQfwx8+FEhEq6Qg5uede5Uf6NJfpuYsi1+DokBURi7amOrz
	 FLbLSoqUZR6ec4AML4h91Ze3zkz6cncTuZyulhl+jGG0bOXUmEbID0YSgxoXilcXvTD4D
	 OZ/rrFVnpn8N0ZbXypRbYKFtWKIy/NLdTwmDkSfFgUZJ6mN2/reOzKuL5YrTLKmpYBOMn
	 RDmDVOIgm7eW0Oq0FbKfRS+uVdijhXPSRliX1yI9rnXwjKZUvk27bLNSjBITtt1yA4eqZ
	 yz/JXpNTn5y0hxOE4+0c6+Wat3e24y8hf4xnLUzWKTxQ6DLAGQfK3cxHoTbu3ftCLtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LNVVqBoo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C6606A335;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C2C6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=LNVVqBoo
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 61189205B44;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0UDyoYgZbZInCM2UaoRCVkpmo5Qkf4N54aVJb+pY9A=;
	b=LNVVqBooGP0jJl3iOXo7sbWKuYkO3fLHVYsA8wzCnYds3GWkFfI/SILyEKLJsYPa2MO+1b
	OjfK/HJWf93gL5y94NmkBYuysQ0iUuMlmAc5cAWV+fSEZtQsp2eKvyzgoIGCL4ABSANV0D
	pKNR4QQbKpAIb2AUOyjr/7Y6UADAi+v46U7tmwa41W44HT2OinSmhjIrHs1euHko8Mgzqp
	n3r3r7KbjiTJl58vWCnxj3qfxqu87OzLTQMcjgwgfHrVBovdE3ChB9QsTgnqbhAVoAi+DY
	66iXDbto/5zob3UcEoXhlX3689mPmp18xGicZ5fjTUnxX+1G79hmtWHxdZ/mwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0UDyoYgZbZInCM2UaoRCVkpmo5Qkf4N54aVJb+pY9A=;
	b=IkKHFFXKvEjkhU8qJ/vWGbZROzDvBL/ww5lWl87itmL08gTnu5TMQGxe9hyGgifLlHI0cR
	sSJuWOfBbf+UQtZyuZr41jJQTarlvgi+g1jBGyqN1N90BdNQo2HQ0jpDL+e7nPG43MD9dd
	/SC3j0kXS1GfafBO0zyAtEcnbNk3RY5TYm+Oo2Oek0SlLuxx4oWVSULiI22Qnk1+PhJnL6
	Uk37R+mCOWF3yxjYNlEzQ6PVLmbxvBXRK/xCVElQSR3S885qQTakAszazwtOtVATAoZX4g
	sft+lqAEGhoW9QKAT4njPX19woJKIHvZmMM70+tymTm6ZSTbqE1nqfWwz78opA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=duLk0OuuFRrRscNShOzBwbus94VzM2yakcV3yf8NKQ9U4Ip8Fj6jwusZbdjAynPBVxiPZ4
	jBTXbs9rF1GzgEZ5R1lXXN8u5DVzLaBxLFiqsRn95FlGUHr4kMFOhrJeYI9w/N4SJrzY8K
	+zGAKG55+zgyvOKQ/op8vyBLj3fCSqxSFdSoOIkPTnkyIexnrH5N/grnX45g49TsPxFEdM
	B2qeeu9xGxEG3yzR7QLYd3dZPX9/MWfFLsyBjTxGJ+C+1TYJB55QOCHpU/hBh8VAXQNeVC
	it2DbeIe06ux0HSAAqj2ZMHL211SbJgSgbzhS2GXSLBjh6DOsuwrh5/n5bM4rw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6I-2P;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 090E15F099D;
	Thu, 19 Nov 2026 22:11:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 10/13] can: ifi_canfd: don't discard the IRQ lookup error in probe
Date: Thu, 19 Nov 2026 22:58:46 +0100
Message-ID: <20261119220936.155728-11-mkl@pengutronix.de>
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
Content-Transfer-Encoding: 8bit

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

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
do, e.g. commit ("can: cc770: don't discard the IRQ lookup error in
probe").

A device tree without an interrupt now reports -ENXIO rather than
-EINVAL; the driver core treats both as a failed probe.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/165f3fccb8faf1db65e8f18dbee4694c95266e31.1792118040.git.chaosheng.qu.linux@gmail.com
[mkl: update patch description]
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

