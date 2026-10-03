Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9E3B7B9D;
	Sat,  3 Oct 2026 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068032; cv=pass; b=VZiXGyJYYjhB275Kvm2sxiuoL0xdAKogoJE9sawTel5kE9kyWnSD5hMRAcdCONxGiLS2iKxxryXcDqU7NVBcteHK/7HirFGFTRfoGyjqnkGRP2bTHPl4qWQMUk+V8QopmftGraFBrbSS2RXLofsVX0V4yXb/gATcSWOhq2j5fG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068032; c=relaxed/simple;
	bh=NQrEltxD8A9iAXV1mlwW3043SmqQI2xOGwKVPJCtVhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvnnKkyRLA7cjUiOl78NQ00rMjQBMjlngbF+eqxC2TI6iYDPJ7UWjByK/8jhOmc/4ieXaFP8ybxJQOgVJZHFoV6Q3H2GMkkkH6Aae2GYBrbyy4Jw/PlxnZ/PfZQx7Mw7qIfOTooZko9jAQ5/XXjyP9KJOs4Bvn7HtkDYltqYDrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DR5+QeZ8; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DR5+QeZ8"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4115720233C;
	Sun, 04 Oct 2026 00:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W99D7MO9KbgQxcs5GVCHSMLcRHOWzV+QdfWwaJSY1Gg=;
	b=DR5+QeZ8JzMc7+i7lyD/+pScNuftQ+x8zob3wMCcFmxNipIhxWPS8/mTcCs8u8WdMnZMog
	9VIF+A8LYIADFjmJDhTlcdCcJYKUDtnzW2Xf7qtRkltgWfmt3+H7QT2abfeOe9xjbUwHZb
	xJpxwNaEfFBW6N+LzAJPyk6deqSNjdNgBdFCBPvs9B3rcyhSC2uu/oWq1u3GxJmNNNpn93
	cPcB4hZFuo5/FPu9ZnJvLPLFvE+Q/ZrzRz8USlf00ZLdWjPrInzlqhi3LGXdCASw2Idadd
	D4bFQSZlp196ZUhMRU8ux+VLnnPrumrv9yk3qjnThgSGM1xqaKfO6cC8dtEZxw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068024; a=rsa-sha256;
	cv=none;
	b=R8E/fnxRbrVUzpWAwDXUJt/AwDsN90bs8SV6sVAd2mM84t6txoqOEpwTBhI/4QWlbw9ytk
	6NGSb1CZQh1zB8rWpUalU9kHKa/Zf3u4UTPq4DFfVTRKCXLMOXp4GLyMHrWwUht9OdKsio
	KBZ+KKFJWUihkmdPTIp4Pe5xXu1JeSO5YlHwGS4jmE9s+Zdb5xYcqCzbOk3CEOlt2iqzqx
	k7d9bA+tZjy1u7erQZSNx8XB39++gmVbfoeSKn/MQtMe1q3abjQfHu2xtu5fh/IctrYvfI
	P5Vvg/zrU9zx3o6WXDxA7XqtoKr1splXoS9Ti4IPXWGcSjC0MALBEKhRUAShNQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W99D7MO9KbgQxcs5GVCHSMLcRHOWzV+QdfWwaJSY1Gg=;
	b=KsujAjVki4hOzPSdQc1XyfRhBqHmrfkCKn20eivRRaGt0Q1hpYM5AlWvzE1NzYl3jc5uap
	/RapvLdY4FbS0oVRChj3tclnbS1bwb7/t/c578e/ubopCJWZiM/YcuQYRZIzNa15Uf/Orj
	9J1p3Cva43cZU8sPsjOfuNdGOyVmgOJR4mov++fdjX6WVFJ1c6rO5D2vWOBmQvsSRIeyLe
	wr8I/M5x3G6XMM8Ktw+FNF3DvwiyzEh9e99shKBwwk9vfbWkMJUXz5K2DGSSJB4GSS2mtl
	EM5ZCWArsjB34twwPlZmG6prjCjnm+s4Sa11WdeumC3pkPTi7aLVuveu5xR/Nw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bw-0047mk-0F;
	Sun, 04 Oct 2026 00:53:44 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id AD66D5B93A7;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 04 Oct 2026 00:53:14 +0200
Subject: [PATCH can-next 05/10] can: gs_usb:
 gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation
 fails
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-5-7b4b06244a77@pengutronix.de>
References: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
In-Reply-To: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=NQrEltxD8A9iAXV1mlwW3043SmqQI2xOGwKVPJCtVhE=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62F5w6bhB53s9rcKAjqdMEasCapicb73s7jd/8+ya0
 Kuk/GObO0pZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjCRsyWMDNddGuSbq2rtjdId
 m/X5wvebWc9bYLjZOKrrcKZqyO1r+xgZlikYduwU/smY/mDKfNZ5jM9E7SJWHWO0e71MdGaUtoI
 0PwA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the allocation of an SKB fails in gs_usb_receive_bulk_callback(), the
function does not check whether an overflow flag on the host frame is set.

Instead of directly resubmitting the URB, first check if an overflow flag
is set.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 406c11efba79..01b4b6c980c9 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -658,7 +658,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(netdev, &cfd);
 			if (!skb)
-				goto resubmit_urb;
+				goto check_overflow;
 
 			cfd->can_id = le32_to_cpu(hf->can_id);
 			cfd->len = data_length;
@@ -671,7 +671,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		} else {
 			skb = alloc_can_skb(netdev, &cf);
 			if (!skb)
-				goto resubmit_urb;
+				goto check_overflow;
 
 			cf->can_id = le32_to_cpu(hf->can_id);
 			can_frame_set_cc_len(cf, hf->can_dlc, dev->can.ctrlmode);
@@ -712,6 +712,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 		netif_wake_queue(netdev);
 	}
 
+check_overflow:
 	if (hf->flags & GS_CAN_FLAG_OVERFLOW) {
 		stats->rx_over_errors++;
 		stats->rx_errors++;

-- 
2.53.0

