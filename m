Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794566004;
	b=JAa7qynCOf/iL+nFnTGVoA/1cugZ9o1OuS2vVPJ4L98YGoUBDsp2uh+dewXVIVMkA91p
	 9nDmPpuS7N+Y73JF5pgFaIHs0xc60JIAVEt8DLx3MYcajNG7NebbnHaNkBEERCoJarkN9
	 RHzAaczZRojphhUgG4IpguC2JrtyoSSUbR1pPIRX8fZdZp5cg3pa9NTy2yimxtTCaYkZC
	 oauzy8Ysbcl4T3KiNPL7/IedCXFDkD08DmvLwnvTn9TuV6EHImeZb7JFNjog/NH7OBddg
	 15yJbbowE4fhiLlGALUjALopUeJsgjKr/bKEjS4QuMGX48HHjMcV7/cDxLOeyo3N7ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566004;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
	b=oNQHTwsYsBMoopAMVb3cgfyGrdXiUuIGyhZZCKKyZ/rqwE6GdovWLPEZAxG4+MeDprk2
	 wx/CBT+hruxnlHy06ZQEpyJmZzYN/fre8jmU/adGqKPJnTQOMHSOeLI0gutYSqv6xRKrp
	 htO4t+tghgfhZg5ui6++D89k+dfuflApHKIbPxMUZkQJnLSi4vBzd7UA13NlH8Qab/FhA
	 sUh1tXnxLNSCoowg0Dc0F4kh9hWA9WeD8/ORQcvjMmeHU4QjFSgNFbQSgo+Utz+dCSRIf
	 SnXpydh+aO6uJpcPc6Q1w7AAg7o8OFhz8RgEdpFv82awOUlz31PPEAhphM7MRtFWk2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=T3vmCoVz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DQiimEtA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.21
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272E606A31C
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C272E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=T3vmCoVz;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DQiimEtA
ARC-Seal: i=1; a=rsa-sha256; t=1794565995; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TjX/Bvn0H+F1PrM8Rdm7QolVzQGZ2TPP4C7mF/UCdAGmyuh+ywwbgrOWw1Yn6vLG0+
    4me5wSz7aCVPrrDI0DWnohkrDa+QNoDFNJcnUFVIMXLXJ7t5MI6KgCPrwC2SNjVje7En
    jt/UGo+nNpViisnxloV1eMar+K6Pgztx4dwqNaTAFg5buEIdSwtpKYW/aY5GlQKfqywZ
    XDs+s9Bdv+ro6Z76MiVhhKtd+F1a+UcewPJU6z8BE06dFnVE13395BreyMzNkIHUlDbw
    J4xj1oMDNqNbKpQf7XES2R2qndzkahvwOzNEbRbOT8mgDDoY9uJhqPQu9ozgFauFfT7O
    4gKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=Y+w0O7j78HoBlD2VYr50tzLamfWSZUJikrBTv9CE6MSoWPtYyEjenWB0earz+xMT9t
    mA7jqnsBsLqsSLEoux0sR2R1jGvykk091XwndPcDKTy7teSSRz96wt0E3D1md3y/Er0a
    s4yOs5FY4ZpsZmyXXDWmx6AVlOKyGAL/dKbHPQ3PBbfqWz7t/sXNWykHkMhhOxpYsJLC
    b+gTNoT1fDYB+l8hMFk/0Nv19F47Laasz7yS8qDXPMMEaQ3ELo1I3vpE+AAj/2r5bHGF
    j+Lnn4KbA5QV7EqOUNmq3WMx2NUVVSXG6ljqE0qp6VzbwCuXqJfNUXcGJivbVXInqjRP
    yPSg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=T3vmCoVz4waEUGrr2GXcc7a995Y6j/jrdF1jHnMi2B9STqcP+BC390S/08V7w/eYgD
    6sFXNH3lRJLscr8Bb01ZOoOuShrjTfBnUg0x68P5xORrreCwrtJiWQmbCfxUN3TbRIQs
    SlSfqlEVtiXcsA3IPyUR4FLJkC5XJXhB2CpppuDBiYTPoZtBvj3xWZw03DwBLADVNET8
    6m038l30vpW0J5jTdgYmiHUV/Raz3r5O1qw3oUuudvVZm+Tv5q5oXqI4LaWcj1ZrZWXm
    o7IF7ZAkhnzz0J+dvUZrH1yLDKEcr5669UpkdP8d7KOyO25w7dJVNYw1LWnh/2SZxJmL
    tp6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794565995;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=rjjQMZbdYZ/slq5hfEPjHY7mJMjmEAL3WdVnFMAQpCM=;
    b=DQiimEtA839xCVg+vF6n8Qo5a7oSXhfsZ/wfQApxbm0K6b3aJUFTBxVyVaoIaiVwDg
    PPNUtJiSdP9UGY8x3FAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2ADAXEIs6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 13 Nov 2026 11:33:14 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Fri, 13 Nov 2026 11:33:08 +0100
Subject: [PATCH v5 1/5] can: bcm: copy the CAN frames outside of
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
Message-Id: <20261113-can-bcmlock-memcg-v5-1-634c0e04bc72@hartkopp.net>
References: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
In-Reply-To: <20261113-can-bcmlock-memcg-v5-0-634c0e04bc72@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794565994; l=5572;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=QGLUrnhSG67q2r2nuf1IxIWSOFNyrnyjacMQfSBZTNs=;
 b=pfH2BWzY1tatRdJuMGrkT09YbSryNlH0u525OeIwK9p4WZLVRvGYNtP5oVP/LOs+2Rx+/9RNB
 ZdwC6v5HyJOCdrTN3TI4YN7oz43KTE3a1Md6194Rm0TpNT1FRUJFBmg
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

