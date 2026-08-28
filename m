Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net [178.154.239.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9E3D3CF5
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899952; cv=none; b=id/W2KEQ2ZsPgWUf5UhF2OF73kEPIEqHE7wEcaoT6V0BRC38fr+gPIh/8taXwfPk72vn0XDRbbU2IwZBNB5QjCL2/3sQ02D5nNQfsaUxo3AmSg1H9nKESocV4QKDxhr/NfOGuPnB9ech6s9twNLk+E/3IdNBhvbBQc9yKSuonBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899952; c=relaxed/simple;
	bh=1FBVCvNITZITOOISyDQkTHfoJMvQq79ei2cugdX4Uq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3xckcwRz0Cup9tG1uKu7PPadJsdArEbNHu2dZa4gWblJARCC6pLZeh6ud4qdjVJagorz0f7tN7JECpTSjPObZa8VqzIglAu7ger2TYhxEcw775rK7bsrYXRzH5tBpFNLCdkt7V3elFNwLKDoYJbjulZzv4zvjulE+7MJ92hSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=tm4eIwEv; arc=none smtp.client-ip=178.154.239.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="tm4eIwEv"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward205b.mail.yandex.net (postfix) with ESMTPS id 39C2185BD1
	for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 09:46:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:25c9:0:640:b4bd:0])
	by forward101b.mail.yandex.net (postfix) with ESMTPS id 3B94FC00AC;
	Fri, 28 Aug 2026 09:46:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp) with ESMTPSA id UkYJTrHfKmI0-xDoQoBIL;
	Fri, 28 Aug 2026 09:46:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1787899592; bh=p406+D4NijetY0NjSPx6fwIySBXQIkx/u6SjCUj56sY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=tm4eIwEvQgL0+BOV62cNVW2mVZcavAhjefODxQfO2NqbBh+KWkC0O9uUQ3DjyqpY/
	 XAy8Ha612fcCl7Icqin4OIn6EvmtXsfnYEbHRg2Va0j06G/fOFkDxrF7mUO09U1VAr
	 drLtxow5znm3G3JlNx1E6IMTwpPUCJg0zC4U7ItY=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] can: j1939: cancel all pending ECUs on device stop
Date: Fri, 28 Aug 2026 09:46:21 +0300
Message-ID: <20260828064621.91364-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828064621.91364-1-dmantipov@yandex.ru>
References: <20260828064621.91364-1-dmantipov@yandex.ru>
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
latter (and ECU itself) is never freed.

Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: rebase on top of lockless hrtimer handler
    and asynchronous ECU freeing
v2: add extra precaution to avoid ABBA deadlock between
    j1939_ecu_cancel_all() and timer callbacks (Sashiko)
---
 net/can/j1939/bus.c        | 10 ++++++++++
 net/can/j1939/j1939-priv.h |  1 +
 net/can/j1939/main.c       |  1 +
 3 files changed, 12 insertions(+)

diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index a347594b8c1c..b021a77a0898 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -132,6 +132,16 @@ void j1939_ecu_timer_cancel(struct j1939_ecu *ecu)
 		j1939_ecu_put(ecu);
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
 static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
 {
 	struct j1939_ecu *ecu =
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 080d5b4c8c23..311d89f9b473 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -205,6 +205,7 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_priv *priv, name_t name);
 
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

