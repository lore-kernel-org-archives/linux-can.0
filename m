Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174154;
	b=RFMV7BmrZj0oNI5LfGyeT5hpmfMleP24ZjX0KceNsQRFpiJYz0oOOfhhn8giEnavOO9I
	 HmToalyJk9IgraKTWAeeBF2Ng+kKvcmGr0BlQapULDyAx61JoVvtEXZZBogaDqbs3+Eao
	 nztJFiAWBOCGlWKhV/W5UJxUx57bq3ezMi+yfCt5kpoTSrLtwEfuZjzS5pmrs+xWYWWHX
	 jtt6JETcX7Jq6VaU/T6/cc9997y9L4ashsSPbTHdAwmoX+V+ExP/6K9D7Fwn6QhINQuW/
	 SXEYOHD7V3RH3kg9DWWvCyR6MpkhNDutjTW8Q+bU1jniHYNRMNiM+dOmGQil9lkrsVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174154;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QNIGQta0aFr01M6Fluh44BH18zsVVLGH2QQuBe4pAN8=;
	b=bpVNj47wUn9Gpf2On0tf78tvqJWKy3ifINJI9f5z7t779Iyki6yfXBkejbupNHkgviHm
	 ne3GSjpik14vJ6oPV0FuJeI9x6c+uXLMg+f00tWMEk3EriYx5avQmq5+mHuL33cRoYPTa
	 RPy0O0W/zaoUP09/ZYllrDs14+XBWEcOpDOxC8uFzDdiAt5DdYq3E8VAXmEqVGkqLh5/0
	 cMdJlSwqRJKXtwksL+2YcDa596uywyehs9Xzvkz/mRBW71ZzGHmy5SwkGVdKAWmc5torj
	 nVIM9Dlj+7bfJf43FjgEufnBSRs8D+t/6gD8mEkbJ4fiRFnt4q80LYjHtYlhfdO53Xg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rV6x3tBh;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=URXBgCJB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE80606A338
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE80606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rV6x3tBh;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=URXBgCJB
ARC-Seal: i=1; a=rsa-sha256; t=1795174143; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qM3b46HawgtPaGfAgt/R181VBSPx5Tlt4w+BYL4Vlxdux1zAs38KBub6H2rwHr3CPj
    KJBWEX9Ca+gzcgt26mStuM47CtZEL1LAkMnSQl5ZjMVZh8ZIUfrPJiHZ+n9N+5DK7IPA
    HAz0pf4AaTmUztwEMX6HmkDJwKFUTPZ+k3JnTlrjGWYYywmjH4ygW/B3siDGSXgjSxy/
    mEFsX6oOpfsEMty6uMJ3qSaQvmAXeDOiUcvu2kGxmaCmleYobtIctDpU+uwdg4/9Ehto
    oGyJYfGFLlGX+eMoDAt/ghMhtTym3YqfgvOOCSwGoaXCs55CccY/WM9z+4V/GQcTT6Mr
    N8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=QNIGQta0aFr01M6Fluh44BH18zsVVLGH2QQuBe4pAN8=;
    b=HYslUZPwg5/K8W00vWPz8TmLfz3urefSAd5FG1sUrle1Gq8LEzpmxdWUlqTCe+ASRZ
    9QWOUm/p/QvcnCpKFt9Kh1BXnTNww9ptPviXOhYU5H/39trAgUHC/C9UdAr+f+074vYi
    EG8YokKu4/3qVc8eRSIngbaqipyXdoJmOv3dyL7ZftlmrFuoVNq66iEQRi/I5nqJeGDO
    2+6CYa/Lgi0r5HVGJQur4JO8frN/6hns74N8Y8rZg5CaILBj14QoCNNyiOrZTU2YXbQY
    H3EDvm2WAFuGek1kOWqC3CYuLehkp454SXlbPEkXe8ieWs/PQsLl88Tv5Kd3LsS6MbCS
    Nqqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=QNIGQta0aFr01M6Fluh44BH18zsVVLGH2QQuBe4pAN8=;
    b=rV6x3tBhwHaEVCbJbLo4rTk8OW5lQmduxTmTuLKYEFlLfyPsC92zSkmSTDnV2XMd4L
    sHBDJD0vTwLKdDiM+Dy2jpYe9D3nkJ+Q15UDMffHLrIpe/oAwjo86L0KIznaBpH2QbWF
    5cba64W9/Qv0hbzj57yC8/l8fKC4qtKEeHi32jsWFn0dJpqkFShhaEBIK3EVqPRXGvti
    TY9Vn8bOubM5vYH9bsX+cvYVjFs135v38ehoFeOfuqmoHkZQ0R9mYTx8IB13Newdm4OR
    T8X+bAZKlLPShg7LiUYiObYX8TnLCezfwCjd4Eeqj6vuT76QK/rc6RQ/Ghz9GVKKETMu
    ox5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174143;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=QNIGQta0aFr01M6Fluh44BH18zsVVLGH2QQuBe4pAN8=;
    b=URXBgCJB4LSJY8EENpsHx9mjxmpX585gGifPfFCX9lqeduB/wgtn6N7wy5gSdcYCip
    md6JSJ+z5YTvM4RPHdCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT2QMD
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:02 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:29:01 +0100
Subject: [PATCH v7 7/8] can: isotp: reject socket options while a transfer
 is active
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
Message-Id: <20261120-can-bcmlock-memcg-v7-7-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Sashiko <sashiko-bot@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=3709;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=rcNOTBtdV3kOvS+VZk1zki6fAANbgJsTSgev3Ndkb9s=;
 b=9shR+kati7txSLeSvSuEvzBXsbAc2DW3Npzcv59h3zOoe4fyT8qe2+ZkcJ08f/CkR3NxqvrWi
 pq28WhNpgU5DuJPoqDkD/Rs5sorHUlEzfKoDmB+jSsl9o49yroPcWXH
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_setsockopt_locked() only checks so->bound before it changes the
CAN_ISOTP socket options. When the bound CAN device is unregistered,
isotp_notify() clears so->bound, but a transmission or reception that
is already in progress is not stopped and may still be draining.

