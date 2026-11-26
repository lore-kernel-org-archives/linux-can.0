Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727159;
	b=VspGSiaj/GDGk35ik/eTGbp4AmiWETB8JrcoMe3xdVy4KEf+gU+5vaI4MFgJKpUTiyJp
	 6cn04zdIdUDnDWdW4dpRxvx/M05tOMp2YdibIKbc/hB3GjoBSgdGdvBuCfRyILk/ZSjKb
	 lHiSU5/4Qga/SeNjAHYy1NFG2EmIx1P7vbRviHOecIL+sdw/ATq9MALPlIoaHtQszhG/K
	 ao1CT2z9qVyhx81+3D8EBWS/9pikGfvwDi/BECYMNb6JzjC8MVdM2VPuXhXGikOmvrs0V
	 ELEdztigSXr9qTE7ZB8S9xsXnja4tLbZxHoyciu/439s1/NINmEy0lLKZOz4Uc4Edmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727159;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wocQoPAps0JOc5F1dwrA4h+qo+ZNhYWhH8KGGsGUypc=;
	b=nbtpLdXmaloffgUX4bY7gNQxHKcanEL4Tma7IQ9bg5yGb3Wu8TFcej6HwiggfJc2hC0R
	 YL+BdV5yF9mhY9n4DwVdvZICEd5K6NGBiGb4nA/olWW8czfMb/0GkNCTLrKjY6mK9yAgl
	 hrp2dycJm/Uv7jvIcS76+boOOVYp5tlBKlES2tppZU3qlZs2NI98Hl4YVvxl1FNGKGDJ2
	 tEfX6KSGWX+YXNoOgk4vEa+/shVZcGZmGlA1xUI1i0yHBdd+Wd9DZ4XrIidbxkKz4Zwvg
	 E9tN+XDEhmrRcVcv4B+6bBTkRY/r2nD0SK/p6QQNa5zmzD8lgLAebQJv6xrxU872Kfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qEX7u0Dv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=I2QTHSgj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFD606A31E
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CFD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=qEX7u0Dv;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=I2QTHSgj
ARC-Seal: i=1; a=rsa-sha256; t=1795727150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YhMwI1QSQHCnm9QyWckVhLakZTgvUzIYCsUnsnhtMfUAnXMv/qBimYE+1/4MoSkTdz
    BMJ4JHA1WSpe8xceSFZ8VuHNDkhKHD/uJ0wRxg5MEj6GiXJZiz+nizh+OSc+DFUOaj/e
    KKzDD6cZ/hldccJaZEyyAgYh7Nfv8gM4nB7qmw2Wa/Rmye+vkBe37pvPwxNi1pNnk1Jq
    scF5HJkYIGbldld/TORnpONl6Ptte3Q5TK8him3QHCYkk6JRGb+TB1vvkC9bw5qsMG9R
    TzqV7nRQa6dk+qAuBewhPLOVzLv/jURpMDDldhI64eQUrtJLrlsUiIY0PhEhUK+efvKZ
    zXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wocQoPAps0JOc5F1dwrA4h+qo+ZNhYWhH8KGGsGUypc=;
    b=bwJll1XpfDE085rNlTtHzXoJqR7zROoSPsgpIEqGOnh7yMlhyA89y57qIpB7MICixH
    MZ8pLPe3TThmkuQ3Yd9Anwf0n0aJR6WzdiZo1G5uJs1G6BE6z6QOBbeLb73knCOChdY9
    SLzLTeUuB+vTV4LadQ9u0xsJ6DtQUTfHYHzRXk3H1fDrhMYOA3gLnR9uoYazNFHg4N2H
    qivIPchmuCyVZfiKBq3FRjmb+uZMf2XXAz3DtY80okfnpV+LOjdzxlHrYVsBDZPZKx7+
    8zt2zW/fwWfYeVsOXmFEvaNILXpGN517uz2Z7nf2spHdgbEY4XIwKQ7rik1Jq9+VNZFs
    XsGQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wocQoPAps0JOc5F1dwrA4h+qo+ZNhYWhH8KGGsGUypc=;
    b=qEX7u0DvzfBenZktfcyU4RvVTtxl5Uc0HS5KVnm3WVcERz1Pi8on0f0XJcjViN7iTU
    vBlarWXz8vIks3o+lnVazBlwJGg8TFSncJoXESep3Q4Btkp2ARg5cbs5qsF9lB2mwRyW
    eTpmmJKzrVocgnkcu3J1Ibye0E0U+k3B+bCAEMvaDfNlvSBtIUlABZ3snEk1cqihNaVI
    LyxZoPwDgzbefaM18QLn9IcOfsaY9Qkv3CrmKhtm05oSaRLVcaxd3wZ6KxJBkKpql3+b
    AOJOoGLvnf6idbIANeohvN9kE2vAhipe+N30D/Z6xlJpnAAzVXmlU5LzpNQRDwB2J2f+
    reCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wocQoPAps0JOc5F1dwrA4h+qo+ZNhYWhH8KGGsGUypc=;
    b=I2QTHSgj1Mx3/ANv1Vx8pKau+dPi0E2SH8/0Cd3XDgX62DPkl29LOXWCaLRU81yyE3
    UziVAJGproEuFtjs85Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5otUY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:44 +0100
