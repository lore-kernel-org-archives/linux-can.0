Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492862;
	b=DISd9fny2+m2TyY70YndDQl9LUJkdWuEWNjMWwqrZFqkfi+qI6+tJhIDcKafXssIpIGV
	 FJd2GnLo34f3jWJY+G7NQb9et6ppfetDm5pElqLjLhg3cgkgAjhTB2KLR/xQDrwKfJyJd
	 JxlsjgtdTFzyr1FVrPqE2rqQXylxwJWExx7dg++ecHxpwF6+SmeJjk00AE78AXeclQOlW
	 lKO32oXkubGauZgKzNPqTiKLxIRV9812J0LT8MXl7A7vSNEmP/IlmU+EpgKux2FQQFg17
	 8HdMiEAiKn8jFgqaGK/erR4FZGYVn5/nwbxNMi1tKvhi00jLkquF9osFK4kk718PKGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492862;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=6fZivCByipTdBLgyD/RwCLFfiUlcj+W9AE2qIVVKLVo=;
	b=WKJ0DC/xR5uQ99YidHAAHbNvlrYqmOI4ephTJbE400rgVEYXkyYMsBxzfVSKSuohQl6i
	 LsePP2DmazI5BtJsTLn5XlImxx0gVfs5z/+RiP0O9t1KRpTsWwiU68FCxWgZz+l3W16Zt
	 w7mZOzqh+6cV24P4HyHy9gHEHevUyL1g47zctwy4d0AdE6FkoUmGL5P0sYLS12DzpDThz
	 co9eYi2+jdRl5zIFMFujniSgOLkHN4Gg/268sh4gkpzvfYIsLJ0Zis/7R8FC94gfC3OF0
	 J/ZFFPn5SsAeZ9OlnS2wBDcC7yivwAKfTV7OPZx62HCZZ7ZICfd3CKZvZ6y2kfOYGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b="EtVLScN/";
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD7606A329;
	Tue, 20 Oct 2026 10:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DD7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=EtVLScN/
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 23CE8780503;
	Tue, 20 Oct 2026 12:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492860;
	bh=dfRoL8uIWFI0+fuGm8GjDNKNT8+f7qu1f+36conMejM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EtVLScN/2r9X4sACaVWKgwlv2Enxta99B5PoHWtAPlf3LFxy/C+YMPUgvpRt7S2P2
	 2FqHJCADxbUT404aFXp/MIp8V8HjIlHZ8GYREliF1YdnpXlaSdkcXHJOPxLIStdmOr
	 GXZoNhu7+Z3Fybl1vXIXDwGayLgZ7D0a6Vokoi+ZaM5CoYvtvEgbc8i+EiVwd5lq7M
	 emRKNL9ZJXBH0YJwWuR7RmhI0Z+8jpxR5w4QVRn+kl96vG96OIQL8LNE9HwBHcMoJ9
	 016oNWohxWiXDOFphZP+dSEmpHT5s8+ElgowHRWV0ZgR9XFjNG7U+H6Fcm83e23Aen
	 8mAqPobcpBiWg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:17 +0200
Subject: [PATCH v4 02/10] can: peak_usb: add missing includes
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
Message-Id: <20261020-canfd_check_channel_idx-v4-2-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
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

