Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793111487;
	b=igagPUGJ982rRAxJPc0VF9cHAp2cTGf0aK+qs3sRvfCNSCMRWh6Y0vHdt4+XO/b6yTmr
	 B0eQueFjgj0CGCyUBHoPpTtAydtbNLJ+w3FtcMByCJyAPIMkcMHWt+VZcWhapC3YfHESk
	 tZDs+EOWhEfWx9hz3U02E47Dr5iow9mxzOrGqZ2oNZ1G5H1GWMcwJ5MedDcyFjrDIPfz8
	 +17f7uGFW+ucFiAueFGsUw4D4eRdrje+olyl6dA9JlBH3J1XfJLzr5Ot5r3hhOZYOnExy
	 DTCE9hrJIKAf+BPEOsPhVcvpw2PGofJT+NWlGzfQjjGxVg94dohb28vwps6rXgtJLVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111487;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vce+HKfDzQpoJSTlhct32zQTJkmm6zXSGCfqVPbSAtI=;
	b=EEgwWejxQuFKb5RKxgwvzBCaKzOsX+eNETNMy9WS2+K94J9m78htQ7TQlZuohr0+PWq/
	 3kL0Wy89pdlZB8U6dNc9MQIvg06AAhruXliBLRYfojL31ZdTWcMJmD7fvmRIJaU02K+ab
	 bZ8UqLeg6/JEJBxTmSJZXRr1fxS859DXH+1KixOEG8KgeXmETQI54Xq/6m5E/Q4Eq+2HX
	 XFc45WdXriXb0KLDYwsAzGwNQgfn17ADcCtWkYL1AKya23ymESV2uedBOak1NYQCs11jC
	 malmgAb+xYlw83S+g8Ztd7ntN4hCBbunvyqpFVBPmRWGt3P3i3z590W7922o53RcQQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eMw4zl0N;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qk6IkGdF;
	arc=fail smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9649B606A31F
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 14:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9649B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=eMw4zl0N;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=qk6IkGdF
ARC-Seal: i=1; a=rsa-sha256; t=1793111474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cuZ6ayThT82p3CDerSSVFsAIqHx9Pqlrxm+e9cPRtuBBDE7P67aUIa9a2qIFEXDs7o
    ZD/P3SUu6P4pi3K0pBnnD2He0g9PeStrW3nvPIZIBsHXJtWF+GwROMUKy+Ffl7Kkab4o
    CAsJc0EArHXdSUcMp1D3YQItrwuRTK2flfQewKWdWdap/l0vosUHzQMit+3IGI7ORX1D
    wp5hOfgmZjRKha2138rTfDdZwLqzlArA15mD9RT9A6fAfPwW1oppk/5yyXt5Koi7AMIj
    HLjFUBAFJgyn/TqQNS3oRYWRG8V6Of2O4NHv5Teq3d6UhfG10rzyhcxC1nYpF4c1dRE0
    TK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vce+HKfDzQpoJSTlhct32zQTJkmm6zXSGCfqVPbSAtI=;
    b=sgUjFhko0K9t8zetSTI5S0TknhcCuR674pe4jXMVKQvjIN9ux6wHnnVfi6Tw3SKsTW
    roLucZZHfwzYWsppkUPv2wIZ0u0ONmwBqefmN40FvYhjKLGDqoPDHC3l0ZlxxLk5MU1n
    atmpKV85lSPKWyjGZQ/La9h6SjzRB1L5FpFD6KjJ+L0V5T579DW4du5RSOX6MUtZHRxQ
    zT/MD4qhaFaVA4F6T9vg0OgPTyv+6+0sZypdfI7y25n0hOLIkxivIxPkoxhgbTBWiZL9
    QJZXgVrsNp4zKtUiNYaHXDFFEzHHUKVD+bBXFHFHG1nkCQAasrVf7cBpfXtzLMpv30sQ
    x1Tw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vce+HKfDzQpoJSTlhct32zQTJkmm6zXSGCfqVPbSAtI=;
    b=eMw4zl0Nif7H/08dAu2l2vzqalmp/5DzVFuIJZfeCrp8k28eY1lcHc4laYo5vN+c2o
    80EnHDIqpvotb1HEqc948ODCtKcHFDebxNR60WdA4ItFwOGbD2ki2avt7Yr9Wz6Uvlpo
    wiDcTIZBHcsjioigylLAC9rmbXO1DSG4rdyZGBC0yYEmUGTY2M+2/HthSV76QpOI50C2
    DQYNdHfaCx2xLRYCj0opMaVX1gXp+eGlFJKVt1saRjFbcY0Dut5W7vjmV+Krgs3pYZaV
    fR6LbngSbjsIkSYBO4IakLDQ1fITlKFByXb/x1BRQeOPHgUg3NyrLz0zTLLYgl5L2jgH
    VlUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793111474;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Vce+HKfDzQpoJSTlhct32zQTJkmm6zXSGCfqVPbSAtI=;
    b=qk6IkGdFeYndFD8qd+1KvHy52ewntMFF0tA+JBrG/C2nyKLPYEAfRqe9cir3AZwpgv
    B2aMHvLZ7gtpxLkxM3Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29REVDAL4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 15:31:13 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 27 Oct 2026 15:31:06 +0100