Subject: [PATCH can-next 02/22] can: isotp: read socket options under
 conf_lock in isotp_getsockopt()
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-getsockopt-memcg-isotp-v1-2-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=3584;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=OvgMeXosGEkafPPE5sxu1RvDRCrMM7WvhEWKSgjk5t0=;
 b=O/iJlwwq+GHFU4mECp/cU2IvDlql+IjYVA8NGQrZSuF+zjyuUJgfAcAxMdb5UOMGQrIWq0HZM
 WdKk6Z3STVcAlsRMauOqZl/EAaGfe6FSuan7cvx7PNNttuJvOQ3gciM
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_getsockopt() copies the CAN_ISOTP socket options to user space
directly from the socket without taking conf_lock, while
isotp_setsockopt() updates them under conf_lock. For the options that
consist of several values, i.e. CAN_ISOTP_OPTS, CAN_ISOTP_RECV_FC and
CAN_ISOTP_LL_OPTS, a concurrent setsockopt() can lead to a mix of old
and new values.

Read the option values under conf_lock into a local variable and copy
them to user space after mutex_unlock(), like isotp_setsockopt() does
it in the other direction. So no user space access happens while the
mutex is held and a stalled copy can not block isotp_notify() under
RTNL.

The socket options have been read without a lock before commit
"can: isotp: use a private mutex instead of lock_sock()" as well, so
this is no fix.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 642fec500af9..98a7e489ca3e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -180,11 +180,11 @@ struct isotp_sock {
 	u32 tx_result[ISOTP_TX_RESULT_SLOTS]; /* per-generation result slots */
 	struct tpcon rx, tx;
 	struct list_head notifier;
 	wait_queue_head_t wait;
 	spinlock_t rx_lock; /* protect single thread state machine */
-	struct mutex conf_lock; /* protects bind and setsockopt */
+	struct mutex conf_lock; /* protects bind and sockopts */
 };
 
 static LIST_HEAD(isotp_notifier_list);
 static DEFINE_SPINLOCK(isotp_notifier_lock);
 static struct isotp_sock *isotp_busy_notifier;
@@ -1860,53 +1860,69 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
 			    char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
+	union {
+		struct can_isotp_options opt;
+		struct can_isotp_fc_options rxfc;
+		struct can_isotp_ll_options ll;
+		u32 stmin;
+	} val;
 	int len;
-	void *val;
+	int err = 0;
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
 	if (get_user(len, optlen))
 		return -EFAULT;
 	if (len < 0)
 		return -EINVAL;
 
+	/* Read the option value under so->conf_lock and copy it to user
+	 * space after mutex_unlock(), see isotp_setsockopt().
+	 */
+	mutex_lock(&so->conf_lock);
+
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		len = min_t(int, len, sizeof(struct can_isotp_options));
-		val = &so->opt;
+		val.opt = so->opt;
 		break;
 
 	case CAN_ISOTP_RECV_FC:
 		len = min_t(int, len, sizeof(struct can_isotp_fc_options));
-		val = &so->rxfc;
+		val.rxfc = so->rxfc;
 		break;
 
 	case CAN_ISOTP_TX_STMIN:
 		len = min_t(int, len, sizeof(u32));
-		val = &so->force_tx_stmin;
+		val.stmin = so->force_tx_stmin;
 		break;
 
 	case CAN_ISOTP_RX_STMIN:
 		len = min_t(int, len, sizeof(u32));
-		val = &so->force_rx_stmin;
+		val.stmin = so->force_rx_stmin;
 		break;
 
 	case CAN_ISOTP_LL_OPTS:
 		len = min_t(int, len, sizeof(struct can_isotp_ll_options));
-		val = &so->ll;
+		val.ll = so->ll;
 		break;
 
 	default:
-		return -ENOPROTOOPT;
+		err = -ENOPROTOOPT;
 	}
 
+	mutex_unlock(&so->conf_lock);
+
+	if (err)
+		return err;
+
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, val, len))
+	if (copy_to_user(optval, &val, len))
 		return -EFAULT;
 	return 0;
 }
 
 static void isotp_notify(struct isotp_sock *so, unsigned long msg,

-- 
2.53.0

