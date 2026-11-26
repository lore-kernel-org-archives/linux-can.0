Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=yI1DZ3Z0lddL9xIYIC+ryrUx7SxYc/sWBbHkeSQ54mlPgVNdKjt+F9sbrXc6iYMqWrPv
	 xJPqocZ8w9kUhP5JIF0Ltk3vilbgu5RjnJOZCl9U9quNj5uIEW25gtDR5FbfXuSeF1uCP
	 RKl086MjTL76OgMCTJbSIcxBkZnfFRRHOa9LceOGhTmBLqxvExw7UDYtOdxMAexWyMVec
	 eeFRQcc3w3iItPbv5Z9Y6QEAXNGb/RYM7iL3AhYNFbQ7+giuqLQWcuLOrObuvyNcMVV97
	 N/Vb5QUlpkGHc/WqIJiPDVG7A7EHYwp+MZH4Ukv/n49+8z5O3rC5cycUTmoKBQujmRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zn3auz93GmTHlxrEV4O5Hgw5tchZxgNXEqP2QAfWF+8=;
	b=Gi63yB3Owx7J+hu80bRhj56cc3xjjlRlKEPDozI0wCEvVrVJxDfwmc9T0RtkcO7vISSM
	 2vpvl8183Wbzyokb5FU/OgJt+lABF4ZLLNOXLJZeKTWKe5bls89xRNtm1q2QtyQtbdAtQ
	 qYeqeT4q+cWh+qm2lQjgKgsnMkobG9yZZJwhyp6r1NcaxUsNvqFkqseaWxfNi9jIFwYA/
	 WpQnAPXH7/kXpYCcii0LuB6ELhI3BhPKaxELabeSnc1ulF1U6So7RlpKEpbsLFtXSeBUn
	 G/pEWuBEL30ZqaCYxs4ZF2hMR0mr6xdCuR9eyrQG2gbfNbb/Sc8VxrwwgBvhe/M7o/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ssn6tK9Y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=IwC9C6H8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4C606A323
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CC4C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Ssn6tK9Y;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=IwC9C6H8
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rcWDrAAzKjQVrEMJfz14GlwdNJZoOS7dRbicu+5vLr9EnFf32SMMyL4Ii/raIksl2O
    JECy686DQXsZAvTMgDsgjb1bwqnhPiHClANSCi3RX5YlKvK+qbnNfnbKOJe6UxT+XFpe
    uV1Sr6JlvaFALQvRKKkHbSo1klB71uj9hWnvBGC3JSxB6Z+/95yMHmI8Vx2QSytTzTUQ
    GfvApQoheb38GPTwPAB/7fJrP19kWkhbwuS46XzcUKENeiytpQhCVftD/OldZ/ryHxUg
    QMU+h2re3Ap4L2yWd6Iucfdbm0rN6TsWMFv0PqM38cojJNPh6Kxtw4y5y4bemI4eTQhK
    OwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zn3auz93GmTHlxrEV4O5Hgw5tchZxgNXEqP2QAfWF+8=;
    b=sJqC3HSDj+NDOzPmTZpQ1SaKK8GKiyGXlEDAqU6AR1KhzTNga89MN1sQjBClyVPvqq
    hJeGxhYPGLSUvEbQGoWBDtVoXcNdAdtBDvtIMXKFmbV+vNyE6BcKfAwhtaPNRu9fxFWu
    7ukWAD4lnUe8STbQ/dBx23+LNZvwE0TQNRtSOk2smGYCEZsTWlctbNrj/acYltlQ74d2
    hhcCx1ElODG28pOM4RAmuurCbz/dhsD54L8EaQ1HcL9tEwn6Ren5DL3BV3+98JCCjOYg
    Jq0M82GVaCXNY+Iel2ozSv3e1TMXhAPB9L/JY+ds8BRbsGrBQOfIWrK90XQ3ypFj3cec
    37dQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zn3auz93GmTHlxrEV4O5Hgw5tchZxgNXEqP2QAfWF+8=;
    b=Ssn6tK9YRJXXx4SX1+sugoMH4Z/BfnECW78POT5MqT0dV9fPZ4bZiwzCAuVcMZWB53
    neGZss+5evg6Op5LHCwAjmfsOOCOnEpBvxMwAMM7H4qcq0+mZgAnk+gh8ZwDgBd/7IID
    drY1oraOJ00PYZGwByNsCAhArI3dTBVmhROp3KZp3PnXUXg5adDJHPv/AYRX0vmfGSlh
    F5wRCoWIUY7fa6XhsiN40QwFlxMgRqCCLc3lEdS1HAq1D3eJUovfgx56ZavRScb25K6x
    RU5thdWN4xr67wH5UvY0chvcdSYZk8qvWMrBSzKYl4M8iowUwfjv9m1itS70N3/mnvBK
    LeiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zn3auz93GmTHlxrEV4O5Hgw5tchZxgNXEqP2QAfWF+8=;
    b=IwC9C6H8mjgupBdxT76Lx0EJmXzkEVnWXHLCujiCLl0QNOGCe1Wp97rYWEn8TAxNWh
    oCg0u8Rlb9aMKmFKkPDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:53 +0100
Subject: [PATCH can-next 11/22] can: isotp: check the minimum FF_DL
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-11-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1898;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Fdlier7u0xC2pZ2HlJlLgpn0J5BfzdejYgCibPEsrMY=;
 b=umQbaLDgaDreT+8J7A/wE2oQ7wBbP+CsS3H+SQF1i9DNDvhZzoI3UByxGmighOKRDLSaL4Ejn
 b9MSxXLuvNZCqBuTCpEH6LlVD/EUhliYYQKUDpSgnQNs7hcpn1Symwf
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

ISO 15765-2 requires FF_DL >= FF_DLmin: a PDU that fits into a SF must
not be segmented. The rx check only ensured that a CF is needed and
contained a SF_DL escape offset for LL_DL > 8 which is only required on
the tx side. So e.g. FF_DL 7 was accepted for LL_DL 8.

Check the FF_DL against the maximum SF_DL of the sender LL_DL like
isotp_sendmsg() does on the tx path. As only FF_DL is on the left side
the check does not wrap around for FF_DL values close to 2^32.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3167a0690b84..8aeec4ca1d19 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -573,12 +573,12 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 }
 
 static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 {
 	struct isotp_sock *so = isotp_sk(sk);
+	unsigned int sf_max;
 	int i;
-	int off;
 	int ff_pci_sz;
 
 	hrtimer_cancel(&so->rxtimer);
 	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
 
@@ -607,14 +607,17 @@ static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 		/* unneeded escape sequence => ignore PDU according to spec */
 		if (so->rx.len <= MAX_12BIT_PDU_SIZE)
 			return 1;
 	}
 
-	/* take care of a potential SF_DL ESC offset for TX_DL > 8 */
-	off = (so->rx.ll_dl > CAN_MAX_DLEN) ? 1 : 0;
+	/* the PDU must not fit into a SF (FF_DLmin) */
+	if (so->rx.ll_dl == CAN_MAX_DLEN)
+		sf_max = CAN_MAX_DLEN - SF_PCI_SZ4 - ae;
+	else
+		sf_max = so->rx.ll_dl - SF_PCI_SZ8 - ae;
 
-	if (so->rx.len + ae + off + ff_pci_sz < so->rx.ll_dl)
+	if (so->rx.len <= sf_max)
 		return 1;
 
 	/* PDU size > default => try max_pdu_size
 	 *
 	 * This buffer is not accounted to a memory cgroup: In softirq

-- 
2.53.0

