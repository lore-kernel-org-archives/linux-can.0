Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487362;
	b=TF8Ff84kzVqRY8zdN0S/SfObdm6bO0PTnn9i1qbBuwrB9CryQNqy2tUAhzFuLWpmfU2S
	 G8C0OCr//kpB+XFW51VqgqXX6hkmbh04X29HkyMGkvkjsPtDQB8y9o4ra/PsKN5WkHx3f
	 OPj5aAWORQEu7ZGnDspIFQ9zlX3/WtNANhZXgZVkKaC2RsS6Gszxk69ZajxlUtyHvS7EI
	 Yo+/zep7/Ur1RI5pltzYQ7rlLxg66w12PGmnGyX+Yb8haRMUIQbpQD2ItziMSxAEFMrU2
	 eYDSm53QptyXwyM+/Y+96iMZEU1yOR2D80RQS8pUMsJV9BlFVGGSHlS4xepglR98p6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487362;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=xxM99yW47Uxt5b5AkR4Gz9umeT5+ztp6b5o1/GTWHHXUKKoImySbIg1/aOQt6yj3MeX6
	 bPBNlrrTl9lvNQ6TQO9Wm9J2Fx6ZrqIN2MCys4PXhhoGFZKh5vzaDImRel6GeBG89OUXr
	 Laogak2qZhJi9/FPbozUl/NwY2XUtb8d4iwfS8onY/QlA7dn67f/BdG6qZdl53JVhEB7k
	 3oTCDLpbmEMYFTudhvKRz0jXaPu1rCkTI1qcUz8tohuGd1GAuaYz4O56Yp3mrnmCw9LFo
	 yHD/jwTrZRybZ3lUFncQU0hXkdMgeSDAG8JS+gd3xyBqt8Kbksp4tUzF4OI0NC+k+ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=VtegRTzK;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BA606A331;
	Tue, 20 Oct 2026 09:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A76BA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=VtegRTzK
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id ED8B678034E;
	Tue, 20 Oct 2026 11:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487359;
	bh=dfRoL8uIWFI0+fuGm8GjDNKNT8+f7qu1f+36conMejM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VtegRTzKr0RkJDFrpAxpaFsyJvDjFIuZTAZbDN/uqInX04uQcVv34qgmuVj7pxhnb
	 5M9CQOWbqm4JgEyvuKdlMxasrvHxBOU4gg9D46ZWrW3nMo25GV2KZ/rtFP9TqzryaP
	 g3WWeBcv6H8p/pj6ZlI5LLVbGsBZXm8Qv/yVQU5ICDX5Yj+YI7nvKCTGPggpouySxV
	 hkrofdnO5+IVXM7+7k14591mHfzXziL8aWl8RRMjBJywP17wZUwTZ9LN/NyX2TTRZs
	 SOEJSoqxm4kGrWxQ2S6XKT+YI3OaATtLitA00ZiBfaBnPOrZ6L+NIGUrIZh0hxk5ig
	 2HHo14HYQOM0w==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:07 +0200
Subject: [PATCH v3 02/10] can: peak_usb: add missing includes
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
Message-Id: <20261020-canfd_check_channel_idx-v3-2-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

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

