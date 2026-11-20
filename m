Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795174153;
	b=EsJ+BBVD7AWmaOoYdEak4ggiSvDv27SgP9HmKeyh9XOyM8/y2T0aVu9S1JOwGExRenNJ
	 dL80KzxP3aFMr+ayoihHLUC9qrtyF2x2klXhPGJagIv3KF+CoSUi09LX+R0BVsVSqJ+mO
	 I21ZNoXICsa6U+9Edgz4/ANe2+9W2KVWWnQ0WOAfZ4ukFre/QWOHwNn7D1iBMJCS1swVN
	 TQAmY+C0sPpera56l1IpqE+6zZHXeCr11Xm3YvbhUU9H3VlVtQAB1BVmj0GFO3hwZMSiv
	 PbNQ7kLRDutjTYIZhDrJPIX3RyyH4KPjPrW6KpLo2ecfkYjIJBI8I7fZCZqSO0j+Row==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174153;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
	b=EJ2Ylt4JTrVTVGHaWHqMIyHUA6QotYYqqOHUzXKy2+lPaax4VlKwHSjUXca6RFUYlgKl
	 zhaKc/EJ0MUUg/Gazb9u9VDqk9Ea/Z/Z0Xf+yBV5+pmGZenXFIDvM3DKqm44YBCvorKIL
	 sll3ThD4De4JkfwFIKQLXv+F3Do1f4jKwdkhCWqxofrA51cpYLcG7s+/PjCi/uNdT4Kqp
	 0IRu+rxipdOr+2Lpmr5A0nX83czzdayJ8DjMkm1wvJPkA3tWF3y+easN8fHPTJ80hkjoU
	 6bhi2LelefT4j0YCewK1o/cKl8YYzFEVYVO7vBH4XoxH3m2UgZ7EuJj/w43JJTqcasg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b="I/FdaS9x";
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DIjGE9eX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.53
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5DB606A338
	for <linux-can@vger.kernel.org>; Fri, 20 Nov 2026 11:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5DB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=I/FdaS9x;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DIjGE9eX
ARC-Seal: i=1; a=rsa-sha256; t=1795174141; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SFsVcfArcan53M2DsFzDJ9i4p3/E5s1uykpWWJ1bDa9AlN3OWYB6NlB3ZsPkbI8SJT
    oL4BjylZLIwaXeBpx70VtiK9AdmY9OyGklXaNsVnwKU9af/Am+w0QoAEIxCoy6Ozreil
    q+Mrmse93tIWK1sz0f8e59HOJnNxpporfZGI0HKg9fJN+hviY+8mzW4ew/q3Grsd4Afw
    y5RnAbWFP6PA3dl0JJw6J8Bj2GH7E91/eOebGvItshOYLY68ZxWzKBbrFu+l5G8H2kSu
    KxkeeDPC/y6cv1Pf3Iw8iqo+fSFSq3ymHNr37mIcTYi54HsQmVmtRvE7sopC/DII6LJp
    49aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=qbPBzgIBV1oi3c8xFMWVhq5bwdTIqMmsAdWNcdKSr7CniqVplbDLppFVMH1VmwK1ix
    h0e4swTHb3VUXsWxV97w7yh1dAKoS7cTZa2t9a8PstzWQDjrWltozoRWUzTqWqUlFwpN
    YzqJyBI4G0LlUytgpK0iZxu97FR79XF4YNnewJWE+40fYAfDSnMaefTZtA3h6QSntm+f
    EN7yKa6ScoIbYEfbqqHIGO7tLzZqRp73ZV1WfPKmnGRoRO5ZmTUtjHUXANjAl5eRYqdj
    6ICNF82hfzoPBhHzi1AIUIlRi+n3LxpO+/XXMPHPWhJZsrLgauECoi1uX2dtghJobnSX
    J0jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=I/FdaS9x4gqRMiguUdfRlkwzHuN3LqNR52+xtEmXtDRUXyffUHfb7eZE4CdTg8Bsip
    DGenb3X/BsfRXQZm1O8weH2Kucmqk0rSwI/bzRqYpY1HC2ltQOup+h53M90H/MYXdJe7
    QTE52Z4pKtC+qjxfTJrrzwzP56GUBNaKuP30Pr5Ss18bN2+FCuDXoqPkKlxajMz6HgSf
    diMD93hmrpr65IAK2xwHyBCj6qxRRDWNAID9YEL2hbfoaDjd1Ee/85I+wkRS6s9uG+gR
    3vpW90PkMJaCXnrSzIfDPVgsbgGBbLexA4M1Nvy969ci9zUWI4yK1kHDGLr1X+T5R7Ts
    +Gdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795174141;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=DIjGE9eXJGoF/TMZmufdoaWMy/vsv/Fdk+xCfvqKWl7HDFhNARxiv/Gx6CJAbXhSOd
    Na0ooGG3aVZW3nw2b1Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AKBT1QM6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 20 Nov 2026 12:29:01 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 20 Nov 2026 12:28:55 +0100
