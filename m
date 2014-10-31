From: =?UTF-8?q?Thomas=20K=C3=B6rper?= <thomas.koerper@esd.eu>
Subject: [PATCH 1/1] can: Avoid calling kfree_skb from interrupt context
Date: Fri, 31 Oct 2014 07:33:54 +0100
Message-ID: <1414737234-31132-1-git-send-email-thomas.koerper@esd.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu02.htp-tel.de ([81.14.242.9]:58661 "EHLO mxuout02.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272AbaJaGfA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 Oct 2014 02:35:00 -0400
Received: from mxuin02.htp-tel.de (a81-14-242-29.net-htp.de [81.14.242.29])
        by mxuout02.htp-tel.de with ESMTP id s9V6Yvkh013230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-can@vger.kernel.org>; Fri, 31 Oct 2014 07:34:57 +0100 (CET)
Received: from esd-s3.esd.eu (a81-14-225-174.net-htp.de [81.14.225.174])
        by mxuin02.htp-tel.de with ESMTP id s9V6Yr2M009477
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
        for <linux-can@vger.kernel.org>; Fri, 31 Oct 2014 07:34:56 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20K=C3=B6rper?= <thomas.koerper@esd.eu>

Called in can_free_echo_skb, which might be called from (TX Error) inte=
rrupt.

Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
---
 drivers/net/can/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
index 9f91fcb..6403503 100644
--- a/drivers/net/can/dev.c
+++ b/drivers/net/can/dev.c
@@ -383,7 +383,7 @@ void can_free_echo_skb(struct net_device *dev, unsi=
gned int idx)
 	BUG_ON(idx >=3D priv->echo_skb_max);
=20
 	if (priv->echo_skb[idx]) {
-		kfree_skb(priv->echo_skb[idx]);
+		dev_kfree_skb_any(priv->echo_skb[idx]);
 		priv->echo_skb[idx] =3D NULL;
 	}
 }
--=20
1.9.1