Subject: [PATCH v12 2/7] can: isotp: check the return values of
 can_rx_register() in isotp_bind()
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
Message-Id: <20261027-can-rx-lock-v12-2-eb5afc2d8b9b@hartkopp.net>
References: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
In-Reply-To: <20261027-can-rx-lock-v12-0-eb5afc2d8b9b@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793111472; l=5191;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ipN350oD0Y92rbUD/cYY6CA5XONFQJhOP28O1vrbaUQ=;
 b=NrO51f21J1/B02Cm5M++fGDX9Sc2n//d0WpPAML0sbNxw/mr9n/+6TdyTDRC5CDfhFt4kKycU
 mPb7n7qaXEEDFtUw4wR4F1IhODecBYUmkcUeITY6lRhnCJt5KXtA5e3
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_bind() ignores the return values of can_rx_register() for the RX
and the echo receiver and binds the socket anyway. When a receiver can
not be allocated, bind() succeeds without this receiver, so the socket
does not receive frames or its transmissions time out. isotp_release()
and isotp_notify() later try to remove the missing receiver, which
triggers the "receive list entry not found" warning in
can_rx_unregister().

As the device has been checked before and RTNL prevents a namespace
change during bind(), only -ENOMEM can be returned here.

Check the return values and register the RX receiver as the last step.
The echo receiver is registered first, as it only handles the socket's
own echo frames and does nothing while no transmission is in progress.
So a failed RX registration only needs to remove the echo receiver, and
isotp_rcv() has never processed a frame for this socket.

Set so->ifindex before the registrations, so that a First Frame received
before so->bound is set can be answered with a Flow Control frame and
the RX timeout is started as usual. As the RX receiver is registered
last, this can only happen for a bind() that succeeds. Reset so->ifindex
when bind() fails.

Check IFF_UP only after the receivers have been registered, so that a
bind() that fails on a down device does not report ENETDOWN. As bind()
holds RTNL, the device state can not change in between.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v12:
- check IFF_UP after the successful registrations, so that a bind()
  that fails on a down device does not report ENETDOWN (review of v11)
- moved from patch 5 to patch 2 in front of "can: proc: remove pointers
  from CAN specific proc output", so the receivers are registered with
  the "isotpe" and "isotp" idents here (no functional change)
- v11: https://lore.kernel.org/linux-can/20261026-can-rx-lock-v11-5-3b9a2b829dab@hartkopp.net/

Changes in v10:
- register the echo receiver first and the RX receiver as the last step,
  so that a failed RX registration only needs to remove the echo
  receiver and isotp_rcv() has never processed a frame for this socket
  (Sashiko review)
- set so->ifindex before the registrations and reset it when bind()
  fails
- v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net/
---
 net/can/isotp.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6c28802c0605..3efdce022c55 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1540,11 +1540,10 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
-	int ifindex;
 	struct net_device *dev;
 	canid_t tx_id = addr->can_addr.tp.tx_id;
 	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -1617,40 +1616,53 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	}
 	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
 		err = -EINVAL;
 		goto out_put_dev;
 	}
-	if (!(dev->flags & IFF_UP))
-		notify_enetdown = 1;
 
-	ifindex = dev->ifindex;
-
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, "isotp", sk);
+	/* switch to new settings */
+	so->ifindex = dev->ifindex;
+	so->rxid = rx_id;
+	so->txid = tx_id;
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
-	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, "isotpe", sk);
+	/* register for echo skb's first (no echo traffic at this point) */
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, "isotpe", sk);
+	if (err)
+		goto out_put_dev;
+
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, "isotp", sk);
+		if (err) {
+			/* unregister echo skb subscription */
+			can_rx_unregister(net, dev, tx_id, SINGLE_MASK(tx_id),
+					  isotp_rcv_echo, sk);
+			goto out_put_dev;
+		}
+	}
+
+	/* report a down device only for a successful bind() */
+	if (!(dev->flags & IFF_UP))
+		notify_enetdown = 1;
 
-	/* switch to new settings */
-	so->ifindex = ifindex;
-	so->rxid = rx_id;
-	so->txid = tx_id;
 	so->bound = 1;
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
 	so->dev = dev;
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
 out_put_dev:
+	if (err)
+		so->ifindex = 0; /* reset on failed bind() */
+
 	/* remove potential reference from dev_get_by_index() */
 	dev_put(dev);
 out:
 	release_sock(sk);
 	rtnl_unlock();

-- 
2.53.0

