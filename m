Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044040;
	b=x/pCUPpGmnx/7h8eSb2z87hUQBZbgGPASEGs/ykBVdOL9r6OCawJZ/yo1le/8StBC467
	 M4lQe8RZATK0u53TwBZowizBAE6AP1DP5MqgYweb1IdEuGrcIcS1V1D+gyZcHbteuJm8y
	 zYoIUCmCM7sXr1dszG72guJkvls51RBpG2A0xwYTo/TSUpyrbnWu8MkqkX/MYM1eIO4DM
	 LQHboKc4Ih2CPg6Bj0Y69VrJl6eB9FrEmUsOVKaKPzUxaLYNsICHTOTmdPpEM6cuHYNFl
	 uxEtjeQWZ5xDPepMBFbtrar6v5tby+hcOexTWztxn6pPtiusxFJuBdxsDnqG+NxIBEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q3jpq2+MXNxGzKl4NecCd6idtKIS5qP1a+mIStW0Fg0=;
	b=TYAWh3nj78R8MFpAz0/Sys5+vSmkWHwdK85+2Rq5tWvWT015W35rutwezbolHsBiuYKL
	 ks5sT24+9JNWSHqalJ7LcCgbRcy4l5iw3RNE9AHCu6GbUgP0cxG6rTtvB4UZhzgtbRPbe
	 BFMivYShOFhRp5NUD+HyrF3YtA0MBLqK1DiPpVqDePncKVDW9HxhhSE4+SSYDxqaSnGlF
	 xZlHW3ky6+8sYfpnUAKlRN/a7LAZWjgeM32V7XSNZF7AY+H8tO3v/oisuTMzmdLYNHGzS
	 OW7it1vTVvyA+D0yikrCs5ZKPzz+Xe7zb2HS+8rXF9missnM+/3Qr1GDNGZRSpd7JFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nxWCwmno;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C2606A31A;
	Mon, 26 Oct 2026 19:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=nxWCwmno
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jD40713f5zlfvpW;
	Mon, 26 Oct 2026 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1793044036; x=1795636037; bh=Q3jpq2+MXNxGzKl4NecCd6idtKIS5qP1a+m
	IStW0Fg0=; b=nxWCwmnozcT7joYiUw+sRL+paCYYCkiGuLuZ3jmrJMqPMiwttQ8
	2cO0IuN/kJtBTTwvt/xagZx1bOZcfOCM1HyFO6dlt442gtoyrPt+eiuQKU+ay6kO
	lWb58tJNlrZKTa2AW1AeT9eMqdrymkvEqRlGzfph6RCYh5S1/CPAVXPHe6Q2jOkK
	s/frsaWW+s4wbsC5vHYC32l2g+3MoMIYafZhj5PdfsH6oMy1MXI8nO9RcmGZ4HYT
	ND3qDdYIWmLQvUYxTIOGO81k+g4qM6ObvR6w2fX9pIgRfOfJ/1q2DpwBLHYF6K08
	2aeG1S1ZavGKqeV2WtUzovy/49xbAb4WT5Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RDKsrWgYk5Jy; Mon, 26 Oct 2026 19:47:16 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jD4034H7RzlfvpT;
	Mon, 26 Oct 2026 19:47:15 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] can: softing: Fix locking in softing_card_shutdown()
Date: Mon, 26 Oct 2026 12:47:07 -0700
Message-ID: <192450922df0eb9ce0cebccf381363680db65604.1793044027.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If mutex_lock_interruptible() fails, softing_card_shutdown() goes on
without holding card->fw.lock and later unlocks that mutex anyway.
Shutting down cannot fail, so use mutex_lock() instead. This makes
sure the firmware state is always changed with fw.lock held and that
only a held mutex is unlocked.

Fixes: 03fd3cf5a179 ("can: add driver for Softing card")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/can/softing/softing_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/sof=
ting/softing_main.c
index 519ab3097f86..d3dfad4f5321 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -448,9 +448,7 @@ static void softing_card_shutdown(struct softing *car=
d)
 {
 	int fw_up =3D 0;
=20
-	if (mutex_lock_interruptible(&card->fw.lock)) {
-		/* return -ERESTARTSYS */;
-	}
+	mutex_lock(&card->fw.lock);
 	fw_up =3D card->fw.up;
 	card->fw.up =3D 0;
=20