isotp_sendmsg() claims so->tx.state and rechecks so->bound. After that
it can block in sock_alloc_send_skb(), while the device is unregistered
and so->bound is cleared. A concurrent setsockopt() can then change
so->opt, so->ll and so->tx.ll_dl, before isotp_sendmsg() reads so->ll.mtu
and so->tx.ll_dl again to build the CAN frame for the skb that has been
allocated with the former so->ll.mtu.

isotp_bind() already rejects a new binding while so->tx.state or
so->rx.state are not ISOTP_IDLE for the same reason. Add this check to
isotp_setsockopt_locked() and return -EAGAIN, so the socket options can
only be changed when no transfer is active. As the transmission and
the reception always end by their timeouts at the latest, this state
is only temporary.

isotp_sendmsg() reads the CAN_ISOTP_EXTEND_ADDR and
CAN_ISOTP_WAIT_TX_DONE flags at its beginning, before the transfer is
claimed. Read them after the claim and the so->bound recheck instead,
so that all socket options used by isotp_sendmsg() are covered by this
check.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d1d3ef49-c24e-4f3a-91ce-20f8fb222684
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v7:
- read ae and wait_tx_done after the claim of the transfer
  (Sashiko review)
---
 net/can/isotp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 0b7db1ead7a9..642fec500af9 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1126,12 +1126,12 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *skb;
 	struct can_skb_ext *csx;
 	struct net_device *dev;
 	struct canfd_frame *cf;
-	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
-	int wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
+	int ae;
+	int wait_tx_done;
 	s64 hrtimer_sec = ISOTP_ECHO_TIMEOUT;
 	struct hrtimer *tx_hrt = &so->echotimer;
 	u32 new_state = ISOTP_SENDING;
 	u32 my_gen;
 	u32 old_cfecho;
@@ -1186,10 +1186,14 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	if (!READ_ONCE(so->bound)) {
 		err = -EADDRNOTAVAIL;
 		goto err_out_drop;
 	}
 
+	/* read the options after the claim of the transfer */
+	ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
+	wait_tx_done = (so->opt.flags & CAN_ISOTP_WAIT_TX_DONE) ? 1 : 0;
+
 	/* PDU size > default => try max_pdu_size */
 	if (size > so->tx.buflen && so->tx.buflen < max_pdu_size) {
 		u8 *newbuf = kmalloc(max_pdu_size, GFP_KERNEL);
 
 		if (newbuf) {
@@ -1724,10 +1728,18 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 	int ret = 0;
 
 	if (so->bound)
 		return -EISCONN;
 
+	/* A transmission or reception that outlived a previous binding
+	 * (unbound by NETDEV_UNREGISTER) may still be draining and uses the
+	 * socket options, see isotp_bind().
+	 */
+	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
+	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
+		return -EAGAIN;
+
 	switch (optname) {
 	case CAN_ISOTP_OPTS:
 		memcpy(&so->opt, val, sizeof(so->opt));
 
 		/* no separate rx_ext_address is given => use ext_address */

-- 
2.53.0

