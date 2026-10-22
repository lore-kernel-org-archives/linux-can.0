Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679276;
	b=y8OZYmeOXhr8FSZcbg3fk5OaEGMFYdkwpfxkj9j/6nLLUDH+2JhgWOpCw5vMY10xhsjb
	 +Wo+PZwo9Hb1B8EpY5m5Dre/GkWWK75egd6AyEEL10oHMBEiAEmVLejBRYl/fQKKV4w11
	 tBcXvbv5vNt5VaJqmucjINdjhW1gZxX32wJGd5oQKt6+Xv3f+5tTW76bicXQSyjZw3oGI
	 4t8aQ1K6t0FxdhUizfGAQkCkPAdZsQWJkiUBiCSiQ7QTxUnx2wmZycIYJL63WVnUhvPGc
	 1jtUEHb04uSql2HxpOege6W0x0PKwjETbcX03LZhH3GfiO/PMSe7AM5LQD++dt25nRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679276;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=w6D/ZfYPBul5gqos9ZjL3WgBhItYAnxKcOLGizzKkoqyJ8Lq4cu1vDRRmxhZTgAU6dME
	 NzEH3IpmbFBBMvfA7Qe8+DW4OFzEHqbbuGpKEFemKBgJjmxB2vr10QbhjQtvQW+HLUc0N
	 +iaHLl41Cb8MEhuB1yBZsyy/ETlEZDadFlZF19syO/dFU2dC+6+2hOvI+gO+y6v9yF060
	 lrQvBIQOx23j5dmkkui7uIqr6BngXfjW7CJFGZtMXh51Q4O8qK0BL9k29woyEIu+CV0o2
	 CsSif5DUyjaa76O9/o3O3ZVsaxx/Tfgzif5zrxPxn976U9VbYQrjMkz8YcQ1LKzF9kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Muk4Hxzl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A9606A31F;
	Thu, 22 Oct 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Muk4Hxzl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679276;
	b=EztlhmDARGLXyNBbiknP0bI/L+dvjmlo6svUAO65aytyxwXxVkdevcXFru58Z0Uc8p98
	 WYOqJxyRzlD9ZF122mErNx4A7suptdoICUnv188N+yhbPzl9nnFeAbZ/JdcFkg6FTSvmS
	 +twHYYRf+4tG2Y7DB5+3VPrK69YuysWPQbVxQ1FtlPagsgC5+2561Bsjw3dbRIK7YaYbZ
	 3uzr6EEnBZEJGXas7IWzLor8wjBrQnxCncVU+R2WZcXBqTN4IyVCHrjRM9HgVdvpF4twa
	 gm5r4eEemc1N4TnfoqOFLWK2sbBpYUIub42S9UAtYVnAoxmRhcsi/JgWi/axcuRAgSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679276;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=bD0yh8L+8ziVrp8zYvLQsaBMDbLc8kv+0aQrttQENFAFprOhmi9hKE3EIOBMl/1t6vZa
	 N5pe0luFCYGflCAGb3zZiDpXJiblbfKP5nSPGD20miYUipeAbne4/YEgbBVNtII+Z7+Ji
	 OwS2OxNJngAY67rjcgCsMDpheKhBd5NY8Ukt2NKEfGVYDXgpio2GlKZ2imZNN5nPXG0aG
	 FxqhUFjaE0Ga1UTjyoO+Wz9rg1sAS3z5UT5/yF1qPdbp1sQ8aVYnlvaoYOdd/QrhkF4HY
	 pvWdPzNw5L/DjxmbhG20AtVxzL2wrdab+zQUTO6GvHh9BlBfX8zATKnsPtUtUZPNnRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 26E521F000C8;
	Thu, 22 Oct 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679276;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Muk4HxzlaSUWdwupHD+Pe4F+zIwV+EKjVIbv8SUALo4o/aKTyjUjMu03sGtsQBrzv
	 UsCx1NtrIpA/xYJ2kxX+5k4FWpXjFlm1lKsTdyrPgwqtePvyrhQeokLFgQKDMC76fl
	 8oVvI7Dohoy73aoVlxtlMesoNpv7ei0Imnd16UyvL+jCINPSsY6008ZVOn5y3zJBxc
	 Ln1G0YMDtMfwrNFk8gGvrxKppgzX4ffrec1YV1l6u5v4H2BYqNoPkQttosukFrsTN7
	 mbrQMvE7lldOCK0f5CDpMMfuz75pMA1PRxSyVRCkloYSTiRzN4OH6grwLOBjWbl8ga
	 yLqbUNgi8rwJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 904AE435B5;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:47 +0200
Subject: [PATCH v6 02/13] can: peak_usb: add missing includes
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
Message-Id: <20261022-canfd_check_channel_idx-v6-2-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=863;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=Iz99UViJQSrGP2aeivtBdGWkvK2nib2vAqmyDAve4Wg=;
 b=tcWW3bMSKXYxJPx+I6sdxnEGa38B+X7+45nOG3t9qodJh6SaQV9g9ISGgmuhcDcwLFKonOLuH
 F3bZNohymL+Bl57vOOQffkvYm5Lzvt32bbrdbGMMM860EYyijElJi3+
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


