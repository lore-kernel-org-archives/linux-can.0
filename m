Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681406;
	b=3vc9/Rs24zLzG+rYAngsFidDfWkUkgbhBFygQCKWEUufIdq0EVXR3opfEuBpXcV3jStu
	 4316ryUqqWU5kovnwN4XOkR52fCUhJherGQ0VVXULp7rtPYdcisDbX+xqdiEm9Gh2lVJe
	 R5ob7s+XV4hbyNUEHhxR/M7XaksaPxwL9O33LVCZFuxNmvikZZe/CnKi+BL/kcFpooltb
	 mykj/IDK5y4VsvtUGR7VODoCpp2UCumouBELiXpNOrDoHYgTAD7Mga1/wPx4mkLMAD6fV
	 HGV5z9B8lhCfmZQgQEoRly/4rtRHFZ/BBidmu+GkwjQDIuXpXmpTzf0ctToYVmL2Wew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681406;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LQ0rM5YKQqez1D92VTcYVwcx6GvdXQZAmIueJJn39hc=;
	b=b4URk9BdMpPEPAqF+AWnBGyXJj/E+4DCTqeWDd5i+1IKNT3nX+fhbEPOHx4wffDOt2Ga
	 JwtrrMDLV5EneRBYr7c5s8bjuB7QpchcWO0IRVSkOH5aedVSVh/gPPZCJNwjGTNJ82QeE
	 aFOMJGWcxjamcq8h9Uj2x0N1bW6bFv159zW3/HbFX4mRv8tNXF0oCErZBiLPoqKYqlcFI
	 4CJjpSedoXFnuitO0VxrVXQHVb5Zbdws5zrdd99b/aB0cyeQB9jWlQTd1ArICHDgF5o8t
	 11NPs1s0wJfUZj0fr5UOZYFamu9+AvtrYLLgfWVvMclxwX3q1iWTRaip/e5hmv6S8fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=gKcdffzF;
	arc=none smtp.remote-ip=51.250.60.164
Received: from forward104d.mail.yandex.net (forward104d.mail.yandex.net [51.250.60.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F5606A339
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 08:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C9F5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=gKcdffzF
Received: from mail-nwsmtp-smtp-production-main-80 (mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net)
	by forward104d.mail.yandex.net (postfix) with ESMTPS id 6E963C0014;
	Thu, 26 Nov 2026 11:23:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80 with ESMTPSA id 8NdIChNWr4Y0-0EQk2YiZ;
	Thu, 26 Nov 2026 11:23:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795681390; bh=LQ0rM5YKQqez1D92VTcYVwcx6GvdXQZAmIueJJn39hc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=gKcdffzFST1ejLxICuD2Whsum6T0jcc9M7hrSKm1lSn3OOUMzviVyMYEK+/RsZEJH
	 Z0qw5vul5IscqNBJygw/vi46PwJ+GRnodJlm/paJivkrpEnaKHnoHyuN3iDnOxw7zb
	 dRuC6sESq2g5OSawHy+6rkLAJm+FrRfmZa7pCsX0=
Authentication-Results: mail-nwsmtp-smtp-production-main-80; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
Subject: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device stop
Date: Thu, 26 Nov 2026 11:22:57 +0300
Message-ID: <20261126082257.491041-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
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

