Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199764;
	b=206w3qU5f2auzPTyzIKukZYKfi34E+kSVb22LK4rIy86pqWv0IOm5EPkQ7yEQ5OQ8War
	 JdvGMGrhBX1SyJhst51DK6uGX7uWFcHuSgXk8gOy5FKM7DuENNrycOY6DfvPX8iEPSN/w
	 NEaRyGB5IUFW97fMhmP7weZyLGgFSA2Bn8pAN0GtLeehZL63PwjryB36oMHlEtdSgZeV8
	 CLxm1vDlJdOnoJu7eegiD56Js8kd7NXw7mmOwj5Wu9NWok6w1ynNHUd5LavuA+4TW6xav
	 B0Vd1M1CF4DJvHUv1DNASgEGu6IUKApGmBQWjRDoWRO1WP4faDq3+2BjPsdEMqeIwow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
	b=yJ+CK4dUVpemLv20ccXWvrFtmTBThNl9P44soH6XlGxn81NHpxbCvrGXoYmXM3v+Ve3i
	 ce/uiaaI3qWS6dpvmSl1CCRDnPXArnoTXJ680FbM0PoCZOSzUjzkS7trglaEBF/d5hTyn
	 QnBX/b+vUicGYDa1d44yXFR064S95JWwRl4Libfwndh6a5goFmTnRUv6y/mMJncB3K+rI
	 GGtDqGLN42B7WjNE8qwM23UxRW0aGNTuJkif566NDduncJlbCzDsO3yOdlFByXpbDFFpG
	 AvxLwMNC4FCl0ev6V7t7FG13e6mUXIXOeNL0GkOBhMdVdeb0sF8Y1IGNzEoj91P3CWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWPG7Rw3;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381DC606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 04:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 381DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YWPG7Rw3
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2af4c8d00so993620c88.0
        for <linux-can@vger.kernel.org>; Sun, 08 Nov 2026 20:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199762; x=1794804562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
        b=YWPG7Rw3GhQIDeRfhmsePYwuXhvWsxUUzI6hojJ+fY1qaHH1Htyi+eOqe2wQWDslPR
         I22+t1yGJ8y8fkQHpmb46zHg32JdmQkKEr7BQ4MsYwXJlJaORrqh6xo6jYXYKif+u1VD
         tkbRE5zM6Gq+kcfUtTYrhSoOTR5LpsTKqQ48P2TYrEQITbuVm01NBm0SgkNqJ2Ttw2Z+
         g9vqBLhA6tnfHk4DgCaglDGtCMfHPKDT2FZyWSZd4r9hptQKX9HgfuZ6bgDoStFQ2QLu
         hGuh0W2YSWGVfl9gYX/l1pPT4xjKW/xddf73Ul5FDoFkOi4RD9mC68FXTOFmvXVzef8v
         Ki1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199762; x=1794804562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bW3pGp4kpjQciNHmYt5QU27XFZt+thBEFfTG9An0N6Y=;
        b=DlVVkkg2bPqFZBXnSkGiZK+M6SauDBwv7nKEDMU6b21/wndZ3stf3gozKbfg7B1DUv
         hffAkD+kJQ66PaB8ztbw5FL5yGF6k0NJuDaFJhncuASZ9jDQsGI6vL491I6P56WAyULj
         v3zdXtQgYkaMWJrjadoJhV2D0goBJUSoAOMQFsP3IKVstiPGnznkmJ+KQxesWs3Z4zZ1
         NC22U9VqarA//JnU0/PGhJHHu60V4mqZay1DvRh+JRD5Ihqzi6eIbsHclonv3aGgOzes
         XNY05boCbCvhfWUvdIA5i+zk+SK2V3PkpZcTUKxWk9sI1hDWWEFyT9djVpZnT+H3AUrE
         /r1g==
X-Forwarded-Encrypted: i=1; AL+hErFgamAmAoEgwCRPTpPDymrFfSGgC/G3gIeMUXE8Y2VFLDgkNw6IoTTYhTOXaK0TasvVEX3Xq2FiRRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8d12p9ATz3Js0ILX5ZT/7/F/tpFiPdGyrCeQvNLC535pwbhg2G
	9eenKWRCFyETUuyAgvceaqgJsPFO1BDCmqAQcJm7tfVBT55QndQNwPfd
