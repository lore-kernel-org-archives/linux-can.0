Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=HJNZH/Mm8w/IZ84TybcirZwK3MRyMkPwukEwsjBWhGOEV++TnLEd0ypolImyp0XjonK3
	 BLj4HJ/KTVhJknO5af/ntwdwASLHYp7qgVX6qwcnMzD/FAea9/6wBePqqZXHWICpv/+6K
	 890f+5x6Y0vaU8um8kxn4W4dlmL1H+f43LFzK8pEDCVib0H1QLcFLHAX30EfRq4sq9v1G
	 MtAbkuM07fs8q1B0lxVJrYo8BEGMfuk0EZTcRofLsF8tA95Nq6X85eUvo4xzTsirO43Mu
	 Os35yQzGvDwAn++CTx/xkJp3/P7dMURwv99VzOUQ9sjYHAlIKedvGZ5NDDMd6SYcr8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VepJBwLws/yWoWYTP5xY2ET529UhpZOCf/pL4SI/nUo=;
	b=k6CLGuemu+xRVVmyyZyN01WX15pFlRdo3X+NhqPcy4GH0QejEycFB2O/Ssz2zDu3Tk1k
	 SU9Lk/eKqI3H84NFEy5zcdE1Qpo5qTKwbSSpBcu89B1NKipIYC6ZCvQmAq5HNcOyDwODe
	 JgZxsgdLCx5DtBrK2HkQap5XX3k0jWCiujJvePymhhpMFfBzTn+cls2aRm7+6Ov3Fbtg1
	 Kakd9fYPHIR6Lg3g04Od72z41G3Th1PgGIL5QUpaQHclhb9GHvnIo6dEpiMI6ojQVILdQ
	 rMNu1QvDDTpcmYsBquobu4kvg9KDsaWpQHZp4UPo1z1nlUxieOafyQfMhsYAMLs0YAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=o5C2ff3T;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mE0YsBd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F9606A32C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A7F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=o5C2ff3T;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=mE0YsBd6
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qiw9xX4y7mx7az6Pn8ou4Z31PPI1gEG7ydD4OHnrjvmZf5Xbo5E//3TVvMnZ4VTo7K
    mLsZL5KMJIIEQF6TejEsSGJJRPU057UN2Es5AKE4sDD/8TmhFiDYaaP67Z3XiJACq1/x
    7dECMmIIx1htkdUhRx7+Gk5OlyjBLJJ0WmNWxYTgSlP280KQG2ZWcOPWvdOGAQR6KhAf
    w4uTSrzGWZPXbIkmKUrn8ynthq/eeKW/F4rT2hj2dJnXYL85Yk6rR+FCnnjMKlLqQOGA
    FJWintDVoDboszLjJx8PyB2c/haRuy8rxL+SjA1hcEVYWpROfpQ2Qa0vXkShY/wicddf
    QYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VepJBwLws/yWoWYTP5xY2ET529UhpZOCf/pL4SI/nUo=;
    b=BmGcJFl3z9oiIi6T+HAEvuSwNLVv1mvTTqIfjPTLVwB2OvXdiidLv07j3JSgkKfZgq
    HP/ctrjzAgv9ebJ+VM6OLnoHVJQb6+e8MK5ARKnGGM+rZMiEBFwSz9q33ecwyaX8g8/g
    qcMbwD8m4hgOzoRNSHnAuU45kqIKQkcKwxTH9e8B2dkt5CVRc9KGBEDM8tjRgZHchr1r
    1YsLM/wb3suzWhPnPbwjtXDsfVNfq3PoIER4C67r9LvtihaOaBaYdXyBJS4PcMoTNlwQ
    HV5TJDELbmJzUiQ0kCcr+jc6IVBAUZGbjvHf0zXV4Y6Ejsnxbmz3s9jI05XwxDxOWHwK
    qABA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VepJBwLws/yWoWYTP5xY2ET529UhpZOCf/pL4SI/nUo=;
    b=o5C2ff3Ty3bxeX0OHnt1zF1EfCJvF8ZQfVCqiaYGPwV7Sf1v0hgvpi04Szf7Pt0zNy
    T3ZEcYwWBE/ovFx6jtYb5Yj5SS5cIQgEVPDK4WxMnVKcXhjG3HVm+7JcWrtcwXgbfibp
    sIRj2e8EW++4zcqtvOD1SxbSVv1fDFx3NlaZg954x1blUM04Rgdz/dHU4Ng+7ULHFTqt
    Uj2xZH9jfNWwkmzYbthdeYhTLZP8tV+eJuFLWvNKdCp9RiLSPOz7A544YvCxA8TBolyZ
    NJ5eiT/9KYYp4FJ9gvRmrj0p+gUt7tS5q77mo6CPFh08TEoiXXCnmsZnAB/9ZwV6sUgH
    CCqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=VepJBwLws/yWoWYTP5xY2ET529UhpZOCf/pL4SI/nUo=;
    b=mE0YsBd6W28f7W2Lu+MAkA++VfjhIxffc2SSkdfqYDEBdNjDFKrJHcuJQm2iUlqeDZ
    hZ62AOSMBWDhZ5q7UtDw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUb
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:47 +0100
Subject: [PATCH can-next 05/22] can: isotp: add the frame transmission time
 to the protocol timeouts
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-5-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Wentian Ye <yewentian395@gmail.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=3825;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=qDAD/JNlwgT6khMCc6TjDTkjlsakdBN0QqsPX/wNr3g=;
 b=CvfBNslWXFJYsJntTrHUBJvHdxWqy6rE03XkkUQaXCQmp3Q8GFUToJewiZsB3bdzMxyr2QMwE
 v8FZL9qP/YtCOL/cUfsezFKzFKg5RUhPYsLxmwLAIvurI/tS1UI7sNi
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

