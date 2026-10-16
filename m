Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EA835A397
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131101; cv=none; b=m1Fd2l+tGK2I7MU8kWlXZ9nmXV4voh4KqKEeotsrAZ+AyCpiMz3aLO16rAlMcN8IZxtTiWK2nKjI97e/lo0kAYKfOHkrRLbZ5jU3MecXAtVQ8kkKuBO3cgz5hEVcL7kbIWpHiCQC3GQ4dtlGxItMRfNxDcp7Pmm3mAjzmJDzm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131101; c=relaxed/simple;
	bh=lW1SmNMHZLUdjwKr2y0L+Tr3WFC55TvE/uJFRdnFpiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxU2W/YlE6Tqih24qmzhZTYKMnrk/pn2Y+ZZi4PB23d6ibjp0kAi0e4zO/hF24XmFjRKuH88AQoq0B4QTgA1TgaUS7xk6293YF1pFk7+KuPa2y34aHhcuOW/t10t/wYi7A/Sah3jXovgdvqyyrnKuWdTApsPiKNHHblVVZggjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwhkdu3C; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwhkdu3C"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so6387436eec.1
        for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131099; x=1792735899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWmAXF+DT/idqJMn3V+iTCr8CLKa/928BqRixUV3uIo=;
        b=dwhkdu3C+XLVN5zZZ5nFJlp+NYsKHrupg96O7mn8tHhUwFWA/cgiacTO3YXj1xttie
         8HeP/NRZpQ9tqYrRaqPX7r0XCFgIyXs/lHkJI3Tg2uGtjuGinoVyNUElHgYb/tdAf5d9
         CVawkIps8Kk69CJruc4RMzT+xGB56InDqNAERDb9f6ZKnBfC2fr1AgllOkDH1VW/dsPa
         Eq4dyonv4gxSgKez1RC0YQOFHnBm+ow8zbdFiBZyljBdUn3jFssZQ3xJVcLreHtz7xn9
         T+Iz5xbXcfKEZh+LgnzDTgsX0R6iehR1MYhdW0HmpauuAVtr/vyCs+XFiRWtwu3gJEeS
         Rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131099; x=1792735899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWmAXF+DT/idqJMn3V+iTCr8CLKa/928BqRixUV3uIo=;
        b=2C0OiPAbHOSK7X6cpnYFXFN7TrUZNTFBYJlCDjMjkbh7giu/87SjoVhezZfUg5Ga4f
         J0ljUrH5cRlF0/oxiOcmwPslZ05qEDDQ062/KuGRnMzLe1kPyXxgVi3xufEIOFY/ZLPF
         1gpdMv8ocR8XCy2R7bkiYDzvmYH4flCsxi0C7T1aVhVEm6or6IJ49Qd7U3DWDsu5/9FN
         6lTywru+6v5qLd6w2pPBvONR1g94SCVlyr3GQ2DYkfjLa3RI31en8tmPkD2McLd39gWb
         +l34HYreraHSwMgj0ozg1l85rYIi9/ohys3xUh8gLfsd6XX/ad5PbZuTT5u2JKLj67N/
         uLOg==
X-Forwarded-Encrypted: i=1; AKwUvBxdYdAJDZsH5kIG12AW/yO6Xqlh15Xi/iFjXZTwSJw5ek0jl9m9tLspGLdiDsxcKckwDXb5utg5UVg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKX3pJTzYQhfzOd2gZUF5pj//eFwlK5S4irlMaWh0FJopL01NiM
	cE6KA3Sqh4/dQExR78ezOYD4KTD/NfcBiDSSZgfzb5OWRKvkxB7ac5n4
X-Gm-Gg: AYBFou1+DnExopgdJ7qpMIFI5j32JgPcQDshsYPf7QFQiqOBuO27WgWN591sm2IrCPj
	tIZUJpdUTrRp+qnOOJ2Hd4/8l6FiPKa/4vGOBGsnISvrEjzzNVBWq5cITqaDCNXB1a0BqwIpKlc
	bhRjGWSJMb/QlyoWl+XN2W9Rx4U81zyPT7qWNNiAS6m65wQk92f58SNkVS7KPcxQp75EpU6/YCd
	6vk6LcX0bNwsHAIqX+o1jLnmLX+kaH+kmAn43WNERvmDLa5SlJxx8vsfGR9tIWOYofqObVjxLoJ
	jjxwQiXxNyI91/Bgylj1LW1KOHyxztOwBTF3VVlb43Gq2/X2to4xbBUXAP8pIxu21KLFYiplzfi
	BQPTq6fJMyPUIq7NpwBNRDR0Sw14pq1/Cx/bF7xurjro/MqJT1nwkdmrqtwRRc1+lZS525aYN+Y
	b47t1YyMyYPfgkZS00CROhE2T+NUnqXYXr8rI+YE+5mT53O+V6qvzITyWAXhX8nbxnuKVSJQW76
	/ZHPjXVOoAG06QZOmgrt2HiGb1hIv0NBaq5L30i7mTjuxM=
X-Received: by 2002:a05:693c:4097:b0:358:8bd2:fda1 with SMTP id 5a478bee46e88-3588bd2ffb0mr34500666eec.30.1792131099385;
        Thu, 15 Oct 2026 23:11:39 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm3725600eec.4.2026.10.15.23.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:39 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] can: can327: publish tty->disc_data only after register_candev()
Date: Fri, 16 Oct 2026 14:11:20 +0800
Message-ID: <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can327_ldisc_open() publishes the private structure to the tty layer
before registering the net_device:

	tty->disc_data = elm;

	err = register_candev(elm->dev);
	if (err) {
		free_candev(elm->dev);
		return err;
	}

register_candev() fails with -ENOMEM from register_netdevice() when the
device name node or the kobject cannot be allocated. The error path then
frees the net_device and the can327 structure in its private area, while
tty->disc_data still points at the freed memory.

Publish the pointer only after the device is registered, so the error
path has nothing to unwind. slcan does the same after its own patch, as
do ppp_async and nci_uart.

The stale pointer is not observable today: tty_set_termios_ldisc() clears
tty->disc_data before .open() runs and again when a failed ldisc change
falls back, and the ldisc entry points are serialised against .open() by
tty_ldisc_ref() (async) and tty_ldisc_ref_wait() (syscall). The change
removes a trap for the next modification of these functions.

The success path was tested by attaching N_CAN327 to a pty under QEMU:
the ldisc opens, creates the net_device and SIOCGIFNAME returns its name.
The register_candev() failure path cannot be forced from userspace and is
only compile tested.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/can327.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 90f5e35f3c8f..d40dadbb5733 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -1037,7 +1037,6 @@ static int can327_ldisc_open(struct tty_struct *tty)
 
 	/* Mark ldisc channel as alive */
 	elm->tty = tty;
-	tty->disc_data = elm;
 
 	/* Let 'er rip */
 	err = register_candev(elm->dev);
@@ -1046,6 +1045,8 @@ static int can327_ldisc_open(struct tty_struct *tty)
 		return err;
 	}
 
+	tty->disc_data = elm;
+
 	netdev_info(elm->dev, "can327 on %s.\n", tty->name);
 
 	return 0;
-- 
2.43.0

