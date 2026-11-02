Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634829;
	b=c2yPwUqltLpoHw2h7zAlqVn1gHsVEImhzNoJITlf3KU+8L/frubSYCN7CU1Gc3Ud3kXM
	 I+xc0DdaPDVrfEd/awd8PLfZbKbuK0l6V+PppB+80xetNkLYL533AO5WDv0zTwQllj2Ly
	 bDb8MufxRuzj36uFsJMHsSqRI7jR/PTQeR+5uAfIaMN/CCfxWPpsLKij8MN9iZeSTlESY
	 xKL85C7ZxBg5uaP9aB18Xa8sAufPksWsKR7CHcVKrgxW1Mnxj50Uo2Oe/t8KsBsXP4N9c
	 2RNbnPeHdfwxwyynk3ZdWBVwcGqDCoyTpCN2spFcOIa0TX/ZSFWQuFWoxPLZ4tsf8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
	b=lpByKaUKLsyV4kWqilxSB5GZuOK1BfZBZv+CRfVk53UWknKAqFCF6g3+3tUiOZ9qIlXy
	 D8S78rXoJx6sHu6EoclfUw5vqk61po3mPqoxgXfZ2llovOrsnmwagQ9z0CRXJihcXywb+
	 +01hL5f1cq0PRJSzVB88go2ncu6dXefb+vwkFiiovI/MbDM6dsO+dVhoDj8ACtQP8i6r8
	 ewY609/z6M9uKJm3rQn7mpLmvD7+Bu/JRWBH2ztGtH3mUkOxxxlfvbUO9GPnGVFoaFAp0
	 p1EMvHdDWIO+1OWHEVNZc9unjPAGu69JilxIsJjOJ1arHymZZBhUMdqE0JcoBOhBy6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMMEAWi8;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7960B426A
	for <linux-can@vger.kernel.org>; Mon,  2 Nov 2026 15:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF7960B426A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMMEAWi8
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a208d93758so34087755e9.3
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2026 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634828; x=1794239628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
        b=TMMEAWi8OpwvmknuaspJNf3sj1bU7MxlY242AWQesYlBZ/usL9Bywm5GHfkWtMROp5
         ipLMX38R/AKcGuj0K2WC4C16+/gQ1c+Z+MfJMmMoDP6lwF83DKvqMZj8oGVukOHXAb9T
         LkKj8P89txbMlyStiITy99kS2mDCIPnMsQpmvVmMbRMrObp5iYbiqXiSk4ynU9cnbQ7W
         mliwaabz80QqnFNlleAzFQiU5h0QgFTVucVWFHh7DMhecGwrj37bSeXcV+S8oJ9Y8h2E
         lLdrW/bvnvS6QskO7aL1mGOC31H3S+szj6rcqAnu/SR4MdWddbADxqgne0SGVmpKV+sw
         vfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634828; x=1794239628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUOMvaywSnfPxZ52C8XL24limR9Py8D4CfmjHsLDiqQ=;
        b=vVi1XNdb6dA5ifZ6wvqDj4EFUggTVQu9Of4hMXk7D4bvk97sHbOXS47pp+HzC0UQTc
         lGumos0154KwYHYezlPWIaQhL0AESKt1np69SVo2LD4dmQcGITOJsebcGigkfzBmgKZJ
         i10G6hZ0RXHr4p1NXfXGzvtO/YL0+TVlVdpSRXninGrJGPgPDXFDFHSCTGTRUl8lHFtF
         UnWcDTb2rt8MPmXknuPNmhBar0mWa3b/XqKYI2inKPf23j9/OQZZzqFOmSrH1FcvDKoJ
         SUKO75k7YmTgcnI4oAB9QCVVOG1zQureF6IEPjzKvCRvPsNiimE7VWldYdsZLS4WIzC2
         YuJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvAqYj7OpeR0WkW5Homwc3tol/CeAdphOhqFn4HvhgzHA7U9yNWSNPDNss7BJXSgPMz4FAGjLMu1E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5NJ0fmHOcgByHK+wa7mG3qjVBDtwm8aKuvm51kiQwACpw9DsQ
	iBrT8qlBt/GN6tHBcuQxHE+WogqaKbsZybSJ4uOflg4rjmtOT3uPgocDVDN4
