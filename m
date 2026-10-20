Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503054;
	b=LmhY5Zuq4v5lNNaYiKEZhbZKE9Vyz4n3AptokN+o55ycgu6wrTGl2vuzjzdHaJXSDub/
	 R5mdYHOQn1z037+u1y8/X/M28W3f8blvnWWZct1EeFXXSEeWw4KoDQ5l6tfZXlsiWPRUD
	 tu/9QH7NVr6td+XNJUxHUHOqvr5u9gQed9nYvx0wvo4TKw3ty1eSaL8RP8H+eYdENEt/i
	 2YmHMFB25cvNR1DArb1GvKvwh75/wJJucqIwv7vqgAxZb+z8FPu6EG5uNMuozDhLVY5Pc
	 G5tKFXPW9k6XTk/bR4pDL+N/XU8WlF2K+Q7xmHH8HP+VZ7RL7MMMt9H/kRqI3LwDHCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503054;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=fnnNZ6JlsJT2Q6ZzChaVFMXkag7NK1w086f8vNBb1Yw+49HyI9YKc6oqcQKQDxxG3oxv
	 yA+kmnT7zzq90kVFlQOWAFUUmVl3VPhqN77PCUp3smDlL4gjOgknvQDl6P2oyea72Rnxq
	 jvY9oJLQ2VAj8ETJfHn0rWi73085XZmKqIkfvo6r2xprKRV3aFVK5GNHjEcSfVANT5UFX
	 1DsC2Z8ggxlN3k9WaEsFMhoZKtXFcOwdf/sQ8lFrqhb18jcerzP0yCAsMshTl+i5awH4o
	 6ai/TI9QIvuAuibzLxJ+nfrvk1zkHin8zGJqc15YTBXEapUb6cqObCpQPpM7Y4dbq6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IO/WelvA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031C606A320;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IO/WelvA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503053;
	b=hJt2vkNVRcNfrMkr5scUmqNdByAidQrVn78rzoIzSSrzHEXbjk2nyrpd8jo+KNpVhVij
	 B64r3kZVPsbNFCz6d0TvMqylTTkP37xc/FypcQxher//xazUXMPV61edy50ixeNAEWE/n
	 +katCS37cwb6+5ibwh4hl4Ya3llHkZfCZG+gkwY1W6Y5OW76MPwQrcOQHGnbs4Hq+d6K2
	 bBGynmJTGXx01LeiZwF95xK7fmwJp7yveK9YuHfefX/ETC6qCgNRQDC4T0K3eW44r/F8B
	 Fr4cEagrDaMIMWYN/ZkpQ0DZCEPYUtpb71ZeuTPTSZASV3//lbg4Ty3OymFIGfUrfIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503053;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=UMtFyqJq+/GxF+dfN0h5PaZIvrMqhvft4Y83p8Rh5zv/4ATf7IXf9sQ0Xbpn+dvZJp3y
	 2m6sK/q+MzlQAponwRdIMoE6cl0zfNILwRP81bWqKHKS6utjcRYi3w4K8sm39AOlBIyFz
	 nBYwrJfLUPPXuh2rbMVDP3++7Hx3fRQwv70kKtyq5+4KKGd3uLe3hdbBaS8n/9n777LsC
	 KEoTeOE3d8/L05VHiek7iRQ6FNHnc48YtXbCDiiuKS6v1pBaweDyMl7HwSsQCDTDBzIGK
	 1semlyslBSmJ4KKM7+hAtmpytklkEBLHVqf+zT04HNHoPwldozw+f+AsOZOiYreWrug==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2F4061F000C8;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503053;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=IO/WelvAJuY5kdYnJ9fRjHDphdnpiTp9o8TQ5BuZGt/Mq74qUkES7ooIbBDxu5Hqq
	 1oxEJFtAc5YmVZYUFV0x0KD7DyI2RBnEgVWODOq9WgachCJKRW7IL2tAJB2/qiJ056
	 HxFFhC5QyZwcdMBHiPPyVdkKGJ+LNtfyWTrjPmvt/m/RB/ORpSNsY9NVn1NycVCbbH
	 r4/ifaaX2zCbGSXdMKmOFzwMn+6SpE4jEo8HyPlajKdaa3l0hlv7iz5sY3prtQTxLm
	 wShdRaDNEaO7L9hqjd/HdaAPBn5fDaPi9gEV6s0ByNW5hZE8RI0c1ZZW1GsmiP6lvT
	 pSyOqC74sl+Ig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8FB8E4317C;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:41 +0200
Subject: [PATCH v5 02/10] can: peak_usb: add missing includes
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-canfd_check_channel_idx-v5-2-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=863;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=Iz99UViJQSrGP2aeivtBdGWkvK2nib2vAqmyDAve4Wg=;
 b=HQxVziUxyTHvPNHo3K29JqKu8vqAF+S4ycQkgBGobcSYmSkvUz8vHhg1cyfOiFYccfvN7GMdA
 KuM039MLnn/AYfHRKoUoZxda8ChdcXtbM10TFGOPEBkUmEjDfNNKSAh
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr

From: Marc Kleine-Budde <mkl@pengutronix.de>

To make the header self contained, so that LSP servers don't throw errors,
make the header file self contained and include all needed header files.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.h b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
index 65999f04f4b7..9ad7d31d2720 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.h
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.h
@@ -11,6 +11,12 @@
 #ifndef PCAN_USB_CORE_H
 #define PCAN_USB_CORE_H
 
+#include <linux/can/dev.h>
+#include <linux/can/netlink.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+#include <linux/usb.h>
+
 /* PEAK-System vendor id. */
 #define PCAN_USB_VENDOR_ID		0x0c72
 

-- 
2.53.0