Subject: [PATCH v7 1/8] can: bcm: copy the CAN frames outside of
 lock_sock()
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
Message-Id: <20261120-can-bcmlock-memcg-v7-1-f6b84f5257b1@hartkopp.net>
References: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
In-Reply-To: <20261120-can-bcmlock-memcg-v7-0-f6b84f5257b1@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795174141; l=5572;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=QGLUrnhSG67q2r2nuf1IxIWSOFNyrnyjacMQfSBZTNs=;
 b=7xAAtnbPwsF8HcRKlSRXharWGMe50OOkekx/+hgn4hJMCZZZ0VWMB5G/R7DnNncIktErVR8UQ
 8Qct4+KxoNKCpd66KLgEXXdICAqUGBJ4gFH3ZonGD4okIbgp+sK67d9
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

bcm_sendmsg() copies the CAN frames of TX_SETUP, RX_SETUP and TX_SEND
from user space while holding lock_sock(). A copy that faults or
stalls, e.g. on a FUSE backed mapping, holds lock_sock() for its whole
duration.

bcm_notify() takes lock_sock() of every CAN_BCM socket in the namespace
of a vanishing CAN device while holding RTNL, independent of the
binding of the socket. So a stalled copy on any CAN_BCM socket can
block RTNL on the unregistration or namespace change of a CAN device in
this namespace, e.g. of a vcan device in an unprivileged user and
network namespace.

Copy the CAN frames that the opcode handler reads to kernel memory
before lock_sock() and hand them to the handlers with a kvec based
msghdr. bcm_tx_setup(), bcm_rx_setup() and bcm_tx_send() keep their
checks and read the frames with memcpy_from_msg() as before. Up to
sizeof(struct canfd_frame) bytes, i.e. a single CAN FD frame or up to
four CAN CC frames, are copied to a buffer on the stack, more frames to
a kvmalloc() buffer of up to MAX_NFRAMES + 1 CAN FD frames.

As the frames are copied before lock_sock() now, a failing copy is
reported before the error conditions that are checked under
lock_sock(). This is in line with POSIX, which does not define an
order in which multiple error conditions are detected and reported.

The generic SOL_SOCKET options in sk_setsockopt() and sk_getsockopt(),
e.g. SO_ATTACH_FILTER, still access user space under the socket lock.
This is not specific to CAN_BCM and not addressed by this patch.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v2:
- the stack buffer holds up to sizeof(struct canfd_frame) bytes and not
  a single CAN frame: fixed comment and commit message (Sashiko review)
- commit message: describe the remaining generic SOL_SOCKET paths
  (Sashiko review)
