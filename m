Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065613;
	b=ptdEProuQnaISJECogbHkwCMKko+pSs/ULi+e2fLK7SQwR+eaxpxAkEyeNKi+3Odx6aE
	 R6WZZeClxhjhGJ6uyg/7r0slYwAVysRSChySrfwrQf26Bz93vVOtT3/nGvUEHiVvivk0A
	 tDTjs8PujLAk9vYhaRl2XFKYOFs5veS4uXAmElvhm4hkxdTcSBLlntyQfC/uDjnlazsfA
	 wG11hqcP3aPehRDr7N3aU+oRd0HkHsk9jNJL0ojB5csX5KFWhj3LPQeU8tslcUpeyKUqq
	 YK+8+iOq/069DDclUPOD/zLsNf961ehjEyhy6vQNCKm3Emg/bbikNCTQQ6inBTRsuGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
	b=zxpGJ5CZ1tO1W53X3QDiNAmomUfihIKkiA5yqWcwfMdFmsLZ3Yy0+FC0HmDnU+EOyVQU
	 /A4T4vMRz/0lHO2oW0yuQ+ItJjhrEw1NUV7iC5k15HxOnyaRPFO1uAIa8tXSNYbi1ldCc
	 L6ZcVaT0DAqdA4dA/ojTzSzqiBDWU0CL2/PdqssdXBXYb1OTyRIk2MHIxHZIlOr3doUag
	 lSF+LpN7p+ur1NZncoo/dSzGCmBxik+O6Wo+jnW3ZYQDxvRYV32MkkjCzQHo6Caj0fMaI
	 /yguukXp75es7TS2XF801dK6vjiVTDMdsSfldP/e2EFuXSzv5a23iVKLHc9uv6ei5CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6CF606A33F
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 15:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A6CF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yj4cDSkF
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2771933eec.0
        for <linux-can@vger.kernel.org>; Sat, 07 Nov 2026 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794065612; x=1794670412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=yj4cDSkFVYDWYdtMlaEUcHRvWY/d+c/hagAFafGVJ2kowj7dEQtzde1dFtIr9b8k4O
         TznZsh2F8ZZSCDShb7GwY1Q2EMPyfv4l6WIR8wugF0oVmUUV5XsQvpIkv9BYwYBa4upM
         v49KfCxM6hDHs2bGh3SbigkIGGfWJbKvF7xoSGkOBM8qpXVG9SHqKDSm9MEzjogwlzQf
         doEZfXO7C4/5NyZ9Y+AOCAwV6ZM/0INN4g2SEEtHsmIFnb9AbasKCMBkCp6t85EyOh6X
         pSPMnI/Mi+0bbcN8+9Sj0wBCv1o4Mwu+sfFQU2Ez6P/9d3JirkyqtgmB1V1hLsJMFsqr
         chrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065612; x=1794670412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o5BouOfVj6QrHRMx9FtSeHZTkceBPgzJ2LCjg7lA6F8=;
        b=w8mJpxw7V7dCAXX6V79dsGDpJZoTfc1whvYS0NdN378YAKWfUN+H7ud2yZNdRCmbxM
         Uy8uHrcYtJO03eB+/IVoXicNLMtz1ATlOqRxlTSvEOudS1OumGLCiM9WgOmo6yZj1Vjg
         F7XnPyq6DZi+fYgsswNiORTfzOGj0ikt8t8Hednzg4z5vvyXd4F7crcztNqMes8Ev6FD
         oooh+oomGN98neKo3tMGpMW0IhqOqSWrefjpo2l601VvSSr9/+rvX/uM/3zPSn2JTUeH
         An69BbL+t4JF/CCw7Cw9IPXu0Tl91TAPJ6hzrK9nl8jcbDbO3sA8eSeffF+0Oxpd2pFf
         ywIQ==
