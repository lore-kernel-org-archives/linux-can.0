Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232167;
	b=AQmzFloGD3ciF2FuWu1LT6fC1InoCqEaT37TdyxARXQ6c+tC5ZlwCoaWmJ9gTDN+d9er
	 Zfo15CVY5KYhxpTHXY0cEVuet+NddBlsoe0t2ZJhu4psTtnVIPiblf9TZ3LcFtWLYWfG2
	 h4pNORXSYpfRwXPoVUHE2p4sdglOglqgk+K36KLdczHnt74Eyt3rCn+KqCULR6RovfGxL
	 m8MyHvwzlP7906pYXOIM5gONrVDhJMIvcECaBsodqQX9il8QBUDuVE7g87ldcmbpzId2L
	 dpMH5yTFgylT20eT1LZ/MpBStJs0VjAfKka2Ry5CcFPR0VuWkno6a1d4eHJr97PWqhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232167;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=lFoOw2z1RAjxLnDKUL1Bl6y0aTRZqOha4gS26UrJ/i0=;
	b=QE5o8Lt28Q1rOnmQYmIXMsHzZ7Gcv8CbMF1FKxKOeQ9OyOZutSJkXaEXC007zBIWVbZk
	 HX/4FshoC3A6dWzqYDOBw7oJM7X1KJWzt86goba3un73of5edq6H2MUZLxWuyQpXQG118
	 8BKIJ5WxU3hh+0Xwa73ELHvhQJbFlcMNiJWsx1vdFjibPnpZ3QLSbrzVj35zlQsSGvoZC
	 zlJCkZ+e8fvIFe3ofE36k7Ere1XRWedSDPOl24MLbefKz18iYpPLa6lw/nGy5jfV7Z334
	 v4cAG8YMeVr78R+fgQxaHQacaNTJffex1onkwS3GOG2MBnB76TucGfzKCq8PPBqM4vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=l7rl9YuU;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AB606A334;
	Mon,  9 Nov 2026 13:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48AB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=l7rl9YuU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=lFoOw2z1RAjxLnDKUL1Bl6y0aTRZqOha4gS26UrJ/i0=; b=l7rl9YuU1mNWkiESURsxYeqg2T
	OArjRb6ekb7UzxSd1vuGY57JDivd7ufBA7GMvK8Wmwn/iKDQaRFPXBwqZn1vQXdaFaev+dF2/b42k
	Ah8ktIvNjDGxmwH/5ONul+ycHLjgMP/c++8gVxqh9oTJFMvRO7DvA82EcYfxH3mMm6m+7eaiIauXp
	GNbwATTm+mDcJrDRK+zM1ppN4zZRWgJdcnGT3KJqyzUpDAQ5FDKyqYcp8y4nwnpvaZwbKZYzLqDS/
	tUAoWrQpfosVsoBqv9YTvFwOuX/oAOxRSED+3g1ct4vHvuqNoF28nwtfaRJlXRylp27OOfwLzkWFK
	GyYwkUyg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPkT-00BfMp-0R;
	Mon, 09 Nov 2026 13:49:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 05:46:28 -0800
Subject: [PATCH RESEND v2 2/2] can: isotp: convert to getsockopt_iter
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
Message-Id: <20261109-getsock_two_can-v2-2-763f87fb49b2@debian.org>
References: <20261109-getsock_two_can-v2-0-763f87fb49b2@debian.org>
In-Reply-To: <20261109-getsock_two_can-v2-0-763f87fb49b2@debian.org>
To: Robin van der Gracht <robin@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=leitao@debian.org;
 h=from:subject:message-id; bh=FJnCAijEnJL/dnfukYsYGrSRabAaXyy32MkI8GxZn0g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8c9ZrsMFSw2Obxtdc6IfrYqRQtW1UZ6TByeFN
 3jchaLXV0aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHPWQAKCRA1o5Of/Hh3
 bTGTEACVrSvdoNGefaKPNZ/f95negD5kq34teOTuQA6AdnK9FsMoKXk5mUIcOWmIEgHC9W0qEgo
 6fosJmXbXsYW+3H6RWW683dthdD/uJE5/AaSry0Dwtona0cH0JDYZw+uwiqKWOEPDJ6lW0zYTFN
 kM24FL36puiTwSeyTRMzzMEKMTL+NjWa6/0SaJCv1T32kCdEAi1YslMLqCR0F50MvtCfCsRCBVI
 aVtnCks6kq+C474nYLoHqpEVufS47iq0dqlMaLWP8h5ibZugJPTOsB0fRToDHZiFsxNspLKemty
 HRJzbeJH2NjC7C8PWfojApZK1Jb1Th5NOit4NSym5eWnCdLRDQyXIYrkwFpvLkuJmxhUerWEzgs
 yXUsXnX24GBA55ugDvDmYVXvjoib6TDMtV/9SQO/KtZRZ5CFOGn/xPr2K1qq+Yf1kcmRs2VxDFY
 kvhFubqpXztwyTLeK0t2LHuzKhY3JTyqfLP989LLuJYizA7srb5BSeVSYDEos7IObvZ9btePDMR
 o30IOwb/DCqkRyr7g7ZyYamRW7Oe/zWSIDn785RbSzQo8VMw2smuvw686vWPDjcMCzgegl5n2CK
 P7i/KVqn8zP4ha9Xk+R0a2bEffDEAaPDMlz+J6C1XCaJayF09yMLuVUgFaI27+JQ4CWYzriM9f4
 Ei70w3ZN8CDD6Ng==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert CAN ISO-TP socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

Key changes:
- Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
- Use opt->optlen for buffer length (input) and returned size (output)
- Use copy_to_iter() instead of put_user()/copy_to_user()

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/can/isotp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 7a90ba3f1cf1c4..a1efe026dfd15b 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1838,7 +1838,7 @@ static int isotp_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int isotp_getsockopt(struct socket *sock, int level, int optname,
-			    char __user *optval, int __user *optlen)
+			    sockopt_t *opt)
 {
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
@@ -1847,8 +1847,7 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 
 	if (level != SOL_CAN_ISOTP)
 		return -EINVAL;
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 	if (len < 0)
 		return -EINVAL;
 
@@ -1882,9 +1881,8 @@ static int isotp_getsockopt(struct socket *sock, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 
-	if (put_user(len, optlen))
-		return -EFAULT;
-	if (copy_to_user(optval, val, len))
+	opt->optlen = len;
+	if (copy_to_iter(val, len, &opt->iter_out) != len)
 		return -EFAULT;
 	return 0;
 }
@@ -2075,7 +2073,7 @@ static const struct proto_ops isotp_ops = {
 	.listen = sock_no_listen,
 	.shutdown = sock_no_shutdown,
 	.setsockopt = isotp_setsockopt,
-	.getsockopt = isotp_getsockopt,
+	.getsockopt_iter = isotp_getsockopt,
 	.sendmsg = isotp_sendmsg,
 	.recvmsg = isotp_recvmsg,
 	.mmap = sock_no_mmap,

-- 
2.53.0-Meta

