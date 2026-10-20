Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492878;
	b=sKW4MBGlWITDQNPVzdbjMdKCO1//QnIJ3McEa32yJbMXnX8TZbsy9Ppik5zunCtII2ES
	 8+qjyRHNKDNZ+JPmUMGjrlZCde72jV7nexPJTRIl8zuo2g9Y3+WQc4gxFeGSVBr1zopC/
	 ngQHHn/VwHD4BZYc9KOA3HecrNPDHN8Nb0WnvDNVMNck4V+U46VdsVptoby58/tHJ4MXF
	 gxRqk57oVKrb1FQz5SaNkrnIQQzGxPrXBiRD64R5obF361Mt9kvWKhp66oqYd2EMtPWAS
	 ftrnbX+hm/7nS4xmbbgGN5RGkkONcV1U/h9gEWR/77bZTT2MXG2nUGqpHR4NvVwBRSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492878;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=HyeN6ww5mXakN+R/to/QG84N6/KL7dfMRy/h3T6vDnU=;
	b=CHzgc51cC4h9nkapT/hy844K4dGCl1je9OzYdqpvfHZT3EpbQ0KrUHGjpcoR3GEuCayV
	 GhlUO1J69D3G7yoycpf5yFgy7KE8PkjN4oRfM93cbRlt2ciGzxwL985ov9ryF62mxmox4
	 P8ztYshtww6kE3R+Qh4d1j9HiCjFefAmDSAE89lBL76JNnLLbjrg3Sx8rUDqn7tsQrqRD
	 V7N8X2V8bvlNQveSDl27pzYaS4i2PzTqi9qOfUptXQUGCObH0qEWxu8ab2l1ER41XaOON
	 dv6nhNLCRi2Bz2wE+8+ka4PLuExl97f5si1JLIOFyfToBQY4vLICBSuSFipOuMNkyVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=H9QRyeg1;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D7606A319;
	Tue, 20 Oct 2026 10:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E64D7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=H9QRyeg1
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id B35B5780504;
	Tue, 20 Oct 2026 12:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792492876;
	bh=tljyezjBvKA4hNJ3cD+XPPj0Gfqx4rlDANDus6f6/oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H9QRyeg1t1XOAjzwaf6vUvUQp2KgJSN51Wz7rP6Nfin0Ag28q17jOuSU9ajHYx2Ri
	 WReu3YuRaZoGAdCEMvqW4XVNgYgHkOTOhV6G1t64NQcSqCuhlmgfWBjeFq+55Qgyek
	 FN3M4OPZA/GEDcpC25kBgn5p07NFtowTFWrHtOJKtbvpAwEjv0++HMDGu5ZHlVzLEk
	 wvPKEyyIheAtaNOMxYQG5tuHP6HwMbUUfNNshGxIVIcCUbCEi49yCHciXr8uwEXBFF
	 jvPG/bUjLkxu7XJ7HgTjcUKH1l5o2iQGpYfOzPbuOjAYFXntj2fmkWW8VH11dyFyFd
	 BSiQ/LqhXkLJg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 12:40:19 +0200
Subject: [PATCH v4 04/10] can: peak_usb: harden PCAN-USB message validation
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-canfd_check_channel_idx-v4-4-bfbde81f8bab@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Add boundary checks when parsing PCAN-USB messages and reject
malformed buffers whose contents would otherwise lead to accesses
outside the received USB data area.

This prevents potential out-of-bounds memory accesses caused by
corrupted or malicious device messages.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 169c00d93463..5da91d5dc67a 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -558,6 +558,8 @@ static int pcan_usb_handle_bus_evt(struct pcan_usb_msg_context *mc, u8 ir)
 	switch (ir) {
 	case PCAN_USB_ERR_CNT_DEC:
 	case PCAN_USB_ERR_CNT_INC:
+		if ((mc->ptr + 3) > mc->end)
+			return -EINVAL;
 
 		/* save rx/tx error counters from in the device context */
 		pdev->bec.rxerr = mc->ptr[1];
@@ -696,8 +698,11 @@ static int pcan_usb_decode_data(struct pcan_usb_msg_context *mc, u8 status_len)
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
@@ -733,14 +738,19 @@ static int pcan_usb_decode_msg(struct peak_usb_device *dev, u8 *ibuf, u32 lbuf)
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
2.53.0

