Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727156;
	b=ZNHgsBVTf7ChOpZXQ6tJGhIxs0penFsHZAfkrGR0mffdUFvebgv+qoFAQp/bpBBTnP28
	 hb7I3obcZK+w9RG1Ih0GDJxKPBbD6QdVth7r7gOJtjtB2eQPY6qJJn8sLvAAqZqKka+tM
	 Uv3sboBLL08cjp+SSxQoj0WMDxTyx4UMgDW09gWDUtAV5+U41UoVnbPaGLY4J+5FNsHwo
	 ylZ8CMBX3CKcPCQRrDqPuPR5IgTRHQbtDT/MP0ftkhI+YA8gQK5nMvOrMxhQ8nvkb8uH6
	 KZea2F4bjdSc7vEalIGjptmWFh+Tf8PuAJMoRi8ANrWd5adhQQA+1SmWR+c+3eFd0nQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727156;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gwYSioqjCMHk3PEDLVMldxhVaFx3d986mv1lausjlwM=;
	b=jlyTrMwwa8ufoSLTZ+P4MG1pxFZZCnuMnLK71FWncw+YLAQrULdNdKcLLLtpValBZMGQ
	 UVn6zvPZvYNqvrTSs2i/RIZWFBpKpIAtxFSLhT5dsblhuZLenEAlbFS3zgMYiQOjpMP7z
	 Rt25uO4TjNyeilGtQ0CJa7i+Swtl7UqoZKCfS+3FrwAhYtAqxJiP7ROwpYyF53Ra3cq7o
	 9GuxnpxJQQEoh9KkwwGpq0LeJTxFeyaxHG5COj1X9zTlkja3f2V5w291/Vz8YA2k5g7Go
	 VVMj+Llq6iF13ljX7I46X7aCdlAIzQcMErNZ5Zjq9acEt7ZYAVeN6LEu3U5uhH3TdDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QgvHBACp;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="Zenv/o6L";
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.83
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A222B606A321
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A222B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=QgvHBACp;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=Zenv/o6L
ARC-Seal: i=1; a=rsa-sha256; t=1795727154; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LBnUcw9OK6ai7jM1ZCv3yJAEkn086dzLVzHDtIIIEUSfpjWakHeAGiSYayTM0O2cJh
    8A7vkBC6ymuUfKkZVqAHe3jNryupmczluzU9hEZVNmV3+kxxy9HpzJ1M2tSLqIP0Z2dC
    T/rgzrlD+Tk8B/J267wXrbD7p+u5N59cPsRbCnDHihn11vnKsLJhKtlLOfjyz6LXswCG
    uaBJG/KZ11Ts/4q9wbXZI3VmVAxlvodulQC0TR2FtHWPM4r/c+4mKk0BjJ1lxIB2EcAe
    bMuSBMtuadHILfFXQV4FgDcGr7UkPWxF6s5H2rZlh/O8muHNK8yAyw9YFFFsDC6TJo7w
    d7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727154;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=gwYSioqjCMHk3PEDLVMldxhVaFx3d986mv1lausjlwM=;
    b=sI4meWg24ntAERomCzeOkWoSdPyr7COdEtNCVsGC0cnPq/WSdU7zNkGOpMLZoqRpVi
    Mlpgx8cavU/++5GIgOmOD79Ibxh+iTHGKIKv70RNGqStXBOhdeQwW/uOYTUUCa3c2xD9
    nyhv76L0QzTUhWdJGX7eBLbymwT+dZgtldQ9jbPqtM+RUvixQL25vz4M7mfmQJIB6tyU
    jzvZId9U/eIIKffXyE6lQ6jIdtxyoUfmUcdNaumRcXwfieXkOf1X9UK7iyBTnuKpssjK
    4ZaHlV8XMNj+Ur00TsbfzVfgMXtpentJpS/t4s6fxAvm+8BsPyAeK3rN1FRb+zGH0pBK
    w7gQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727154;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=gwYSioqjCMHk3PEDLVMldxhVaFx3d986mv1lausjlwM=;
    b=QgvHBACpdzXedAjvi5tw7YhPLTZLV2u5aPoekhlAJqqbfG5jyNt8B3Bu0tAGAsCI1F
    wKF1n+3MMCALe4+2ZyrFpGRCc3Fpksa3MQuqkBDspUQp0XB/54x5nrfHkV8evnjG0hdd
    17Gr3HH0040YhavyHFlQ+6wBSOJQMKxP+Uqxta+M7loHKx9gFfYqRimME1CU94MUCThF
    ijiRK1NK9LF+/a+B8h9rY5SGs+yVqVHYpOdxyHwlMz7WEle208SA4vuXAmQTZg3VoBfC
    wa1ds7aNZ6N6bC3Ex2qsG0vCE6GHEVWhBopqWNPMPQ6HsE/3x4Lt8lewBMwdg3r+88N2
    MDXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727154;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=gwYSioqjCMHk3PEDLVMldxhVaFx3d986mv1lausjlwM=;
    b=Zenv/o6LsfC6EgGw9dq8PIWRBjO1J6zemZGVnZHoaWga/Uoiumv48aiXxNv6cT3GV6
    hcakTj6gZvvg0+mp+2AQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:06:04 +0100
