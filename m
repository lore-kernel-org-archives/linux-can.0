Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946735A397
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131098; cv=none; b=bVuw1EAXC2q6B0qMXZaqMvaGOmpMaTDvnXGYSvhDBr3uXBdR6ZMKqDoMsdNll1Nqwq8LA8c44tRrwMINuz93qUZIdNjLKw4eDcJllWL6kZraWWJPN2IDY1VraoOB7Yrsphc8vfP8BJnBgJjbwngJxMMsb6SxbmfO+Dn/TGO/248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131098; c=relaxed/simple;
	bh=6J1j99RkGgHd7qnYJJuahkEuuMeFF8fLW/57SAMBioY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcO59B7/kHH0wuE6Lq2NBKYhDJRBK3o25S5PIitpbM9LDCa/lAmIyBavN3cZaOl1pORWJB5U0K8O69ospO81AWdyyqDC+0u4GWnwqUl0J1UvVsoZfOTICiQ6b660CgMpXUYxZkWtDL3QpAJeF2tBMoLwo7LeHU+V3+x5CqUKJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxK1gOx3; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxK1gOx3"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so1719486eec.0
        for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 23:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792131096; x=1792735896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWf8bZZYyS9ZR2mGM/elWEcGt1jLdPTo6uVsODf8oOg=;
        b=jxK1gOx3cqnle8IoFxB2w69TaBKR0aYow0y6D/miyy95ZiVmylgNTd30yJyObAIjy2
         lO6QAfVB/cHGRI1ABXReGFrfD3kE4prnrb0R7n50vxiR8y9s3AKzI9TcpUgt1oXqf1+w
         4expdPGqy94uLtBPuosLgTq6BVe0nSly1L6PRRbSvi0vMo3DWFC8esvlh2jpgboDZNGZ
         3TmFCqXngfUZ9RigvbgiHf5eZQ4FynMaFaE+6oFHY0FUnoHFkJEtoguaaAPacrYt8d0T
         59sbH+dJXOIrzaEKwAigEtvs4Jt6VjAo26FwRQo1SY9K/SlasFOZRjghf/ZW9OOyLurN
         vwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131096; x=1792735896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWf8bZZYyS9ZR2mGM/elWEcGt1jLdPTo6uVsODf8oOg=;
        b=hn6ndGjKXnBdfQAsgy9Ed7mT5NJlaYhYP0aXKP+bd14yjFRMGinhcUlVZRH/LF8rBN
         YlgsOKlJiI/CkX+t0hL63QeSeV9JJC5xg1zUGsOf/hwO8isYB6HpPpFgEz/kWCEMONVv
         YR37eGusjdWWffXcNoe5vGh2m0mr9z5nQAU6HHud11qtSy2NWT9j9MuQxEzLS2tUvVkg
         mQUu3FdpeUcd8ZdkNdJZZwOswA9eB4pMM7spKFsDDXj3bs3qdOFPup32CVKYuX8pBjv+
         /H2aL+Hq2olDicu7C/Jwi9SDVQFMaMlavWQUCTflKPpd43dXLpd1EmWtXETVqRcrOn/5
         l3hQ==
X-Forwarded-Encrypted: i=1; AKwUvBypagiv5QmGLa6Wdl7ToumJ8eZVlVkfYqDUqnhNaq13HTfqQdDE81wHXO/RvpfRCyMFEDExBjjUKc0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+Z3uftkKo1A0S6r5mPHzW2tLkqQUShfvLpc+8Ye0Pdv6AoYNY
	9SsU7OF35uhcsVRdQupbdEAve92x/gJdn7MhMZP+nWcww3faL7N2239T