X-Gm-Gg: AYBFou0PRTDCVsrAEcTv5+3kvd6PB9n8VFJF+ONTh/w92n1lByqVM1Le+E5gBeUVN8D
	2g4Fc78T/9+2Hm619K/6jJRv6QFgowoNu0qv3jjM4shwpG54u/84EaMVy3YNR27FkgFsCBm1xJK
	rop5XWg8zD4FXwQ5XT+gzxtEbGnC+lFE3HYIwzjxCrAjfVlctHF7yKX0kyGTX7jpwlynyqFmzew
	bxCcf3TFv9XKXBLxKXSVqB7iKamOhUkgQdSWVGxLEpJakROtBzOs+VeQjgZP/YlJkuML0XadKWF
	eIBDZNabEAdc5e/2FCJoLLCZpJms0GFPJYwaQ0fuwNL/3p1U/H8MH87VAi1N5Hhe8PFaVmVUyKG
	9alGwFnA/aGmMore8CwPDverGT7wX6sVZlFtDmvajG7rPiK1/SlRA8nc8rDx+wf3RpAiWyKHPks
	zJGcNwhX3ltvi1AU0dmr9LKD2yCzTY/KjNhBUOGYoD2OvHHqRLto+9D/H9gd2R3PsNShGc/zqxj
	4i6RROUTwECNWAqg+BnsT6OKZYTnKPtPOLA9lDXOqbKIxZf391IqP73n5HU7CpyCJAQUDVtKNOJ
	ENDHMJLs2mc=
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id 5b1f17b1804b1-4ac1932a12fmr235060725e9.31.1793634827520;
        Mon, 02 Nov 2026 07:53:47 -0800 (PST)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b286a0sm234689275e9.4.2026.11.02.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:53:46 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH net] can: j1939: fix skb refcount underflow in session teardown paths
Date: Mon,  2 Nov 2026 15:53:45 +0000
Message-ID: <20261102155345.1267524-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

j1939_session_destroy() and j1939_session_skb_drop_old() both call
skb_unref() followed by kfree_skb() on session-queued skbs. Since
kfree_skb() already handles the refcount decrement internally via
skb_unref(), the preceding explicit skb_unref() causes a double
decrement, triggering a refcount underflow warning on every session
teardown.

The extra skb_get() reference taken in j1939_session_skb_queue() needs
exactly one corresponding release. kfree_skb() provides that single
release by decrementing the refcount and freeing the skb when it reaches
zero. Remove the redundant skb_unref() calls in both teardown paths.

Fixes: 8c21c54a53ab ("can: j1939: j1939_session_destroy(): fix memory leak of skbs")
Fixes: 2030043e616c ("can: j1939: fix Use-after-Free, hold skb ref while in use")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/can/j1939/transport.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..3173936bd6f6e 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -277,11 +277,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 	WARN_ON_ONCE(!list_empty(&session->sk_session_queue_entry));
 	WARN_ON_ONCE(!list_empty(&session->active_session_list_entry));
 
-	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
-		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(skb);
+	while ((skb = skb_dequeue(&session->skb_queue)) != NULL)
 		kfree_skb(skb);
-	}
 	__j1939_session_drop(session);
 	netdev_put(session->priv->ndev, &session->priv_dev_tracker);
 	j1939_priv_put(session->priv);
@@ -342,8 +339,6 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 
 	if ((do_skcb->offset + do_skb->len) < offset_start) {
 		__skb_unlink(do_skb, &session->skb_queue);
-		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(do_skb);
 		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
 		kfree_skb(do_skb);
-- 
2.47.3

