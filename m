Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=X28asFujcck1dSMyPdmwShi7t8gF1c2GyFn5ls1cB7ljn053U+0U8KRSJv90G8cIQ1pJ
	 KSPFM+bDOOp3J77kVXHTbp+kwsgxg8390keN7Ge4q/teftilb3r86FPRBTRQdTEYvBiZI
	 XcM2J1WU/LpOxNSLJ4Y3STn2r0T8JwLSkbZOGbJ2c93BGeAsMRiiCRkgYwk8xwFrZMLeE
	 5qA9CLFHIk6ehTpxlvVYSbH/ZgJVs40EnFoinRjDy+RRwZCBiCfKbnxaNtVP7BFmGvWE5
	 sEZe8niXltkw/73RfxYPmU+dsZDp7Ezrr4z2H3WRgoBk2tJL6a4nf+EmwZ3PUvoDMhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qbIT+/PtnlcqyUgHc1ohzRfyiRRDJs7QtTzw388UAIA=;
	b=QRPaTF18GXpKEvk8cySbNqiLngEKyg8KHbXIlPU0WQO17Yy4z0OTKrX7HfkBSMI8T/tj
	 cvNpUpmSDtXSHXsH/vBZFe8/vPwHduI5d/CAwktxHPazrDPCZI66uotcLL7oBD6PVNDut
	 gLPPyp36pqPHChycmhsoIaTdD4G6kr+KxZnOwOm1L6bejOjovoFPQIx/nVSCrFuC9QBUm
	 oyQgPsWv5+Nyv3zp7Pixj0EwMp92ujTNGz5XNwwrCb1k1NM/iDDNCnTKaG4idk2qlK+fy
	 NDE5Ou3OZkUzc3lqz2R+gGfxyrukwZLv5Oav8KF5n/wcMrMWbvmDtU73jhnKCgyvFDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=FSGvXAXz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Tc8jjhT6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569B606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E569B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=FSGvXAXz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Tc8jjhT6
ARC-Seal: i=1; a=rsa-sha256; t=1795727150; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j4g0OQhM7NsSzesdc99rJKX6Ha2zSG8vW68O88RMyaZJVlgqAyYFpQ0nlt764Jcjrj
    ol40ALN1t+64Zhvkl4bDaoEwzcuDfJmxyLSS7V557GKABC57yInlKUsFBT4NyIL34m1h
    HNPIqSXhH3N4J6K60w7PIIdwBlE61rk/Bz41UXgIgeWsgZenmPPbbb5yltdRZKBjfpSE
    epzHjpek8Q6y8OmEyVRd9HHbJC3zHYQK5WXZPaeWPzATMjXW4JNljmj/puxc/C2pSwPO
    /HD+ZKMBnNdnzChNNaQZ/k8Sb/XdGvX994mFLJi+6DQLUMJzOL7NyVOJemkGK9I0Zczy
    veGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qbIT+/PtnlcqyUgHc1ohzRfyiRRDJs7QtTzw388UAIA=;
    b=mDAYqZdBllidCVhH8aKTf4jX/dyIZP2MxaP4P2WzNjmK9UMQ7enjFzk9iZN1FQt6WI
    eloRpEIn5AgX+RO2TBterreEEi9TqjqVrgE/ResiK7tgpr8bD2K8SLksDTv7dl61Ip3I
    L9FtTqgqWOCQv1iPo49Ak9LpDaWAMPN6Q059V7UlJA1soZb4Wj42pVC/G6XKR0qJJrHO
    /Kq+3wQhbSyGbfizJvW81XhXAJtmp2KJvy1gPyd295zELqryU77fzH1o5Iw+px56+bGZ
    nq8s2yZs65JukL0YMk/ws99jdz9m6/h3ovqYhSZGKr/u/sYvZpshzB0hrbNikfIBbXik
    /RbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qbIT+/PtnlcqyUgHc1ohzRfyiRRDJs7QtTzw388UAIA=;
    b=FSGvXAXzbsyAxxY1Wun98Xox/fKuSwhEiH/WZQ2D4RdNb3IY/YU2o6GfT9kkMdniKT
    Uu5IJTd3N92AuDztoPVk0zZyzjoG5e4kAiPgVpwaFZZikfUkaNzE8cKE1e7QwEDDzlXU
    cuYuVpYNhB6icZxzBL6ue2ly2bNgqdI9LFhiNAdeN56klBhvnaEwxn+UyX89ro0h6MKY
    wKzPwDi5lzK9j4WDkysOY6IjxblXv91ynk+jFHSOcHXhsrV+2NO19YsXQC+eMozAp39q
    m21xcCG0o9zqOQlup/7kstqMtCQkndaIBUzgWJ8nsGC7Z/6gfFZMV4893Q9FHvm2i7C4
    plyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727150;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qbIT+/PtnlcqyUgHc1ohzRfyiRRDJs7QtTzw388UAIA=;
    b=Tc8jjhT6dp0R6bA+KhkWvSCU4qHmwM9ClwEfJoOzvcNuWgBYJPWhptxM47DeaOD0BL
    JR5ddo8ogWBLovDP0kAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5otUX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:43 +0100
Subject: [PATCH can-next 01/22] can: raw: read socket options under
 conf_lock in raw_getsockopt()
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-1-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=5179;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=UHPXtlOnOrh414o47THYmq92p/a2vqXaCXk/5ALPRqs=;
 b=QReqTv7KyN1D7lN6hjQTOVbkpKMsXpOf2XXoyeFzo+2h/ZH099Xu+cVSykd7E/wiS97eyIWjt
 /ggjHrA1fUEAKiyczgCZEawaKjf58Tf15tSfNXQ0uyAkajhWLWTGiyY
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