Subject: [PATCH can-next 22/22] can: isotp: introduce CAN_ISOTP_MIN_TX_DL
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-22-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=3578;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=eSrpbc4nlayuWlIfOoF0z8YKUbutKXMeaxjrce1xoms=;
 b=DT5orr9y79Rm1krD2CMJPsTHOiRkbz5nnylARhYiWYXQD9piMVwXHQqLq7puQv4PQ9j6u0CMV
 ZMnlXn9VWwrB430uRqYizL0w/WPj7/bcZRjfzhZbhfm96hh/urNvX0Q
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The minimum TX_DL value is 8 and the CAN_MAX_DLEN is also 8.
To not mix the intention and context of the defines introduce a separate
CAN_ISOTP_MIN_TX_DL definition to perform TX_DL related checks.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can/isotp.h |  3 ++-
 net/can/isotp.c                | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/can/isotp.h b/include/uapi/linux/can/isotp.h
index bd990917f7c4..580d2aef2c53 100644
--- a/include/uapi/linux/can/isotp.h
+++ b/include/uapi/linux/can/isotp.h
@@ -160,12 +160,13 @@ struct can_isotp_ll_options {
  * consistency and copied directly into the flow control (FC) frame.
  */
 
 /* link layer default values => make use of Classical CAN frames */
 
+#define CAN_ISOTP_MIN_TX_DL		CAN_MAX_DLEN
 #define CAN_ISOTP_DEFAULT_LL_MTU	CAN_MTU
-#define CAN_ISOTP_DEFAULT_LL_TX_DL	CAN_MAX_DLEN
+#define CAN_ISOTP_DEFAULT_LL_TX_DL	CAN_ISOTP_MIN_TX_DL
 #define CAN_ISOTP_DEFAULT_LL_TX_FLAGS	0
 
 /*
  * The CAN_ISOTP_DEFAULT_FRAME_TXTIME has become a non-zero value as
  * it only makes sense for isotp implementation tests to run without
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 47f91e88dedb..acea58db9ccd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -402,11 +402,11 @@ static bool chk_optimized_fail(struct canfd_frame *cf, int start_index)
 	/* for CAN_DL <= 8 the start_index is equal to the CAN_DL as the
 	 * padding would start at this point. E.g. if the padding would
 	 * start at cf.data[7] cf->len has to be 7 to be optimal.
 	 * Note: The data[] index starts with zero.
 	 */
-	if (cf->len <= CAN_MAX_DLEN)
+	if (cf->len <= CAN_ISOTP_MIN_TX_DL)
 		return (cf->len != start_index);
 
 	/* This relation is also valid in the non-linear DLC range, where
 	 * we need to take care of the minimal next possible CAN_DL.
 	 * The correct check would be (padlen(cf->len) != padlen(start_index)).
@@ -615,12 +615,12 @@ static void isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 		if (len <= MAX_12BIT_PDU_SIZE)
 			return;
 	}
 
 	/* the PDU must not fit into a SF (FF_DLmin) */
-	if (ll_dl == CAN_MAX_DLEN)
-		sf_max = CAN_MAX_DLEN - SF_PCI_SZ4 - ae;
+	if (ll_dl == CAN_ISOTP_MIN_TX_DL)
+		sf_max = CAN_ISOTP_MIN_TX_DL - SF_PCI_SZ4 - ae;
 	else
 		sf_max = ll_dl - SF_PCI_SZ8 - ae;
 
 	if (len <= sf_max)
 		return;
@@ -1234,11 +1234,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		err = -EINVAL;
 		goto err_out_drop;
 	}
 
 	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
-	off = (so->tx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
+	off = (so->tx.ll_dl > CAN_ISOTP_MIN_TX_DL) ? 1 : 0;
 
 	/* does the given data fit into a single frame for SF_BROADCAST? */
 	if ((isotp_bc_flags(so) == CAN_ISOTP_SF_BROADCAST) &&
 	    (size > so->tx.ll_dl - SF_PCI_SZ4 - ae - off)) {
 		err = -EINVAL;
@@ -1295,11 +1295,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		 * When TX_DL is greater 8 but the message would still fit
 		 * into a 8 byte CAN frame, we can omit the offset.
 		 * This prevents a protocol caused length extension from
 		 * CAN_DL = 8 to CAN_DL = 12 due to the SF_SL ESC handling.
 		 */
-		if (size <= CAN_MAX_DLEN - SF_PCI_SZ4 - ae)
+		if (size <= CAN_ISOTP_MIN_TX_DL - SF_PCI_SZ4 - ae)
 			off = 0;
 
 		isotp_fill_dataframe(cf, so, ae, off);
 
 		/* place single frame N_PCI w/o length in appropriate index */

-- 
2.53.0

