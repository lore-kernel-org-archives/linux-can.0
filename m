Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126298;
	b=toQTKP6G6X35ufCqs5FeYRt9sWRT4yEMyZPzUEk+LZItmYuz2MeS69k0IChpRQ7etVav
	 TIxW+GUIBqJjuStmfMMxiyTKoxPRs4HpIZ1IKY5z5vjVR1m0uNqE2lyQiuXA5YjQVvHeR
	 Knj+RO0oY3cOrAKE/Jt5WNxBqIbFNX25NHiyHIdJSiQZAGcVsv1K4Z/SHoNC2RfAj6An8
	 tcb1xN8xmQJ/J+qpH+5lJ6n9Y6g2Dz5nOGhXZ0KUR9G7OsiBdosJAlnzMP52Lkjwg8NcZ
	 kICP9nfjOdBr32lS+qonIpFGyMZPkbwafWi1WiAjk0T0RqivtbJ0FxkYOvWM+JLW5UA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CosGVvt2CFhbJGF8LKSyr6FEGQYKrEZ7d9e2WA/T6n0=;
	b=T+FIzQlvG4tSLsKN0OvLCjHFrk+Vv4CYkvh7SzE6moggofORTcWLI35ot73aTyY27lNx
	 yE8ddlEkKhFKfIKLK6wrihQFfwwE3QvQEwLo8lLN9LSXtJ1D1puAc9HA8otwnUJ78odIL
	 xJ1QWe2VHdy83U8dPhvNxWdyrUVdk7Gqxcn3mJzQZG47Jc+tG7wfSYxlNuMdKJ69Xh5DX
	 lPVKH9I2Iy8+8DgW7H7Hfr9geKi8chhC1Ra5WHIPqoSKeK89hmaa6xav9fcJa/xOcEOSM
	 vzxyFBWwIjsSK59jhQqfcqf7fqJLSyTVnlHmONAE16dcomlpEGfPy6n3OwoN1SqKNvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="K/We5wzE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE34606A332;
	Thu, 19 Nov 2026 22:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE34606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=K/We5wzE
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5D7B2205B41;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CosGVvt2CFhbJGF8LKSyr6FEGQYKrEZ7d9e2WA/T6n0=;
	b=K/We5wzE3Jk4XrxQwfPhlw3Rgzec1x/m4XlG+y/9tcdEO5s1SK2L6I8o50Eq0r9EfqYIZV
	vDPuIOn1XWAhU2J9SBLGoT516wDPHDfUr3L96S+YPDeoyrdAHIaWNe+1JrtzcK6CNzgVww
	xuwqKp3WClwTKuVqdDfmITFr08IZFf10AFDfIRmYhx77DzKnJYnZHc6q/Rf9rxWFnN12aC
	IVtSw3X6oX8OKuZBnLlCoBraDIaxZCNquoRyEUR6trJLOJP2IAZyWbino2Ewe/gtPyzhGb
	dIOhyNMHDGjl8tuWRTF/jHek61NE5lI5MAXl5FeZhFj4CcvqwxPLJ3XEDzU/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CosGVvt2CFhbJGF8LKSyr6FEGQYKrEZ7d9e2WA/T6n0=;
	b=THEwb1FW1svEgsx2q8cwLiFVP/wl0n3XX+BLa9T874rNWHziT19SUlU5zTOJDai8bi07gB
	bqQDG/XNZttOwLxXacq14YuYmTusrjEZc8HRa/lPigp4e7ZgiGFB+olvS3uq0NYedDyafS
	B0kMSwpp5iA6899CheTiWAvJHiJBixU2NFwwLcw9Yb+Kh4T15GU+Iy0bj1Wq9n80XqhI0F
	5wjKKjSkzn2NID6lk+a68qq4VxN3+aQWC0a6O/VpuI9x2R1WK20D/MeZlzmSe18MoOu8sN
	i7vzfPk9PFjggINhWAC7MpQElv9lNojYhvb+lCBwsBOMCepz9OyHvEbF3ICszg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=HY+wvu7CDBuKOwzom3n17sjCf4cMYGg72myBU3sxcIf7reF59lini2Wyg5RgV79x068HmR
	KOZ3UcHs7dhbZrjkUwlzDH8nFLdYOpxsecY+8NSDsig5mFijNwrmWJ8Ap9JAeGGy4ywslQ
	8RAVejRtwCb/5N3jc7Opw4qK9lOko2J4mdSVWZylAbpwW9S65uTCFcfZAzAwt6lIG2pVky
	DuwHEuEKm6zjOJRIUH4pzZI5C2nXSQ3l6tbKOUoFBqJvJE/m70TXaC5w7+uFNShJtxYaEM
	+c5wlFFo2cNFiNM8HWCJsvpSgheKAXJvjGOLU+KJie7DZP59cFhPw5vqQ9jcwQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z6G-2I;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F36935F099C;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 09/13] can: janz-ican3: don't discard the IRQ lookup error in probe
Date: Thu, 19 Nov 2026 22:58:45 +0100
Message-ID: <20261119220936.155728-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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

From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>

This is a robustness and consistency cleanup, this issue has not been seen
on real hardware.

ican3_probe() collapses every failure of platform_get_irq() into
-ENODEV:

	mod->irq = platform_get_irq(pdev, 0);
	if (mod->irq < 0) {
		ret = -ENODEV;
		goto out_free_ndev;
	}

Return the lookup error unchanged, as the neighbouring CAN platform drivers
do, e.g. commit ("can: cc770: don't discard the IRQ lookup error in
probe").

This driver cannot see -EPROBE_DEFER and the change does not fix a
deferred probe. The device is an MFD child of janz-cmodio, which takes
the interrupt from the carrier board's PCI device, and the driver has
neither an of_match_table nor an ACPI match. The probe should not invent
an error code for a lookup that failed for another reason.

Build tested on x86_64.

Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Link: https://patch.msgid.link/28add8d0570b72d35c65c19b2365007cf0aa15c3.1792118040.git.chaosheng.qu.linux@gmail.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/janz-ican3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 1efdd1fd8caa..a65326b0f11e 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1944,7 +1944,7 @@ static int ican3_probe(struct platform_device *pdev)
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
 	if (mod->irq < 0) {
-		ret = -ENODEV;
+		ret = mod->irq;
 		goto out_free_ndev;
 	}
 
-- 
2.53.0