X-Gm-Gg: AYBFou2SpxbHos667OJ9okZUrEoYbhTfOGm8D7PgkdMs1j8qiwZgLX8woCg4CZtTZBy
	/X4ip0jqHscNxXuHt9FbWoTxjpCRXi0Igtwf3g/c7WR1j+jj5tITNuf7RMImNOsMiGiG7UaGhhW
	4vsAnLhcq+GhjIeD25fb9Rk80ka6zZcMu3tIUe2gNAw1wK2eUlOdCG4grIN7mX3H461ERdTTfxX
	y07+AznTl14AtAbWA5D1tI1XGQq2jDUj/govMmMGTDWL+hTy+wa2h5+XoyrG1ZoGGYtkY0qm8wy
	Woqo4NbH60NQ9N41Crf6Vogs34WUeirGijKB8TiCR2uMKPI4C6ICw3adlIYdSAaYEee0FPPJ9HU
	UDHi3gwHX7L5CewJhzOAE5s1z5cSR4sJrxn0bND7QOfYb9qs8TuSWdg9tD/tyHXI7/6c6aDn2hc
	8PLLw6CsysKibXwNeCzFTqC3hjwUhekaexVKvr+eoczRTGGI3r/nQKLzS1ihIF3cuQoaCueREEU
	P3It9LRC7IdMPRoLivIl7CdDzilYX/5kE5msWJMMaUes02j33zlPToeXETqYlY0bwXnpDg2eON8
	QT6B7Dh1S2OpR1++z7t9UNbMC1kmsuRqux/vn/G0jZyf/Lz3
X-Received: by 2002:a05:7022:7f01:b0:193:9aa3:474c with SMTP id a92af1059eb24-1b39feda7a3mr5031920c88.21.1794199762248;
        Sun, 08 Nov 2026 20:49:22 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37561ccabsm9386759c88.12.2026.11.08.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:49:21 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-can@vger.kernel.org
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] can: peak_usb: pcan_usb: shut down restart timer on free to avoid use-after-free
Date: Mon,  9 Nov 2026 13:49:11 +0900
Message-ID: <20261109044911.1163505-1-hj351016@gmail.com>
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

pcan_usb arms pdev->restart_timer from pcan_usb_restart_pending(), the
completion of the restart-command URB submitted by pcan_usb_restart_async()
on bus-off auto-restart or a manual CAN_MODE_START. That URB is not
anchored to dev->tx_submitted/rx_submitted, so peak_usb_unlink_all_urbs()
does not kill it, and the completion can run -- re-arming the timer via
mod_timer() -- after the interface has been stopped.

pcan_usb provides no teardown for the timer, so on disconnect (or a probe
error path reaching the adap_dev_free label) peak_usb_disconnect() calls
free_candev() with the timer still live. A pending or late-armed timer
then runs pcan_usb_restart() against the freed struct pcan_usb ->
use-after-free.

Add a pcan_usb dev_free callback that calls timer_shutdown_sync() on
restart_timer. peak_usb_disconnect() invokes dev_free() after
unregister_candev() and before free_candev(), by which point the
endpoint URBs have been flushed by usb_disable_interface(). Unlike
timer_delete_sync(), timer_shutdown_sync() also prevents a late URB
completion from re-arming the timer, closing the window a plain delete
would leave open.

Not reproduced on hardware (no PEAK PCAN-USB adapter); found by review of
the restart-timer teardown path.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c32856..113b2e745331 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,19 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
+
+	/*
+	 * The restart timer is armed from the restart-command URB completion
+	 * (pcan_usb_restart_pending()), which is not anchored and so outlives
+	 * ndo_stop/unlink_all_urbs. Shut it down -- not just delete it -- so a
+	 * late completion cannot re-arm it after free_candev().
+	 */
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -1051,6 +1064,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.43.0

