Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727162;
	b=2p+caCZ4xz1WevGnYrfOC6UXKrcH9Namv7m/r8HikF9QEbgMUOjigBZEsTSAjuL6+6Ks
	 szOiW01U960sxWpoGBHRKyVRcVbGNWHEmdmX3jw9+m0c3kiG4mGwr2FD8ghtHyThnohSF
	 DczxbWQzMqNsE4uagFYchpOuSBO8SGd4IPDpGRzoKvOxTSo+9OtAk2a09votJpgi4XB5r
	 4fdKPlAZ7AIBVuZtYUVqFGWhnNIQbiKeZKa1CiPc8jN+IsGLh1syuEmd+fcMSpEAXgODF
	 LOJasLgm0sHuLyV+/Ju4n2SZcG1ed6C91No5bd01vmOfUF75nKv+MA+JkB0FPxny0CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727162;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=igrYWVnkYKMo9T452Eabt/WEgkuk4QWSN6hZ8oyY2uY=;
	b=FYod2FWtGYgtvCqgQ637ncEGWMhz2Y4CBukUXShsgklHN2FVq6XXL+aCXR+rUkcnrd9Q
	 C/WZxSP8OSHpA6ojCanrSWafCgG4HNBeFGKHIGNxclWxQz2sChaDmLzl9L/Qm0RfZ/QYq
	 oRQG8XDiK+8MBK9pJZzfbn2sYh/kIRhXhZXuho5H4iOalN0ZOBCkFV5SmeH52yWJEvJOl
	 diiPbt20TAy6zY8IgeA/Ztrj57Dw3dzbQazhaVivtniapMnqsWO5fzVRZw1FsC7uPyypy
	 XZmkJQNIJAOslD5oCcXum8ZSqQAtjGRMzjTSYM9WIyANHF+hfj8845nj8SbpEJRlc6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ihmIzSCm;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uGMjiM4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01632606A33D
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01632606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ihmIzSCm;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uGMjiM4W
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a2cZnSB9HmEjfCg1IvQf46OMybyZuh15oBB/vcXyx704MQKpQfS6mCjkOCYwiv63J8
    Q80Ilpcq08hAMYQGRwPMswpMXc82zMvhRjZJA/Hsxz9k5C7rho3Bq4YtMuf7OU2rQ1Mr
    TSW7NNLy4cSW0WG6NWcq1mh1Y5AtF0gxuBxAMB/hVRzZyA3JORgfGBK83hOe1onB9WJ9
    FvoVqbgS5H1LKUPZeyBb8Tk9aHzQfHjincxcTclQLzVR6LPUetaBU76XpKr0oVbYi7Jl
    TLi5jKnAiDT9AfQmog3NZHr2pmnZmZvidxpCNO0KTWt2fbDW8gMNIBF0lU3j7QVt2sDg
    zTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=igrYWVnkYKMo9T452Eabt/WEgkuk4QWSN6hZ8oyY2uY=;
    b=tRkXoERFdNtuahXz9Sz+8li7lzl1RO8B9sI9yAMaaGP4aaIfZOa2mhliZLHnNqbZTM
    MyhJL8J8/bUxy7fEXu3jfP9idiWlpfrFIqQIov6vKFsH7ZnC3ewh9KZO8piv4m9Ev2wM
    arw7AwrNExavStm79ixH7zJT+awvEsU7DFq1eIbm26ilDZBA1ylCmDfe+q4Bbu/UNuCe
    TKVNuC3PAq6fbBzv+jvvZ3aXi0D/N6yHztnJroQ89pQrHAPGO5WUZ7nCkLdFbDcF+8Oa
    4BqUr4a1gBBB8WPuTFFYQ2W2l4UGW2+Zaq7i1iERjydxBZaqAqVwJ4NPMldvL3mNp/GC
    mbIw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=igrYWVnkYKMo9T452Eabt/WEgkuk4QWSN6hZ8oyY2uY=;
    b=ihmIzSCmc0NZYqGdXTHKaA6ltUYe3AGH/oW8gee7lou3OI4xvEprnW5JZvQ8Zxtvg7
    lJCmjCwNqvYIF1S0vrg7ARFZQj8snfHngFuIJICF7fkHn1HrvkXGVnSm6MOQb4EFP5uN
    AAivC+PMPZlmXEsYXsEu2y5DGlTo5M2VkgorF41YouxcBqIJZ9hn5Xy9EOv8fOUhiRoN
    jzdJgOgDqcSrf5pv7i2AIzmNiqI5SsgGyyQ7yQhbpTAGnQZ6xn+RvJxYPniamKub7u+N
    ozB2tINPBbkKm5EmCE9+ltJYBWHsXPdfVwF2622GU5ioIfWZYpGILhG4p4ly6VUxAucl
    AteA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=igrYWVnkYKMo9T452Eabt/WEgkuk4QWSN6hZ8oyY2uY=;
    b=uGMjiM4W8Ad+0vOWC9pXyPAKQUxnOEpuH3CMHm+r22Ebn6qh/czE+6AkZwSmLiWh/C
    KxdWKnUuuGm/q8iiz4BQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:06:01 +0100
