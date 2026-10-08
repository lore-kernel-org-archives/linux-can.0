Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A41047C10D;
	Thu,  8 Oct 2026 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451490; cv=none; b=uueMOtka32tcWGcsTlWQD0nr7yzMVjmrf46EPcol1FwfCBQ8RLeQSjj5IHWghRwXT6zWowqVIUbMxgVC9Cfipr6Ec3cMeOtdeZMKS4l5WlZnsLIs7xk7DxuGKHKh7WYIsnh8DThnhDM9qfPIMQuC0lv00/Ds6EewV6O+xQaqTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451490; c=relaxed/simple;
	bh=O9s27VibkIo7lHHqWauRJ+HphousqPu0rpu7b46lFrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P13vkR2bM1tXh/6B7ONJO6mzabYxRx9ktG4f5uAHoJJsMebgkbcG0NXIBzvZNxyuvp5sP548uUk16k5JR0LWjJkM8MShfL+mkUH+ytC9TvwJHSfwmd/yAfEbmLlaSrmDhRDVmImLKAa7ILi/hUDsKHv0D0in/Wr7yu9b8vxVRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=oXjK3eWd; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="oXjK3eWd"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 9EBD078034D;
	Thu,  8 Oct 2026 11:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791451484;
	bh=O9s27VibkIo7lHHqWauRJ+HphousqPu0rpu7b46lFrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oXjK3eWdYZnYmMLBgYTnfiA0pToVRR6Ekcniho8DcwanIOMM9++VE8yKJSyCaZmz4
	 EHP1iXLARdD3/evKJAAfZW059msIAMTjGRuazah2LLwSS+6D1ljs0UNxAucbLItVED
	 +j35Fo0ohfAVSAo7fUUboBXX7PJ/K99kTIeAoZ6VDZMszccpZbliVqIBe92/XaJH/h
	 rn/iaFtoDUH0g+AOFR+lchHlCYsHPrXdERy9bZQwBot/6jemhb906mPeSChgSfG1g/
	 3fBVtBFcASdt/1eQaWoGjAf1IqVPhuFs7If8K7A5Af6GSekWYKtlojOpsyhtfZM0/D
	 omt4T01F0jDhA==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Thu, 08 Oct 2026 11:14:56 +0200
Subject: [PATCH 2/5] can: peak_usb: add missing includes
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-canfd_check_channel_idx-v1-2-0a3bb82f4e09@peak-system.fr>
References: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
In-Reply-To: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
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

