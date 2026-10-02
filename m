Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC02D3A75
	for <linux-can@vger.kernel.org>; Fri,  2 Oct 2026 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932920; cv=none; b=OWyozL+znqpCwjKtqXORJV3uiNq3DeulVVLpBWPo8dYCjenaOsw7ut+h2rfKP6xCBK4ycJQpbI9o+1BJxjd0DVHwDl1rn2HR5N/oeNrpgdOtyN3G4jtdWShG4FriL6ggbe5OstCdKf5AL6pCYmNmhaHpeCtDBETD5vbBnCyBMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932920; c=relaxed/simple;
	bh=Af81q8p2mBXYBfyIh0YwfWwOB3k4AXUfyrCyAbm+quY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVUy1V6NP46FSW/7kSSl4xF52JOCXuC2wgIZ4UzXcUC7QVVXwnjv3qc8kjgP7LAdeGIW7bCxww0wnrk/hX2r4dhAhre/GB2zDbS2je29UakZ6iE1I9ROOvAIs/st0J3Snz4rql6B1eh3sQok6CU4tdyxckUVlYSazLjRLaOPelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=w57SVrVt; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="w57SVrVt"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (postfix) with ESMTPS id 5CD8A85918
	for <linux-can@vger.kernel.org>; Fri, 02 Oct 2026 12:16:13 +0300 (MSK)
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward103a.mail.yandex.net (postfix) with ESMTPS id 075CC80F67
	for <linux-can@vger.kernel.org>; Fri, 02 Oct 2026 12:16:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2994:0:640:8f34:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id BC7B7C00A8;
	Fri, 02 Oct 2026 12:15:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (smtp) with ESMTPSA id tFhGd6OhHSw0-DYEq0fBx;
	Fri, 02 Oct 2026 12:15:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1790932556; bh=LQ0rM5YKQqez1D92VTcYVwcx6GvdXQZAmIueJJn39hc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=w57SVrVtEbpPDb5QshCwMsSVOuIo6T+9v0K/LZ/kN/nYOGRvydsWY/AoGqMRj1xcw
	 V6B4QWkoDoVwewIpQ3vdt3bazbKji6MGOFbR3736GAa8RGDmGh1N43vaiHLtZar/S8
	 qe/R6z054y/CMUTvoO99Lh+WzqRUJjI1dDQDyWH8=
Authentication-Results: mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Subject: [PATCH v4] can: j1939: cancel all pending ECUs on device stop
Date: Fri,  2 Oct 2026 12:15:52 +0300
Message-ID: <20261002091552.737529-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel all pending ECUs in j1939_netdev_stop(). This is needed
to prevent the case when stopped device no longer processes ECUs
and, since ECU holds the reference to 'struct j1939_priv', the
latter (and ECU itself) is never freed. Since hrtimer_cancel()
waits for timer callback, use hrtimer_try_to_cancel() to avoid
deadlock on 'priv->lock' between j1939_ecu_timer_handler() and
j1939_ecu_cancel_all().

Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v4: go back to simpler approach with hrtimer_try_to_cancel()
v3: rebase on top of experimental lockless hrtimer handler
    and asynchronous ECU freeing
v2: add extra precaution to avoid ABBA deadlock between
    j1939_ecu_cancel_all() and timer callbacks (Sashiko)
---
 net/can/j1939/bus.c        | 11 +++++++++++
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       |  1 +
 3 files changed, 13 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..0b5232b53605 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -96,6 +96,17 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 	write_unlock_bh(&ecu->priv->lock);
 }
 
+void j1939_ecu_cancel_all(struct j1939_priv *priv)
+{
+	struct j1939_ecu *ecu, *tmp;
+
+	write_lock_bh(&priv->lock);
+	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
+		if (hrtimer_try_to_cancel(&ecu->ac_timer) != -1)
+			j1939_ecu_put(ecu);
+	write_unlock_bh(&priv->lock);
+}
+
 void j1939_ecu_unmap_all(struct j1939_priv *priv)
 {
 	int i;
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index cf26352d1d8c..37a245ef9b73 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -204,6 +204,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
 void j1939_ecu_timer_start(struct j1939_ecu *ecu);
 void j1939_ecu_timer_cancel(struct j1939_ecu *ecu);
+void j1939_ecu_cancel_all(struct j1939_priv *priv);
 void j1939_ecu_unmap_all(struct j1939_priv *priv);
 
 struct j1939_priv *j1939_netdev_start(struct net_device *ndev);
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 5e5e6c228f22..1f68ba803700 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 
 void j1939_netdev_stop(struct j1939_priv *priv)
 {
+	j1939_ecu_cancel_all(priv);
 	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
 	j1939_priv_put(priv);
 }
-- 
2.55.0

