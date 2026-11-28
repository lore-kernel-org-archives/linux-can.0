Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795874126;
	b=TQ+9lz1mCTSksfXW91C5y/69nFvX7Vf14LVGaqfeLiDVZTqsxMBVNyv2R8cKqbRQU3H4
	 iz0//MOz4F1wkJKuHwAHkwd5vrL20Ks9Y3/KDaSJGA+ZlrobTdIh2DGWWCvvxQD0UuuLr
	 tubhl2w7D2hMOjXBxnwo0NQ97F3y5Grr/2NXPREpOcwKJ+CUxzIWJseVBrJb15No//uP8
	 jgY5/k93tuLs0VJUxEkLomMZvBO5jneBZayZhsaEIz+SCjgZ9zQUi6SgrHxs1LeE8NlZ0
	 UvBbVVZhwYietBXkCHnullotgwU9hFbhzTQ31ptVLvkZt50XS/PSXPl7+7hE4iIjsOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795874126;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=CdOPsbTjQrKbED2zSlgJ4BoYOndFbZvsrc4lvxNiyjI=;
	b=EASNqw6dRfdPGLaEpb24e3vcJhgJN4BQ9qPdkmB/bftcb6WPlo/PjsDt5iEUCi0es56R
	 ROVYm9O07PPnHNoXNusHpdDUXyAJNCMwahfHAq9xAJl5eBPGi6XHuWQ7zjn7JokD85J0k
	 lDXWC5qitX3eqwYqMWDT0+mVAr15jafDZmndnoV3nDelzHPnaUwcjP1i3IlvXhS9qE6xO
	 Tdezft61CyHx/Y55GAfphNysTj9Fr1/iF2z2nm+tkpLFqWJ9v5Z46NVuYri4D0qR7g3EN
	 f7gKhMAP3uu8aJJ4ia1qSpBjwoTd8os2ewOlnlRkqQAej44voEmsulWq6ok18LiaFVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BPb67w6S;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C2606A31F
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 13:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554C2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BPb67w6S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Cd
	OPsbTjQrKbED2zSlgJ4BoYOndFbZvsrc4lvxNiyjI=; b=BPb67w6S4Kp5d+w2d6
	h+bWWII9ZrGm/8TEAHuqnzgjiR4mipivXrHLRG12ikSi5tWhC+97cBB3kdkr6uVG
	3RF+0wX3pD8fwOcU56nBnh/ENJULnSAxGPK5HN4TS0m6yrt69KrbKvVrq+4WXY5d
	Pa3+JSwBeVBT5Pif4mHz0XIK0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn7+st3Qprj2TyLg--.61490S2;
	Sat, 28 Nov 2026 21:54:55 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mailhol@kernel.org,
	mkl@pengutronix.de
Cc: linux-can@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] can: etas_es58x: fix devlink leak on probe failure
Date: Sat, 28 Nov 2026 21:54:23 +0800
Message-Id: <20261128135423.1298105-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wDn7+st3Qprj2TyLg--.61490S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4fuFyxXFW8tr4UuF4kZwb_yoWkXFX_C3
	y0vrWUJF18Cr90kw15WF13ZF1Ykr10qr1xZanYqF15JFy7tr1kAr1a9FZ7CrsrWw47ZFZx
	Wrn2vFyxu3y8GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMMa0UUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7g-fTmsK3S94BAAA3f

If es58x_init_netdev() fails, es58x_probe() frees the CAN network
devices but leaves the devlink instance registered and allocated.
Unregister the devlink instance before removing its ports, then free
it and clear the interface data before returning the probe error.

Fixes: 2c4a1efcf6ab ("can: etas_es58x: add devlink support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index e1724ae79c5a..36ec4cd87434 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2238,7 +2238,10 @@ static int es58x_probe(struct usb_interface *intf,
 		int ret = es58x_init_netdev(es58x_dev, ch_idx);
 
 		if (ret) {
+			devlink_unregister(priv_to_devlink(es58x_dev));
 			es58x_free_netdevs(es58x_dev);
+			devlink_free(priv_to_devlink(es58x_dev));
+			usb_set_intfdata(intf, NULL);
 			return ret;
 		}
 	}
-- 
2.25.1

