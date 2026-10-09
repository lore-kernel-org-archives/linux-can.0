Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893B47B408;
	Fri,  9 Oct 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531129; cv=none; b=Y23FNZ7mV5GhZpZXgiKOyNhhEK+9/h0Re/3MhXcsoT+i/y4+4+g+RLjSMlIf4aFnXZ5TkhaOCU6VHElfVQUEEpfAZsh/dlgXJEjAjQaaM6j/jAmPRTTeCONsbTQUzUwC688o7J1JSKXpkH7fw4Me7Y3x+ojqOO/sUd9E8JD/VH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531129; c=relaxed/simple;
	bh=iqEVRbNqXgm8zNUzNvU+XWKuws1AVnSCpm5ngtXncdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKpRqUC2D7i0XhewXEvFJjGwqUuAPhMzCOEnwDBuUgEso5ULu5saATuePGAW5OfnsJlED05ThKCIgt8Ub1imIbZPo1vIoI01RpUaGWcaSxy+KVnkbgQsDo/TYslNPwbu7T3fk8jhozekCpFyq2fofLASN5vnZleNZjCaO4u2Vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=q0BQvJWa; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="q0BQvJWa"
Received: from localhost.localdomain (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 97828780371;
	Fri,  9 Oct 2026 09:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791531126;
	bh=iqEVRbNqXgm8zNUzNvU+XWKuws1AVnSCpm5ngtXncdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q0BQvJWaTCRTYxYGJ6fGrTp454XXnWZcNhI6Rz4AQDC0mhFMXh+ajOt/NVyEiTQf5
	 aSrND7zX0o+WfHRkmaIJGqIB0IcfS+qOqknSSwpXHkRH0SGLC+AsH7m/BRICjOboDf
	 0lSfeA8f4DsXvlBiTybukNRbOzkzklCLkdh/IqMbGWC/h6dSGCTr25BFa4Yp6h7S3Z
	 tKAJFZ0ZPc/rBGC8pgmTWQXwxdBN7+nljy4AFEsCJgl2v8VwIa1PQ4lLGMGaepH5Vt
	 P5Flpy+dFD6fZU8o83NRJA5RIQTEkbuItAUo6rEMrYPdV0fu0vai10dYWYPDmIJzsa
	 qOfwmw7ep+Huw==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Fri, 09 Oct 2026 09:30:32 +0200
Subject: [PATCH v2 5/5] can: peak_usb: harden PCAN-USB message validation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-canfd_check_channel_idx-v2-5-f7b772929791@peak-system.fr>
References: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
In-Reply-To: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
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