raw_getsockopt() only takes conf_lock for CAN_RAW_FILTER. All other
CAN_RAW socket options are read without the mutex, while
raw_setsockopt() updates them under conf_lock. CAN_RAW_XL_VCID_OPTS is
even copied to user space directly from the socket, so a concurrent
setsockopt() can lead to a mix of old and new values.

Read the option values under conf_lock into a local variable and copy
them to user space after mutex_unlock(), like raw_setsockopt() does it
in the other direction. So no user space access happens while the
mutex is held and a stalled copy can not block raw_notify() under RTNL.

CAN_RAW_FILTER is handled in front of the switch statement, as it takes
the mutex on its own for the duplication of the filters. Its code is
not changed.

The socket options have been read without a lock before commit
"can: raw: use a private mutex instead of lock_sock()" as well, so this
is no fix. As the only visible change, a failing copy to user space for
CAN_RAW_XL_VCID_OPTS now returns the clamped option length together
with -EFAULT, like the other socket options.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/raw.c | 64 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index b69eaadc5e93..cf1770432dad 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -101,11 +101,11 @@ struct raw_sock {
 	can_err_mask_t err_mask;
 	int count;                 /* number of active filters */
 	struct can_filter dfilter; /* default/single filter */
 	struct can_filter *filter; /* pointer to filter(s) */
 	struct uniqframe __percpu *uniq;
-	struct mutex conf_lock; /* protects bind, filters and setsockopt */
+	struct mutex conf_lock; /* protects bind, filters and sockopts */
 };
 
 static LIST_HEAD(raw_notifier_list);
 static DEFINE_SPINLOCK(raw_notifier_lock);
 static struct raw_sock *raw_busy_notifier;
@@ -817,24 +817,26 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 static int raw_getsockopt(struct socket *sock, int level, int optname,
 			  sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct raw_sock *ro = raw_sk(sk);
-	int flag;
+	union {
+		can_err_mask_t err_mask;
+		int flag;
+		struct can_raw_vcid_options vcid_opts;
+	} val;
 	int len;
-	void *val;
+	int err = 0;
 
 	if (level != SOL_CAN_RAW)
 		return -EINVAL;
 	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
-	switch (optname) {
-	case CAN_RAW_FILTER: {
+	if (optname == CAN_RAW_FILTER) {
 		struct can_filter *filter = NULL;
-		int err = 0;
 
 		mutex_lock(&ro->conf_lock);
 		if (ro->count > 0) {
 			int fsize = ro->count * sizeof(struct can_filter);
 
@@ -864,76 +866,76 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
 
 		if (!err)
 			opt->optlen = len;
 		return err;
 	}
+
+	/* Read the option value under ro->conf_lock and copy it to user
+	 * space after mutex_unlock(), see raw_setsockopt().
+	 */
+	mutex_lock(&ro->conf_lock);
+
+	switch (optname) {
 	case CAN_RAW_ERR_FILTER:
 		if (len > sizeof(can_err_mask_t))
 			len = sizeof(can_err_mask_t);
-		val = &ro->err_mask;
+		val.err_mask = ro->err_mask;
 		break;
 
 	case CAN_RAW_LOOPBACK:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		flag = ro->loopback;
-		val = &flag;
+		val.flag = ro->loopback;
 		break;
 
 	case CAN_RAW_RECV_OWN_MSGS:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		flag = ro->recv_own_msgs;
-		val = &flag;
+		val.flag = ro->recv_own_msgs;
 		break;
 
 	case CAN_RAW_FD_FRAMES:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		flag = ro->fd_frames;
-		val = &flag;
+		val.flag = ro->fd_frames;
 		break;
 
 	case CAN_RAW_XL_FRAMES:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		flag = ro->xl_frames;
-		val = &flag;
+		val.flag = ro->xl_frames;
 		break;
 
-	case CAN_RAW_XL_VCID_OPTS: {
-		int err = 0;
-
+	case CAN_RAW_XL_VCID_OPTS:
 		/* user space buffer to small for VCID opts? */
 		if (len < sizeof(ro->raw_vcid_opts)) {
 			/* return -ERANGE and needed space in optlen */
 			err = -ERANGE;
 			opt->optlen = sizeof(ro->raw_vcid_opts);
 		} else {
-			if (len > sizeof(ro->raw_vcid_opts))
-				len = sizeof(ro->raw_vcid_opts);
-			if (copy_to_iter(&ro->raw_vcid_opts, len,
-					 &opt->iter_out) != len)
-				err = -EFAULT;
+			len = sizeof(ro->raw_vcid_opts);
+			val.vcid_opts = ro->raw_vcid_opts;
 		}
-		if (!err)
-			opt->optlen = len;
-		return err;
-	}
+		break;
+
 	case CAN_RAW_JOIN_FILTERS:
 		if (len > sizeof(int))
 			len = sizeof(int);
-		flag = ro->join_filters;
-		val = &flag;
+		val.flag = ro->join_filters;
 		break;
 
 	default:
-		return -ENOPROTOOPT;
+		err = -ENOPROTOOPT;
 	}
 
+	mutex_unlock(&ro->conf_lock);
+
+	if (err)
+		return err;
+
 	opt->optlen = len;
-	if (copy_to_iter(val, len, &opt->iter_out) != len)
+	if (copy_to_iter(&val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
 
 static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)

-- 
2.53.0

