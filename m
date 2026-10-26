Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793020122;
	b=Ce8DTztBQsCfoEVMpf6T5WJeaDAMx5YiDo3CH2hytonzno1/YwLvljjnjrdGvWgx6IJG
	 HsrjCc4isdTKDMdFsT/FFhKKJLJJoTOxB9nYT5Q5LBu+c+W+eKnU3DH9t+B0AYF4qLpRo
	 C7LvfzHnOb/uohbnJxcJs+XhDXNDzKr89ZpCwYofeOEqaK+5fCVeOmvpBcMJXItOg2DPx
	 puK0ZzxIxmnpbPMbva9dmenuFJP4W27yJsTjO+4unmPEwo+SlCpDNzloAEthAt54RTD7X
	 gWjYNVJKBMc7HjJ47jF5pp0T9H+XOTWwP31xxfrO5AsQs9tMk2XscW4sBD25qMuar3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020122;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
	b=AK0mfFrnzkWO/NuoOEwXomtWVr5Zc7aHfIHcA3R0Ex4kJMbrgxOP5T1tDHISX3D/NZsz
	 xj4WE9CqbTVw8alzUOKCE6pKkgnNNEFTplO+ugFrqhM3GTwFPFUfD5v/INqVcmKtku35H
	 PWV7bo94PhW5A5RKvGSLisWaTDq6zmxq8XULP4YjLCPVuevu49X6vx0quIcreOn/Dll3h
	 2iLkZdHzFdcOAiQ3MGxhXVPMPsRnSFyxjjpaFFZBlg03pok0PL8aC5GpYg2AF7TL+w1jR
	 WtT29/q27Sj8R3CoGMo980Dl2UgnIEBvkVs9UbeVh4n08Xo68qDyrwZcw4OIF+sNFYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=FOzpbriZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dtHj5cC4;
	arc=fail smtp.remote-ip=85.215.255.50
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226B606A326
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9226B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=FOzpbriZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=dtHj5cC4
ARC-Seal: i=1; a=rsa-sha256; t=1793020119; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NXCOOoqQchbbkumrYzBCADg5iCxnMuAXEHV89m9fdw7ULk+ymdVEPFfR4ct2yjxl3Z
    UT7pQYdG4lv0tKqsEv/ojx9rj5/8jxWd/QRpwSDn33c6FruKIImOqduXXPSl5+eEv8NO
    Y0wRXElOFyKRRkBNNt8f5CV1CJ/86sLKqDMlJHXCriqCCZRPpxrKzIYbfE4WgUxXQwTP
    rfjcz9moGYKnyKhPkpv4jR/HXwy+gG7HbSK3zDwUOX2H6n0Pa8tGmPAflHRfLSXHIyMc
    oKJXKv8JdmYm2Xo5Ni8mpbfR4pGMfrM0/+BLm8KX0oQh/VaqSkIE8iBCtZxxhpEBdnqB
    zMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020119;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=QzHjSb+GdqilzKiPru1hIIHBGb85h422XG5Ryj0S1rZ5OMwi5YC4ojKm3KXENpcqIE
    C3UVW30pvYSNEo5BATLM+aWXuu+cGyeo0/sCnv9TukjXSHjoFkmGG7cprJl7gqePbyX5
    woAvBZMshzR81j4X6TOS32Itxw8RyqzmU53F34rzNaCxP86knfAM1jHF/BiUr8O1Gpsp
    43blIjQ3ZPAeThnpAWyev4VUtamElANf+vNYxkrsFBlIhIXrCTqyJqfmisUTc3HDTCd0
    Gbn8DGtIop9dvSFp0Xxz69DxQTRWA0C8NGziQgDuX+qdKt9yEK48aQ8JI7Zec5U0R6cV
    6FOw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793020119;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=FOzpbriZh4BpeIRRu4Zh7e0JtQkuLyv4YX64ha/9c2c6ZC4Az4JQNQyNhsp3xrVQJ1
    Ma7d0Nm6FtMh/SOnxCrDzyytGXidnD6D15IrEqPMblZ28iXxPCLD4BFUS1sX4A7UDWqh
    N+bS2uTEVtc6ddzN1o8f84+6EQJ84Kfu64ifEIIg+c63qPAlZTs0s0gHN5a4YS41eUmN
    5sDXp1KByZmKaiSAzUhW+H8HNpSd5rFYpgQop+ByXePRmfq5NgTPSvZQ4BTAQiCVvbuC
    sFpVRqhttWPvWI+7AEUFQFVLpXcrj8895Oajlnx57CRsdUO+5NHqihYud/Tx3R7zhoKn
    LAsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793020119;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=dtHj5cC4tAQ1NK0J/y3P1rryPH4bB65nMagaMjeALXWiw8xDDthdkhKG5LCqEwGUSG
    o7u53cYl5++5TkSPjbAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29QD8d2Wz
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 14:08:39 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 14:08:33 +0100
Subject: [PATCH v11 5/7] can: isotp: check the return values of
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
Message-Id: <20261026-can-rx-lock-v11-5-3b9a2b829dab@hartkopp.net>
References: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v11-0-3b9a2b829dab@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793020116; l=4360;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=UoUbl8+3VwOU36uhFCF9goVxXDCNnR5SjwXqq4KlbBE=;
 b=9yX2lJd9EBS0b6qaH3KMUzI8cwLwyy5FNpNdSQv9MPrCUe1TcmGndo8t7tG29VRTlcG0bJHTr
 hbZuTbSrlocBHHNsi2H6bOJbPbZSPd106Jcyzi0lXNeIhAch4tpg/7h
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

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v10:
- register the echo receiver first and the RX receiver as the last step,
  so that a failed RX registration only needs to remove the echo
  receiver and isotp_rcv() has never processed a frame for this socket
  (Sashiko review)
- set so->ifindex before the registrations and reset it when bind()
  fails
- v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net/
---
 net/can/isotp.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..894582cd9ddd 100644
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
@@ -1620,37 +1619,48 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		goto out_put_dev;
 	}
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
-	ifindex = dev->ifindex;
-
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, sock_i_ino(sk), sk);
+	/* switch to new settings */
+	so->ifindex = dev->ifindex;
+	so->rxid = rx_id;
+	so->txid = tx_id;
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
-	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	/* register for echo skb's first (no echo traffic at this point) */
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	if (err)
+		goto out_put_dev;
+
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, sock_i_ino(sk), sk);
+		if (err) {
+			/* unregister echo skb subscription */
+			can_rx_unregister(net, dev, tx_id, SINGLE_MASK(tx_id),
+					  isotp_rcv_echo, sk);
+			goto out_put_dev;
+		}
+	}
 
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