Subject: [PATCH can-next 19/22] can: isotp: rename checkpad functions
 returning bool values
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-19-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=4247;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=ajgJMSFWw7koaPvNf5apFMUOkU341c8UK9VLCvsh/9Q=;
 b=w3Fxma+oWyTTdQTSBbSAShDLarRo1CKw1R6WB5KxiyKY6p+cjb6T9ajbdNebGN+URH8XCinwb
 i7VydCKlyb/BvJv0CcHMg2v2bvWYMR5isU1x43zjCsh2HPPAA9EPvFH
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The checkpad functions return true when failing. Rename the functions
to reflect their functionality together with a conversion to bool
return values.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 61021d7052d4..31acff7c33aa 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -393,12 +393,12 @@ static u8 padlen(u8 datalen)
 		return 64;
 
 	return plen[datalen];
 }
 
-/* check for length optimization and return 1/true when the check fails */
-static int check_optimized(struct canfd_frame *cf, int start_index)
+/* check for length optimization and return true when the check fails */
+static bool chk_optimized_fail(struct canfd_frame *cf, int start_index)
 {
 	/* for CAN_DL <= 8 the start_index is equal to the CAN_DL as the
 	 * padding would start at this point. E.g. if the padding would
 	 * start at cf.data[7] cf->len has to be 7 to be optimal.
 	 * Note: The data[] index starts with zero.
@@ -413,37 +413,38 @@ static int check_optimized(struct canfd_frame *cf, int start_index)
 	 * point the padlen(cf->len) is always equal to cf->len.
 	 */
 	return (cf->len != padlen(start_index));
 }
 
-/* check padding and return 1/true when the check fails */
-static int check_pad(struct isotp_sock *so, struct canfd_frame *cf,
-		     int start_index, u8 content)
+/* check padding and return true when the check fails */
+static bool chk_pad_fail(struct isotp_sock *so, struct canfd_frame *cf,
+			 int start_index, u8 content)
 {
 	int i;
 
 	/* no RX_PADDING value => check length of optimized frame length */
 	if (!(so->opt.flags & CAN_ISOTP_RX_PADDING)) {
 		if (so->opt.flags & CAN_ISOTP_CHK_PAD_LEN)
-			return check_optimized(cf, start_index);
+			return chk_optimized_fail(cf, start_index);
 
 		/* no valid test against empty value => ignore frame */
-		return 1;
+		return true;
 	}
 
 	/* check datalength of correctly padded CAN frame */
 	if ((so->opt.flags & CAN_ISOTP_CHK_PAD_LEN) &&
 	    cf->len != padlen(cf->len))
-		return 1;
+		return true;
 
 	/* check padding content */
 	if (so->opt.flags & CAN_ISOTP_CHK_PAD_DATA) {
 		for (i = start_index; i < cf->len; i++)
 			if (cf->data[i] != content)
-				return 1;
+				return true;
 	}
-	return 0;
+
+	return false;
 }
 
 static void isotp_send_cframe(struct isotp_sock *so);
 
 static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
@@ -464,11 +465,11 @@ static int isotp_rcv_fc(struct isotp_sock *so, struct canfd_frame *cf, int ae)
 	    READ_ONCE(so->tx.state) != ISOTP_WAIT_FIRST_FC)
 		return 1;
 
 	if ((cf->len < ae + FC_CONTENT_SZ) ||
 	    ((so->opt.flags & ISOTP_CHECK_PADDING) &&
-	     check_pad(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
+	     chk_pad_fail(so, cf, ae + FC_CONTENT_SZ, so->opt.rxpad_content))) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 
@@ -556,11 +557,11 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 	/* terminate a potentially ongoing reception */
 	hrtimer_cancel(&so->rxtimer);
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 	if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
-	    check_pad(so, cf, pcilen + len, so->opt.rxpad_content)) {
+	    chk_pad_fail(so, cf, pcilen + len, so->opt.rxpad_content)) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
 		if (!sock_flag(sk, SOCK_DEAD))
 			sk_error_report(sk);
 		return 1;
@@ -730,11 +731,11 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	if (so->rx.idx >= so->rx.len) {
 		/* we are done */
 		WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
 		if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
-		    check_pad(so, cf, i + 1, so->opt.rxpad_content)) {
+		    chk_pad_fail(so, cf, i + 1, so->opt.rxpad_content)) {
 			/* malformed PDU - report 'not a data message' */
 			sk->sk_err = EBADMSG;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk_error_report(sk);
 			return 1;

-- 
2.53.0