- v1: https://lore.kernel.org/linux-can/20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net/
---
 net/can/bcm.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7bd2aa39777a..3f4c8d828337 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1641,10 +1641,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 {
 	struct sock *sk = sock->sk;
 	struct bcm_sock *bo = bcm_sk(sk);
 	int ifindex;
 	struct bcm_msg_head msg_head;
+	struct msghdr fmsg = {};	/* CAN frames copied to kernel memory */
+	struct kvec kv;
+	struct canfd_frame sframe;	/* stack buffer for up to CANFD_MTU bytes */
+	void *frames = &sframe;
+	size_t flen = 0;
 	int cfsiz;
 	int ret; /* read bytes or error codes as return value */
 
 	/* Lockless fast-path check for bound socket */
 	if (!READ_ONCE(bo->bound))
@@ -1661,10 +1666,51 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 
 	cfsiz = CFSIZ(msg_head.flags);
 	if ((size - MHSIZ) % cfsiz)
 		return -EINVAL;
 
+	/* Copy the CAN frames from user space before lock_sock(), so a
+	 * stalled copy can not block bcm_notify() waiting for lock_sock()
+	 * under RTNL. Only the frames the opcode handler reads are copied.
+	 * The handlers keep their checks and read the frames from fmsg.
+	 */
+	switch (msg_head.opcode) {
+	case TX_SETUP:
+		if (msg_head.nframes >= 1 && msg_head.nframes <= MAX_NFRAMES)
+			flen = msg_head.nframes * cfsiz;
+		break;
+
+	case RX_SETUP:
+		if (!(msg_head.flags & RX_FILTER_ID) &&
+		    msg_head.nframes <= MAX_NFRAMES + 1)
+			flen = msg_head.nframes * cfsiz;
+		break;
+
+	case TX_SEND:
+		if (msg_head.nframes == 1 && size == cfsiz + MHSIZ)
+			flen = cfsiz;
+		break;
+	}
+
+	/* a message with missing frames still fails in the handler */
+	flen = min(flen, msg_data_left(msg));
+
+	if (flen > sizeof(sframe)) {
+		frames = kvmalloc(flen, GFP_KERNEL);
+		if (!frames)
+			return -ENOMEM;
+	}
+
+	if (!copy_from_iter_full(frames, flen, &msg->msg_iter)) {
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	kv.iov_base = frames;
+	kv.iov_len = flen;
+	iov_iter_kvec(&fmsg.msg_iter, ITER_SOURCE, &kv, 1, flen);
+
 	lock_sock(sk);
 
 	/* Re-validate under the socket lock: a concurrent bcm_notify()
 	 * may have unbound this socket (device removal) after the
 	 * lockless fast-path check above. bo->ifindex is only ever
@@ -1719,15 +1765,15 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	switch (msg_head.opcode) {
 
 	case TX_SETUP:
-		ret = bcm_tx_setup(&msg_head, msg, ifindex, sk);
+		ret = bcm_tx_setup(&msg_head, &fmsg, ifindex, sk);
 		break;
 
 	case RX_SETUP:
-		ret = bcm_rx_setup(&msg_head, msg, ifindex, sk);
+		ret = bcm_rx_setup(&msg_head, &fmsg, ifindex, sk);
 		break;
 
 	case TX_DELETE:
 		if (bcm_delete_tx_op(&bo->tx_ops, &msg_head, ifindex))
 			ret = MHSIZ;
@@ -1757,20 +1803,23 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	case TX_SEND:
 		/* we need exactly one CAN frame behind the msg head */
 		if ((msg_head.nframes != 1) || (size != cfsiz + MHSIZ))
 			ret = -EINVAL;
 		else
-			ret = bcm_tx_send(msg, ifindex, sk, cfsiz);
+			ret = bcm_tx_send(&fmsg, ifindex, sk, cfsiz);
 		break;
 
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 out_release:
 	release_sock(sk);
+out_free:
+	if (frames != &sframe)
+		kvfree(frames);
 
 	return ret;
 }
 
 /*

-- 
2.53.0

