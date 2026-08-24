Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C3370D57
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586882; cv=none; b=uKIlXVuJtOjsklaDBjW1gCtyJ8Cp1txsd1VZAY0wsRe5Ozlix9g7Z72AzqNgbJ8xYziCx87ibn43KtgPOXUG6aMkDqW1bDnHndoBCkH+FInp+4r6oc0doNez0C0V3pVMj5tP/IcQlGAsb8U+bR92mIsRJwe6Cv6r4uOeyqJrsv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586882; c=relaxed/simple;
	bh=yAvnRQyIPvA54bmvsYKKwhQKK4BNthe9HXj476db3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEyyefTjy9n+6HM5WZe7P/7RDv2sT5350YOeWVvsG1X2XWlBR5VV0HN02RJCJdt3Ow9PkvXr1g8VdhIA1MO3ODwHaGgbnckveFJAlcjt3gzhvC2FVpajJafdAw5AbpeGlMvFKCeekYeFR4/BX6auDjYixu9jDpVDoBxFisB8lXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=inp2k25G; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="inp2k25G"
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:340d:0:640:ad51:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id DB04080ED3;
	Mon, 24 Aug 2026 18:54:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp) with ESMTPSA id XsdEgXsf7eA0-SR7oE8dr;
	Mon, 24 Aug 2026 18:54:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787586875; bh=L72NSXK77MjiwvMh/bmR7dsD6sMGDhRYVY397cKNHg8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=inp2k25Gyzq+99+bwLiAEhf4pXp+Kx6y+skooSYB9Y1jXjN2OrqcU7pGHLiA+5CBU
	 GuSS6j7OWGjpTw6VtHURyXoLGM5U1gcM/XrjlhE73VNS7uxsyotQLxj24QbKqBKr/8
	 SW5pUYmU8SQiNqsff9PGKz/Ip/QGnxY3ey6iTmQo=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Subject: [PATCH] can: j1939: cancel all pending ECUs on device stop
Date: Mon, 24 Aug 2026 18:54:06 +0300
Message-ID: <20260824155406.246942-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cancel all pending ECUs in 'j1939_netdev_stop()'. This is needed
to prevent the case when stopped device no longer processes ECUs
and, since ECU holds the reference to 'struct j1939_priv', the
latter (and ECU itself) is never freed.

Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/can/j1939/bus.c        | 10 ++++++++++
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       |  1 +
 3 files changed, 12 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index cdc3c0a71937..a180bbdb3790 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -96,6 +96,16 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
 	write_unlock_bh(&ecu->priv->lock);
 }
 
+void j1939_ecu_cancel_all(struct j1939_priv *priv)
+{
+	struct j1939_ecu *ecu, *tmp;
+
+	write_lock_bh(&priv->lock);
+	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
+		j1939_ecu_timer_cancel(ecu);
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

