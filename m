Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FBF47986A;
	Fri,  9 Oct 2026 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531106; cv=none; b=HmoZrxmK9lVq9MoGyCL5WUa/1f3y1hQEGtoHQQuysIY8TYdsp0NcKba9lw/RB41ry0jXEPvcH/YUU+xL2dfJtlc/pjE2EZJYqhl0qloNS2Y2KJTvEggZ0PcRVdiIKxFSte6sEcx5px/rHCNUCoCCbaFCZFpYtB/MaoE367gcqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531106; c=relaxed/simple;
	bh=O9s27VibkIo7lHHqWauRJ+HphousqPu0rpu7b46lFrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N67hHrJ5btN1sKa3wVzIX1BudyEh4Sai01pT/9hIfmv0S3ZrRI4USGRJjI9v82saPFUaGRyK8Iw3zjbing7/5Cp1KDW7potEIwhrEUcwWFWPG6oQsLcH+isQiwHiGQpxW8KLfTt4yHERXu0L6h7axQ+PgBwuk8mGsps+myNxiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=s89mfGFz; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="s89mfGFz"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 646C6780389;
	Fri,  9 Oct 2026 09:31:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791531103;
	bh=O9s27VibkIo7lHHqWauRJ+HphousqPu0rpu7b46lFrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s89mfGFzf9ctJFmcr1wAKqSaLA4Yicf6cu8hjwx9PHRiTfpH+Gv1GwdWO4d9eY1RN
	 Dw/3G+5XEsCZQ78JX22hEG0qEanIAbeVsK6Rmq0lTQIx0oGIgD9avpxGUTHIRxzD9g
	 M1hgC2qtcjKFTEOcMvRQik5vGvOxo3VucFyAY9oaAT3xLsfuHAiha61ag0uJRH2WfW
	 MOep/yYinvSnwkBekWA4+0uIV1u5f2B5mrmyJLdIUm7sGKW2MgHQUPPgv14+M8QKnk
	 Iscu7a9zD0T4nEXc2cgKCdAhaAoR3j4GZURtVlBqCT67KRY/XXRRem+mmC2slZe6vD
	 pBlDmdrG0PROg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Fri, 09 Oct 2026 09:30:29 +0200
Subject: [PATCH v2 2/5] can: peak_usb: add missing includes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-canfd_check_channel_idx-v2-2-f7b772929791@peak-system.fr>
References: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
In-Reply-To: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0

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
2.43.0

