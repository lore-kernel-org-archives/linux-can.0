Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.165
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794056828;
	b=CMhoCc2NLZQlUiG+rexdW+Wj4pq3rWg+5ItBIro/5layALcLWhCONoPcEq/wxN5hW/uT
	 olVwpuQ6Xxs0c2spHucxMwEPbZLmY5ZaN2OKIuuBJ/t4g82S8jHNywDVuoK2kxqz6Hvie
	 gLgal4iHK+jF1JhWVCPMxd7EXRKa/Z6hzOjvJjekh+NkenbWC1uv2OORWkdoFMVMmkHX/
	 KIlZ8J7x2PH7RKcvthL0KLd6nTW8Lpn2YfRQTOJw9uIke+7k082J9IgdnNLl1BmzDtWFd
	 e5FqJHlcjk0cQnv0RfvkOPR/J8LMCZJ2nfbr0YGCL9hGFI549bzXkgcQsWlYqSH4Y/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794056828;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ByQiClrFKo9Up3306xnCfIC2hbqifOUGs15GT7AZq1Y=;
	b=5hfH2yHG6Nm0ugXFqiKWoTr92C72eM+ElgotUf8AEWiUd8jblN3FCgonhrqhA1ppnN5L
	 xGgz4i4BU/zE0dmE43EP2HtpsTvj+kWdcP4XLjPSa/RpOKD3sQaK00z22UVGC0qMo2EMd
	 42m/cA2AhWsf4ypF28Edy+IE2a3bXWCZK2EjAGe1cjK2JRlkaT7igGdtoGGFkAcBpG4e2
	 pvKp58NS+lJDq5IRYRvXAmRkLilsmVRcR2WADOWx0PBGrAQWjZZQZQm2LdlhW/3vtffJ2
	 LtdeBHJVE+3O24v4paDi6i8cVoIQHwaWTr++DhxdEq/yMan24W+75NIQC5Jd9rvVprQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=r22azomx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=71uT9OtZ;
	arc=fail smtp.remote-ip=81.169.146.165
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D47606A32D
	for <linux-can@vger.kernel.org>; Sat,  7 Nov 2026 13:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D47606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=r22azomx;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=71uT9OtZ
ARC-Seal: i=1; a=rsa-sha256; t=1794056819; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NnW+Ug57tyKfcPmvZffcbp15MZwqr44ifgnttVVIIvSXC5VBxHTXIg9kWC0vcUjxUb
    DZX0LdOatjBb53I9m56yju0MMVJqwhtL8etpQSSV2xW3J2wSQc6qGQnHxoCOXhOJcPyY
    mqljtpclyuT/0lj3ov4vRqNcw+fpHlnhx7qzxxyKEigCbuDbnbyE670cHb19wuGypUK8
    Y7u3nS7F7CruaKnhHiEeS0cgPTAKKZwyqFUKSAS1LShL9X7Alv+vjsAghrIr7xjFCjqH
    wktnQXEJ+UrY57lGltmTxEAn0sxSySaLkM6axS3kFJyswBTDHQR0Ua1XefwkYa2mp+IX
    wMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ByQiClrFKo9Up3306xnCfIC2hbqifOUGs15GT7AZq1Y=;
    b=SdDt4xC9viGGfpacn5L80goEQq3gepnbSqcwl0heXdaejDyVRxR/pEOW2BOTw23E4T
    izL6psulRnB1NG/UkJ1N2ZqcoiRxe1bDE28iCVzMHDyqOlyZ6zFXd75VGJCxuiKe5Ha+
    NylmKL0rstbsFOzgmGAwvV1MTfG1pAuHjmkEjNN/bknuBd0SbyVxq9N748+igxT/0R34
    nhC5sAlrPxdrYjb3poZ9Ibrz2Te75d5aievUp+rVfC9FxT0lCWiH3ZUZFrp5/wkzWctx
    ZKsEtQH6yqhX7uofIFHs5qyIw3GYr3PzRwtosRqp3ACl1IeqjrVmIEjCOBXC3dbXnd0S
    O0aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ByQiClrFKo9Up3306xnCfIC2hbqifOUGs15GT7AZq1Y=;
    b=r22azomxQo/IvyKoBYrALJoYX2u56ITOyl8XYo8ISeVMbr1go4Wl/UJdNzsVnFOJ6M
    OLuzURbIM2XNhg1Rx3RqqcRYSEqDV0zQYvOgEdsr0/WG+jIdXS3PPB3rwS9TLCLEfWgj
    +mmMnE/k5F6a6ycMaBGh3Synznnd+9iIyMZxthPBulWGqv06nNjnWeyYl88N7FPKIPkZ
    M9CySvudTJQails6XWWpvkEMdhTgBz9AbYKtqTov8lzTONODSEzsx875XxEQfbgDkQ81
    t2oepF7UBcV3BQZa5lEr6cMRa//18X/LQf4qEzGFxz/Kd5km40yLlBFwzHCHZo+hT4gZ
    Ic6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794056819;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ByQiClrFKo9Up3306xnCfIC2hbqifOUGs15GT7AZq1Y=;
    b=71uT9OtZpsLetKCfW6zQW613CinXwcCEXx8ChqmIWJLs91itmTfG2Hr3tnIU7PL5Pe
    NrjGBotLtG9NJhzT7xAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2A7D6xlPW
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 7 Nov 2026 14:06:59 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sat, 07 Nov 2026 14:06:44 +0100
Subject: [PATCH 1/3] can: bcm: copy the CAN frames outside of lock_sock()
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
Message-Id: <20261107-can-bcmlock-memcg-v1-1-482d9f5be1fd@hartkopp.net>
References: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
In-Reply-To: <20261107-can-bcmlock-memcg-v1-0-482d9f5be1fd@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794056818; l=5017;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=996YvRTbr8SsALqk6KcpUeiQ4HHsa2J/T1DuRKj8/Vk=;
 b=4564WplYP9awleLe9ZdlsLHvO16Y4O4Zekd7ABj+ITyNQhPMKEPP/Gqmtj117prCL8Ll4encn
 UlOxHaRU1eaBHkSnuWGyg7A0/rPiXVYYTEsm2bASMajbKY+m/6RB6cR
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
checks and read the frames with memcpy_from_msg() as before. A single
CAN frame is copied to a buffer on the stack, multiple frames to a
kvmalloc() buffer of up to MAX_NFRAMES + 1 CAN FD frames.

As the frames are copied before lock_sock() now, a failing copy is
reported before the error conditions that are checked under
lock_sock(). This is in line with POSIX, which does not define an
order in which multiple error conditions are detected and reported.

The generic SOL_SOCKET options in sk_setsockopt() are not affected by
this patch.

Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/bcm.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 7bd2aa39777a..9c39f7363ca5 100644
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
+	struct canfd_frame sframe;	/* buffer for a single CAN CC / FD frame */
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