X-Forwarded-Encrypted: i=1; AL+hErFKVuW3fL7gxXkz/23R3maeLPfibYrsUouBOoc+VIVSXLi+MzjI/PnP4UJNRn1Uo96CqMS5ilndQ5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xwTPolTlzNaK7Eh8TnkA1k62Iv/iJMqNqpsJMjL1Y1IPvbgRi
	rDsgwLmgEisC5o2hYPJJSU6FQjBn5sjL6OM1ZsQ49UDoju1ZglyIwHr0
X-Gm-Gg: AYBFou0pfj1/qywj8NH18U3bBYjHwHkXOE8aDiLkEr9/89iqN7HrEg2eRgBSr3ysT38
	h+SQvu7eoUWXv979hRUWrTFXEkFkEMZalXaOe/l06M3LiWYgX85Sho0QbXhvCx5PHtSX+a8W0Gc
	E7LKYM9+ictH8gXcWZBPvXDytq9wxWYNB8xBIHIh2d6nRj8jONTIuVwf3PQi6WRZqc8R1kOvKOY
	gCj2B11fT9XXkJoeUnhB06v5I4LkzSN8z+45nyM2qsD7pu/Rpx0U+uLlhe1NGsKRn05KdVfgDJc
	330pNrae/H/gI78ZOIkjzZ2F3FOeZJBDiO2+Ev1zX0FyfXUr8rUkJdYUl+yJt+WwlD9ER1dZr5j
	YFYlkNEVQnor1PDSjBbjvUyQ+pb9jM5usqHc582r7XSP0B3B7s0KQQbUGohQjh4vNBB9LKpIj5y
	0/hLGmHv7hhSxkpqdzWxKNjPnu2spnrQgSpC2hIHHhrRCKqWIW6d+5/aLrOH00UnLGBSKgokJv7
	iLn2v0qNjBSkzt+WIZac2PNXoEgSBK7abJ6ggogu/wtHGOCp3y5vvRCtIrGIKetgXjsJg5rUXOd
	pLYlGNDxQJRuYSX4QejOInm4eC1F/0PkwYr4VW4OGzBaTMW8FN+Pdzr4lv0x/qmEghNc5g==
X-Received: by 2002:a05:7300:10c:b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36f771025d2mr8735252eec.36.1794065612157;
        Sat, 07 Nov 2026 07:33:32 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa96fe226sm17256890eec.12.2026.11.07.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:33:31 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: peak_usb: pcan_usb: cancel restart timer on stop to avoid use-after-free
Date: Sun,  8 Nov 2026 00:33:19 +0900
Message-ID: <20261107153319.3765325-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

pcan_usb arms pdev->restart_timer from pcan_usb_restart_pending() (the
restart-command URB completion) during CAN bus-off auto-restart; the
timer callback pcan_usb_restart() obtains the pcan_usb via container_of()
and calls peak_usb_restart_complete(&pdev->dev).

Unlike the other PEAK USB adapters, pcan_usb provides no dev_stop
callback, so restart_timer is never cancelled on teardown. When the
interface is brought down or the USB device is disconnected,
peak_usb_ndo_stop() / unregister_candev() tear the device down and
free_candev() frees the peak_usb_device (and the containing pcan_usb)
without deleting restart_timer. A restart timer still pending then fires
pcan_usb_restart() against the freed pcan_usb (use-after-free).

Add a pcan_usb dev_stop callback that deletes restart_timer, so it is
drained on ndo_stop() - which unregister_candev() invokes on disconnect
while the interface is up. pcan_usb_restart() does not re-arm the timer,
so a single timer_delete_sync() drains it.

Found by static analysis and code review; not tested on real hardware
(needs a PEAK PCAN-USB adapter and a bus-off auto-restart racing unbind).

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c..4c13195 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static int pcan_usb_stop(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	timer_delete_sync(&pdev->restart_timer);
+	return 0;
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1059,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_stop = pcan_usb_stop,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.43.0

