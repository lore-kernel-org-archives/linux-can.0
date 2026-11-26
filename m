Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727162;
	b=o1We1N8SgV+GclgYzQnNfCEYMREkfG7y1p4cg17ZsQ8rYVUAMEEo6qHniRKcUyRejaD/
	 a/ZYR9AgZxKFQlkhbb0mzknJX6ZG7SFc+Kmn0VxuuR5AcXCTREucOzHBRWzkzhQPsSaf4
	 hB5QYCkZrI7mgV/k758+ux1Ztz4jzjwDaOKoCs56/4rAXO0I7UFXB4IXMGOzIkCap8ji8
	 xA00FcA2o6NHSxHqiialcVso/NyJmNy+ZTmXYbePxiKE5htU2Vn3s1ByVzF83RmH26OxX
	 UMg7UqgTn8dcbqalpIGCn7yPgASFyq+aurRp8rok2U7msOG/LF9Kw84Myw+Jwnehoew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727162;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Og8uWJXkuTUoOw8gNpc/kA7ElTxOA3uYamoUjJffHOw=;
	b=oWDMcCjjn3JIhjTuENEQSslAM2TrSpf3/qX7MrLWC/YWw063NskfJGvO8LryyZhmJoi+
	 xI/yjkBU4rZf4MNL496YgRhwG7fyvP8ldbJbPpFRn+7ZYx4WzwYzKOwYSjmnY0ixhUg5u
	 VrqLLBuNh6Z4+3P/LuZckSMB2MGqA21kj+UmwLMSiBMHJ3/YN/9m3jexuOW/vmIGr6sTr
	 2KvontZVMaGWqXvn1PDIjE+kw09eQX3Cd7gC+GOVZmC6XBA/0i5Xt9OoDaq31XKyEEsa0
	 QjnzrZtpHfhAkWSv9/xRSTXCk6oSSPgQ2RgtoYlwGOsV4Tmv9PaeyuJEyTo0pNsJ9XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ZLxMi11k;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=835QFRxa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.168
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCD606A327
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CCD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ZLxMi11k;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=835QFRxa
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rsOZiuomWC3VS+hikXAbY/VS5jBkM+c4k0hYUPLX+a9vobI9Qoj+sg6DojWFO+rtsn
    31zgutRefhz2j5oUW2Dzq37G2BoXu4Oi5z/Fac/Dj5C56n8lTgmxXCV2/NYo93WoOEut
    lmtc3iQcvbp2Iv3e62jNN9lERzhpv4RVqVNrvGwudOtQaJJHplD5bBVnl+MpYHcoWJIW
    puD0p3ZofJFsDXLqkWrDlZS0RSRuY/xAga7HS/wtCzcqbElGXoeRkOIOsHAwTJO1AjQ8
    2dzn1CXdY6Ne6MJDpcAqWQcdMxpE+/QlX0IxzXCnhtVcHt6KxkiQyvRB1CvUGBykjkSg
    o7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Og8uWJXkuTUoOw8gNpc/kA7ElTxOA3uYamoUjJffHOw=;
    b=D4j4Wpkx9ujRCahbeTmtMPFfVkhdLjmoMTaepB2oYfuN14wgyuQS5ZtGd2/1jbzqwv
    5KBhUxcrtipllK+wXyiC30G0nSrfsaXf/qovnkm/+Nokc+7bcQ/5df1ZwgfFupqPEi/4
    n1P20qaEpTsffb02kKPNyXdKRstwJgcypyrOk9VsQVGlfnFqb++hi6OaxaRdZW7ta+AL
    mH+oze1AkG7DHB6exT3V9ww6SVWxyZ56Jiq46Ycs0zM2ZGSMBaLygYzjBaf3MNPtOOju
    e0VyYvfZ+kPIebzzDd6ll+LEpQ/Z9HP3Dv4YKDkJOMFDPdgB95Wktn2u/moigyDDBqE5
    AD2g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Og8uWJXkuTUoOw8gNpc/kA7ElTxOA3uYamoUjJffHOw=;
    b=ZLxMi11k7ek+HXe9XTl81hGsi60bn6nQ3Zx1fBuAdKt2hgVlzyDwyp3dcoTD7PpPR5
    lePshGXvDMe61/RN0RCH2I+PMrwW1JteOpgKO0LLbhaaHO/dRuXAhEzy75fO2C1/sAGG
    VJELwNX3pFW/wKGB8ah/kSuxgY0hHXHTvEKwbaeYPwa4/FGARHQBlLkC0dB9/xcQJ7Ev
    RTvFSxqH9FA3UTT6D0Hfu+uxT6kbfxQU4gbCS+HAkD4Lr+YhGysyzskB1HjqNqZwi6Wf
    H/birhYDW7QO1wt4DRCmsGiLg1qf4hxihJb4iAfzjkse1MSi2YNfXixcNPh1JjXZzz/S
    WJAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Og8uWJXkuTUoOw8gNpc/kA7ElTxOA3uYamoUjJffHOw=;
    b=835QFRxa7rb4+qKyLtu2ItWjxq83Z53jASXyecJj2S/GoaV3kWRD1lVDtRWUgR6Kpw
    3o3Y2xrFJ/U39Fgvk6Ag==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:06:03 +0100
Subject: [PATCH can-next 21/22] can: isotp: rename pointer in isotp_rcv()
 prototype
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-21-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=887;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=QHPh5ECW18I6mnAzNaAOLbw9dVZm5CP4nb1wGu01nsk=;
 b=oz0AjqgB7RPlorAzTFXZE830WfWT7/QXEgtPCPE8jd0OxJzL9UdklwxJCa19Co4pD0fdsk1ne
 U7644FX4bo3ALrpGqL0f0BMEH/8cdm8Y+nROB2WGoEVtDPqQ4y4tCAg
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Preparation for CAN XL support where a 'data' pointer is commonly used.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index a9182588aeb7..47f91e88dedb 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -770,13 +770,13 @@ static void isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	isotp_send_fc(sk, ae, ISOTP_FC_CTS);
 
 	return;
 }
 
-static void isotp_rcv(struct sk_buff *skb, void *data)
+static void isotp_rcv(struct sk_buff *skb, void *skdata)
 {
-	struct sock *sk = (struct sock *)data;
+	struct sock *sk = (struct sock *)skdata;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct canfd_frame *cf;
 	int ae = (so->opt.flags & CAN_ISOTP_EXTEND_ADDR) ? 1 : 0;
 	u8 n_pci_type, sf_dl;
 

-- 
2.53.0