The frame_txtime element of struct can_isotp_options is documented as
the frame transmission time (N_As/N_Ar). It is added to the gap between
the consecutive frames in the tx path, but it is missing when the
timeouts are started after the transmission of a CAN frame:

- isotp_send_fc() starts the rx timeout for the next consecutive frame
  without the transmission time of the flow control frame (N_Ar)
- isotp_sendmsg() starts the timeout for the first flow control frame
  without the transmission time of the first frame (N_As)

Add so->frame_txtime to both timeouts to comply with the documentation
in isotp.h. The local echo timeout for single frames and first frames
without flow control uses the same timer start in isotp_sendmsg() and
gets the frame transmission time as well, which has no effect. As the
value now extends the protocol timeouts, reject frame_txtime values
above 100 ms with -EINVAL before the options are applied.

There is no separate check for N_As/N_Ar timeouts, as the transmission
time of a CAN frame has no real world effect compared to the protocol
timeouts of one and two seconds.

Reported-by: Wentian Ye <yewentian395@gmail.com>
Closes: https://lore.kernel.org/linux-can/eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net/
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7be3d9322ad1..197dc7bdb6ec 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -125,10 +125,11 @@ MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
 #define ISOTP_FC_WT 1		/* wait */
 #define ISOTP_FC_OVFLW 2	/* overflow */
 
 #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
 #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
+#define ISOTP_MAX_FRAME_TXTIME_NS (100 * NSEC_PER_MSEC) /* max N_Ar/N_As */
 
 /* so->tx_result[so->tx_gen % ISOTP_TX_RESULT_SLOTS] holds the packed value
  * (err << ISOTP_TX_RESULT_GEN_BITS | gen) for each tx generation slot, so it
  * can be handled with a single READ_ONCE()/WRITE_ONCE() access.
  */
@@ -347,11 +348,12 @@ static int isotp_send_fc(struct sock *sk, int ae, u8 flowstatus)
 
 	/* reset last CF frame rx timestamp for rx stmin enforcement */
 	so->lastrxcf_tstamp = ktime_set(0, 0);
 
 	/* start rx timeout watchdog */
-	hrtimer_start(&so->rxtimer, ktime_set(ISOTP_FC_TIMEOUT, 0),
+	hrtimer_start(&so->rxtimer,
+		      ktime_set(ISOTP_FC_TIMEOUT, so->frame_txtime),
 		      HRTIMER_MODE_REL_SOFT);
 	return 0;
 }
 
 static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
@@ -1331,11 +1333,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		wake_up_interruptible(&so->wait);
 		return -EADDRNOTAVAIL;
 	}
 	/* WAIT_FIRST_FC for standard FF, else stays ISOTP_SENDING */
 	WRITE_ONCE(so->tx.state, new_state);
-	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, 0),
+	hrtimer_start(tx_hrt, ktime_set(hrtimer_sec, so->frame_txtime),
 		      HRTIMER_MODE_REL_SOFT);
 	spin_unlock_bh(&so->rx_lock);
 
 	/* send the first or only CAN frame */
 	cf->flags = so->ll.tx_flags;
@@ -1749,10 +1751,15 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 
 		/* only one broadcast flag at a time */
 		if (hweight32(opt->flags & ISOTP_ALL_BC_FLAGS) > 1)
 			return -EINVAL;
 
+		/* limit the frame transmission time (N_As/N_Ar) */
+		if (opt->frame_txtime != CAN_ISOTP_FRAME_TXTIME_ZERO &&
+		    opt->frame_txtime > ISOTP_MAX_FRAME_TXTIME_NS)
+			return -EINVAL;
+
 		memcpy(&so->opt, opt, sizeof(*opt));
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;

-- 
2.53.0

