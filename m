Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792503054;
	b=XBEZ1FJnXp76l+PwheF1qJnR8Z9RD/zhW4V/R5vgPobBiiKgMHWHxJ7ceVSDfP2uvYni
	 IkmKmvIpL7cc0cNo6qp40clOlTnVTB6pf3iy+nJ9Sg1P7GRToZ5oL+QHb5tCS6UU//g5O
	 GoLL2ASYI8wgBNUa+6BcaDVe0qnOGvbM5EYGO787VxKhc0NOgTq3tmKdame461/Dn6z6E
	 GI409WXLoq0teBWw4xQDJ+kntsUhVniDZZQEVePjPU1mnI6+ZUNrPi7s3UxInUUVy4L90
	 kr4ox0tQV/JqHt31ehx8fXZhJSgAcEwblzQl4hc13gGVMTDxZ+BvWeh2kd/JaDYWJ5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792503054;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HyeN6ww5mXakN+R/to/QG84N6/KL7dfMRy/h3T6vDnU=;
	b=rbiE+cGab1BPbhuAtkfm9JdcTZ1+wkgxCSpInGlitdujavs2+C83SyezTJcUsDLga8Bn
	 S7MfccUNVTcLjeAPNGT6EgBbfBjIQtr+Emmympgh0UrGVD1jldaPnwCuVdF//fnJfLE36
	 XDIhlMPFP9LK4yE59GFPkZb9JPfHaL8cSJWiyQrW+WbsLFf0AMvY7l8DL/Vk+PytvLZcY
	 eMV6QrIlbYAT67Z7fHldiHJUNjl3HFEP9BFTZvNpY7R3JXfjNqz/97culSjev0FVj9+Qy
	 siJN2sLxcU70ZBnOee3EY2OMwmf6AiQ3K3RGxmQEmNKwsRbhlFoyhsDiXLEROxKYZDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGA8s8sQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786A606A325;
	Tue, 20 Oct 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JGA8s8sQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792503053;
	b=bIy+AsM6Hc4a8w5Jki5qRl1C3tTEAR36NEWT7sRjtTlzc//h6ldUbaKLOo+QkdzeoHm4
	 l1iZSKwdoFb9p0M0JeKK5zIGC0NLp/C448GMVuNM4upinYwrQZCHtU2Y2yfYlGXh2dxfs
	 DvhVNJIR24F6gSa+r8YCoeGq8TPlvF+dqAn9Vm31zW2yIHJxCl2TkRwkJhLLsgtT8QVJD
	 rELuXme2wE/8LschhIuVtJUyHeT8F0FVVWbiiXk4M5PInelU3lpw/vc54sNErWiEIHJOR
	 8T+S8FOIUJfpOwU4YkiXbAI7ZyM6epL6jdGTLHoEoZsnxQodQ4LorzwULQQTcQUs/TQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792503053;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HyeN6ww5mXakN+R/to/QG84N6/KL7dfMRy/h3T6vDnU=;
	b=q42Oi7GYVE8zDJYLaSQa9Oks3936TLJ5mPDIjWB9M8i8RL1YdRp9o2FiAS8TBgSU9RvL
	 9HBVU9O0QMc2AR9qdaUp0pgQaMQ3qdIIAQ4B/K6MZLG+xQgGSkGJnbU56XSmpOhWHOZvZ
	 17749s+kINoSYEirOix1QWs5SoQVOVWP6tgCMKHDJzYKZSKRGuSdamcK/7ZH8PYnkhVvy
	 EOw1WvxIJVuDOLYJV5zVRLDE/hSq9RKAcwfNaj5/mec4sfBE1M8cYKyu/BQDsUjGbGa88
	 VwG1G3HCiYdjqonI+SP1WXwIgqP2J7Sbiu+c89xzYncBF6urhPURgMUFHBMU0r2nQeA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2EE471F000C6;
	Tue, 20 Oct 2026 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792503053;
	bh=HyeN6ww5mXakN+R/to/QG84N6/KL7dfMRy/h3T6vDnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JGA8s8sQa9lTuAQ4SFc57To50PLxIspPxBGP5dPY5szb6LYm5cP2yJ/4QdLJ6dyTB
	 rwUFfyMCQ/IsajzOOyH4luZ/rLUIYHENwLqUOaF1gOQd5VAM6gdcQKTlD9D2d1Ntju
	 WgB3M5NbHHxYfKRKDyImFsEJ5N52L8trJuMaOPnpnbromMXlb7QVmQR3EFH5katyzK
	 6+KQ5UvLwwQPfGU11uOmnNxWIiGdCw2cdMYIvcoLsctTTm9KW4mYQlEeCetYFmnOAL
	 hxNefqTOoIPhsHTkevSkXn8NeOs0lWc0N133k5eVXCez7sJnOi8hiOJse+1vvLOvCW
	 3DSo6RRa/GiLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9C5BF43186;
	Tue, 20 Oct 2026 13:30:51 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 20 Oct 2026 15:30:43 +0200
Subject: [PATCH v5 04/10] can: peak_usb: harden PCAN-USB message validation
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
Message-Id: <20261020-canfd_check_channel_idx-v5-4-a62b35b867f0@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792503050; l=2377;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=QSRDIUxMqXoIIkZfTsx9hTx1e/7ra9VoTXmZtvygMls=;
 b=5J9UzEovUuoK7m5LbmIc5Z6F0TP0eRHk0nj5cBwrpA188r6QowT0HqV7pT6Q5KnJDfBSBO3+W
 CPtx86IR+/EBEw5mUerB9/WZsXIqOS2B/Km7PfzBeMveA5GxDc9zSBp
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

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