X-Gm-Gg: AYBFou0ZNg2vnQvpPqHaWOOBG/OPH/B0pi4WiytelDWndyZ6z2qbi98EQRwIjqM46Ll
	/PmGhbEHh1pWox7rb6ARDqoNec16o8T+rEt9VWAUlXT6jPzFr9FbAIjaYU27FmfWMeYPNLYjcd0
	SyXt8DMApae1+ZYxn4SZ2r9wIEPi1mIXEv6oMGY6pBoFkO+w0N17FtQtlYajd+44MoDBE954QxM
	ziiW6t0OX5uxtGDxbgANMYJ4FdZjSsCzPjsVKKuOlHxTrJdBlGPoN+/kwSONKWISq3KHQ9hdKoJ
	DGLlKWQWsQ5QJy5WI6PczekZMghxf4yDJVtqEQ9nDDoSIWlC8T8Hv3scv/l3IwOVB9ATMe+scNc
	VBHpRrx70gnb6pqoa1p5m4Lz2D2rCQSaNJ19vrxxDCQZl06U6RB2WyiL8TQSAmZxhSiWt/2juUs
	DOlc/XbWn2c6HkUjXka01JcUeZlNMDKczUM1UW2/dDknaauLgo5HtLcy6+bC6oOwK09C2doCAUF
	fRjsXakT4epAZEXd+WO5Pj6c+ozEoON0JfWIyhczE/Sf1Ln
X-Received: by 2002:a05:693c:810e:b0:359:861:7cbd with SMTP id 5a478bee46e88-35908617e44mr23583050eec.10.1792131095475;
        Thu, 15 Oct 2026 23:11:35 -0700 (PDT)
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm3725600eec.4.2026.10.15.23.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:11:34 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Max Staudt <max@enpas.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] can: slcan: publish tty->disc_data only after register_candev()
Date: Fri, 16 Oct 2026 14:11:19 +0800
Message-ID: <afc724d533dc3e7d6d423a641ecb6ca5b40451f7.1792118038.git.chaosheng.qu.linux@gmail.com>
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

slcan_open() publishes the private structure to the tty layer before
registering the net_device:

	tty->disc_data = sl;

	err = register_candev(dev);
	if (err) {
		free_candev(dev);
		pr_err("can't register candev\n");
		return err;
	}

register_candev() fails with -ENOMEM from register_netdevice() when the
device name node or the kobject cannot be allocated. The error path then
frees the net_device and the slcan structure in its private area, while
tty->disc_data still points at the freed memory.

This is a regression from the 2022 rewrite. From the driver's addition in
2010 until then the error path cleared the pointer:

	err_free_chan:
		sl->tty = NULL;
		tty->disc_data = NULL;
		clear_bit(SLF_INUSE, &sl->flags);

Commit cfcb4465e992 ("can: slcan: remove legacy infrastructure") folded
that label away and dropped the tty->disc_data = NULL with it.

Publish the pointer only after the device is registered, so the error
path has nothing to unwind. ppp_async and nci_uart assign it the same
way; nci_uart was changed to that in commit fc27ab48904c ("NFC: nci:
uart: Set tty->disc_data only in success path").

The stale pointer is not observable today: tty_set_termios_ldisc() clears
tty->disc_data before .open() runs and again when a failed ldisc change
falls back, and the ldisc entry points are serialised against .open() by
tty_ldisc_ref() (async) and tty_ldisc_ref_wait() (syscall). The change
removes a trap for the next modification of these functions.

The success path was tested by attaching N_SLCAN to a pty under QEMU: the
ldisc opens, creates the net_device and SIOCGIFNAME returns its name. The
register_candev() failure path cannot be forced from userspace and is
only compile tested.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 drivers/net/can/slcan/slcan-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index c9414faafe66..fc6ecf110aab 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -849,7 +849,6 @@ static int slcan_open(struct tty_struct *tty)
 
 	/* Mark ldisc channel as alive */
 	sl->tty = tty;
-	tty->disc_data = sl;
 
 	err = register_candev(dev);
 	if (err) {
@@ -858,6 +857,8 @@ static int slcan_open(struct tty_struct *tty)
 		return err;
 	}
 
+	tty->disc_data = sl;
+
 	netdev_info(dev, "slcan on %s.\n", tty->name);
 	/* TTY layer expects 0 on success */
 	return 0;
-- 
2.43.0

