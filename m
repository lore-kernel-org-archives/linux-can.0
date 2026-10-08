Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB223E6383;
	Thu,  8 Oct 2026 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451516; cv=none; b=L8CTS5crYw8qtZFiad5/ig3b/QYanvJj948CdCU9GeNxQ3HKFPASsdoE6j9Ky7Rb6HuGL2Rm34Se5T3aEsTejv7y28Y9/ro0wgv2Dm57AB78wBBrc4p6Ic4oCLQIACeQ9BxtWIJz5bQmRVnpUed9fQQszEeEdxRGtiwKESUOi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451516; c=relaxed/simple;
	bh=iqEVRbNqXgm8zNUzNvU+XWKuws1AVnSCpm5ngtXncdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G7+Mzsk6evujWDWSIpEZ4m9f5SdG5SR9WS+ONNt9q9IExv/XcbFx/UT6/WhyEP0fI/lc+ItbYKauz8BsxrmXI1E32/GFYzo7oxTHfTNak4t5hkw6mi2poiWa5PoSE5Jfyg6YYkZ3YGO7Qf/t8TuGF3At2meiWlWqMq9EVJFmNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NL/Br7YY; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NL/Br7YY"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id D1B16780371;
	Thu,  8 Oct 2026 11:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791451507;
	bh=iqEVRbNqXgm8zNUzNvU+XWKuws1AVnSCpm5ngtXncdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NL/Br7YYfUOnRMK0rcZc+4hokggdvsN41T+cqVzMDn6LY+X/PylW1vb5VXFvJZWjP
	 jmyj51aM9v6G01lYM5RCleCzZdE/SKc6hy4yKX2ZBp1yHnmjdba02xLTS3r9cz0kbv
	 R1VdV0+tifUqetK26UWaqCNlAyb/76ekusUxO9SRS7P+FeZrQgzI/y+0LKJRPLc9Kk
	 uJFJU2yyCUcSRlx5JFEUtNsmVk/TPEkESgCYEhsqvsDbO1dKA1r/J8VRUBRGp234SB
	 2JHVJ9Q9YdE1WpIAfY/ABA6yLs5nmkPL/FpcoiVhWrhs+ozh6tog3onquPmeMcZw5p
	 tSoHLEzMPCxQg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Thu, 08 Oct 2026 11:14:59 +0200
Subject: [PATCH 5/5] can: peak_usb: harden PCAN-USB message validation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261008-canfd_check_channel_idx-v1-5-0a3bb82f4e09@peak-system.fr>
References: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
In-Reply-To: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
X-Mailer: b4 0.16.0

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add boundary checks when parsing PCAN-USB messages and reject
malformed buffers whose contents would otherwise lead to accesses
outside the received USB data area.

This prevents potential out-of-bounds memory accesses caused by
corrupted or malicious device messages.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 169c00d93463..56ddd134bae0 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -696,8 +696,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
 		mc->ptr += rec_len;
 
 		/* Ignore next byte (client private id) if SRR bit is set */
-		if (can_id_flags & PCAN_USB_TX_SRR)
+		if (can_id_flags & PCAN_USB_TX_SRR) {
+			if ((mc->ptr + 1) > mc->end)
+				goto decode_failed;
 			mc->ptr++;
+		}
 
 		/* update statistics */
 		mc->netdev->stats.rx_bytes += cf->len;
@@ -733,14 +736,19 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
 	int err;
 
 	for (err = 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
-		u8 sl = *mc.ptr++;
-
-		/* handle status and error frames here */
-		if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
-			err = pcan_usb_decode_status(&mc, sl);
-		/* handle normal can frames here */
+		/* check if status_len byte can be read next */
+		if (mc.ptr >= mc.end) {
+			err = -EINVAL;
 		} else {
-			err = pcan_usb_decode_data(&mc, sl);
+			u8 sl = *mc.ptr++;
+
+			/* handle status and error frames here */
+			if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
+				err = pcan_usb_decode_status(&mc, sl);
+			/* handle normal can frames here */
+			} else {
+				err = pcan_usb_decode_data(&mc, sl);
+			}
 		}
 	}
 

-- 
2.43.0

