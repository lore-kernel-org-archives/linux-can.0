Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487418;
	b=gH4JtFhMs37j0R5Gjzyjy6dL+Bur0fn/NxtBbehKibOKQIzZ2wkigWiJNoeYAD2Qb5h/
	 YBCvIun0kDEYltEMToIO0Ost7LM+DXa1m9gPFcINNCxHv+9q1m1RMfK9XHWmoAYIZ8vz/
	 H2YiOE3hHn4g28o4ebyHSAcEARHn6fc3NZ1dywzlsTIGsSK2BczhtoOjTARKCNWc/GKiH
	 +h3kGzipsQ5Sp7tEAGwCFEhFvzFoVq8AoyJvIPlSfRqqMjDG0huj26zytOa6ILIGoXayh
	 YB9lpQNewSwk/AMGw1lMjDKG1WvFC3wGy7ilIUtYdzrjgUn57iM+rOz4yFQuvg1BudA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487418;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=t6f4NK2OKn/mbjCM0VqV3d8nJcMxOhTPDQofbd71OdU=;
	b=GfrtWGEoRCZ7Sg705Z9FCO1qY6ErPxBg2iWEkHDOwfBIJGGgSSBKej2/H1VSK7r/MPkf
	 CmgCZfkTmeLiD34lxu0j20+sGYO6rMEG7HqjgotLD0Iwz7DVecdqgitCV5Vb2GWllCPNX
	 PPPmT/ILOFioMk87DoGK0hPWWoyRiD6A7yXGywask+RLjuDRsialBQ8uS4C8Qf+issITL
	 JWnDHh+AGt36A6q0fIawHkiY4xAKuCgkroJlPm79aHCs8dhZ8Qu23b1ymgka5Zcqbg3I1
	 KMp3g8+Xg3aTAEzw4cZdfkQ8aKYrs45o5MaoI+DquPzuiIVF59nEQIbel8aTKAvbaDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cZt5xPZ4;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F0606A31D;
	Tue, 20 Oct 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cZt5xPZ4
Received: from [127.0.1.1] (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 14EE6780375;
	Tue, 20 Oct 2026 11:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792487416;
	bh=CXY9aS0FiFY086gIWa+qp0Nn0cj1Amx0kU6gGI3rh/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cZt5xPZ4qkiVtdscfOHYAycqmA2B4qlSKfY//XnhDjcCCfbRbqPpOqbGWI1qrB80P
	 /TU5KMy3oe8cISe3K/HOj5uYhc+yTSWCefU153zQrvVcUASQzQmh4KE9R/tsRRDmMx
	 8GHPR+k0DwgL4NJgVZA+QZeoST9OwcvCesWIpGncIcslqKexymX7jS7NwW0QWCH9Is
	 nBLycMIS4qIMJOg/zI2gIo89+Df04FGQnJ/ot8Jwh5ziwE2GyaFD3jyMyHZyr03J4m
	 Po1NzRs+c+FrEK4Uky2JWyy8od5UhmyhnBNI5XzTjqpGA+tiVyCllGD26JlcUJuuAi
	 qIcOoPsXPk1Yg==
From: =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
Date: Tue, 20 Oct 2026 11:08:14 +0200
Subject: [PATCH v3 09/10] can: peak_usb: unregister the netdev before
 dev_free() on probe failure
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
Message-Id: <20261020-canfd_check_channel_idx-v3-9-74d17c5a599e@peak-system.fr>
References: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
In-Reply-To: <20261020-canfd_check_channel_idx-v3-0-74d17c5a599e@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Dan Carpenter <error27@gmail.com>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

When the device fails to switch the CAN bus off after the channel has
been initialized, peak_usb_create_dev() calls dev_free() before
unregister_candev(). For the first channel of PCAN-USB FD and Pro
adapters, dev_free() releases the interface object shared by all
channels, and also the command buffer on PCAN-USB FD.

The netdev is registered before the channel is initialized, so it may
have been opened in the meantime. unregister_candev() then closes it,
which accesses the released interface object and, on PCAN-USB FD,
sends commands through the released command buffer.

Unregister the netdev first, as peak_usb_disconnect() does.

Fixes: a0b96b4a6274 ("drivers: net: fix memory leak in peak_usb_create_dev")
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 4c08656e7768..981168fead92 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -1039,8 +1039,13 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 	 */
 	peak_usb_stop_rx(dev->prev_siblings);
 
+	/* as in peak_usb_disconnect(), unregister the netdev before calling
+	 * dev_free(): closing it may still use what dev_free() releases.
+	 */
+	unregister_candev(netdev);
 	if (dev->adapter->dev_free)
 		dev->adapter->dev_free(dev);
+	goto lbl_restore_intf_data;
 
 lbl_unregister_candev:
 	unregister_candev(netdev);

-- 
2.53.0

