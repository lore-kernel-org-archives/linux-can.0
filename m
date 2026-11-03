Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793683476;
	b=nJeGpRZOz57NISgC0yawmMjJ0diM91+Yo5nUYM/aMILfw8yiYavF4blHnglZAkjVU9W3
	 3Ka8n93nYRpJvAz4QWX/0REiofy4oycNX2HoaGa5jeEyDOqnPDUne2Gm1dXaO4IVNCh2f
	 qIBWI4KwiwoXtW2j7/lr56ewFb5Wpqy8V8+j7U6pk2XQJ4ZDBGN9vWyLIfln+DxjrFqi2
	 tqBPl+qpARaG4e0UKcwVPLw/hM0zs4I06ySWfoHrOn6EeT5w9UOXEastYaWmqgp+rKx26
	 YDg7evdA7FpYReBoegX75c1DrPBi34iOdw9ud1m5dRW0xkjbwjxYt6cGHt1vOMIT8mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793683476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2D8L1UWAH1Vxf1hpJWwdzKWdrJC1d9sHSGsG0FPKzXQ=;
	b=hlKAicmIsmFqsOI1HY8uI+ChGDRQGyeoLUVDuz46PlNysZDjnw1j7GLh7A+rE6zXQjET
	 n2Pof9HqSGwBWqyv/378izsP4b13WhS2r1DMCdLFrPw6hsLwIqJZyEBblF3QHreavj9Hz
	 Xkj0oof+b3GRL9Jj/excbl9pXOwiFjAweWW92OFnHhi14BWtmtmCU3PsxjfgVdPg5hZbN
	 tjMoY3foHNm1LQETW73cJCD2FtOY4YEs9IMtxPkEYlPGmpiv3yDERFUyR11WAmHvwZDZg
	 2xV3lt1QEEJEaKp0Kp2M8KPbvhfgLqcKHgUKmjTjAfOLX5xF8OWGNa0t0JFSP3/hEmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=KBcEHc9Q;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059F606A326
	for <linux-can@vger.kernel.org>; Tue,  3 Nov 2026 05:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2059F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=KBcEHc9Q
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e60f9af6e6so35672775ad.3
        for <linux-can@vger.kernel.org>; Mon, 02 Nov 2026 21:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793683475; x=1794288275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2D8L1UWAH1Vxf1hpJWwdzKWdrJC1d9sHSGsG0FPKzXQ=;
        b=KBcEHc9QkpkdUkC0FwlMgj5/4zbXJSEipFYk1FYsD59Uh50pUifdEjWbK5wc26iCs4
         UZa/TbCJiMTfrqSTLSc2Ov2Wlsxzd+A8qiGnhTO+FU+FwVq9P9athcSboG+iGNh0hAY/
         jFRpEkvjOTqNSIR7/iPnoot82OKX/1ecQNbYxq///KxsDhVKjjgABcMRWz9BkFJ6N40E
         +XZ1NBpGW8fon887AULUqhSyI364ueynrDPq8pzBvCTdpk7dbk104TkyEuLfl24r3LiM
         /ZR1Mj4wMGVGBqhM31vqFPJNSGbpx8jZg6CdzckxsjtHIed3WY8TCo9JXUKr0KqEY6FU
         GbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793683475; x=1794288275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2D8L1UWAH1Vxf1hpJWwdzKWdrJC1d9sHSGsG0FPKzXQ=;
        b=PlbBVh1fUEaU82gKw2HI1qh/0+SNPwsmekzIAx1abWcb99wws1OrLstcndNKwi0jAH
         92ULdAowN+v/c0xoHVyIxJzQ00Q3Iz9G+uWwh9rZ175/VnmTehIMLy8CpGqvJvgjSL8J
         XLcgBqA3ixUM/7ZQ6QKROHtBTAKq7MQv041GhVFQyoI+LcxAwOkHGCV7NDpApJjN9Fya
         qeUQoCePh7rJtJ1STcOjez17DtJtRY9MCaYpUHWebTbrVsWj4z2LwfEkPupbmvMV5NCE
         ce5TidMQcwWmpU8fcSkOBi+h4LaL64xmd12JRyF5fatO6RaCOYj9liEbTnA6vgqAmL9u
         ynJQ==
X-Gm-Message-State: APuU4Z+HNB/tvovJ7k4CjBiPYZuJl+7rUQ9/ZpqOzFHgZqTmYtXwIywj
	U5HDeB1ICGSbq8/bHcynGuRtaEibRHSoXMf1m/LVwmpXQ9fX9Yfiv+BzRs6mw52R2RujFNb2yj2
	we9u3iMjr
X-Gm-Gg: AYBFou3iq1JCVvYTT07QHfIK+ash47BT/zQIKV0wQ9QcO6rrHyCWXl8gsDdT6AlpMX/
	6WW88IqvneV3vz+upiH2XBQAim1mHM3TKHxaBeMFnwiNwrNb8q2Bm+NhnTv8HSiP09MkNSAXSmf
	OHFWowV6NB2FRVK5mS8xktb7qNKOq21H4B3ap5hM/FC7n3dpZFWZBUuR3bGMHrE+Ix7ReswWcoQ
	9OSom6/meCT3/g0KdYcGb4t3u4kh7xR5oKJJlRDif859qUipCsqWSUPmVvWG422V+IjSE2ZiO/m
	MtTElDIry3OsW9fBJ/dngeqPSgJ/L6fD5GiYXm1UwoWSPTnvtv7pWp59mi0smpAXHJnGGC+fvJn
	Z16cH4Ssnuk6Td8S4v3TzXu87pphpzeY/GWTYtfJGzkkpaFY8FRsAWXmghwjBHeWEvtoZqA0KIL
	brUUvYlgsZIj48W9v1K7Po2cTiZiHG/6uhCisYnWFkb5u3KWz/XYpXPbUkaSJ3a6HAZNs96p+tB
	2V4gUnBHOIokOOK53OqeXLHLovx/WjIh/9QNawjOS/TRDJp3FBNzRFUtQ3GHVspPDztiT2r2tYq
	/fzaIwtJCWGly0thY703xYrRKtUScLHAz+xrYvBcSgchaHOsX6+BAeilXDVe
X-Received: by 2002:a17:903:b8f:b0:2e9:514b:7a72 with SMTP id d9443c01a7336-2eb364bc65dmr125129925ad.31.1793683475402;
        Mon, 02 Nov 2026 21:24:35 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb77df90casm9943245ad.0.2026.11.02.21.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 21:24:33 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	ecathinds@gmail.com,
	bst@pengutronix.de,
	lkp@intel.com,
	maxime.jayat@mobile-devices.fr,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v5 2/3] can: j1939: cancel TX timer after RX timeout
Date: Tue,  3 Nov 2026 05:24:14 +0000
Message-ID: <02b6632da2b01b51edbe4c7b794ca3c473bfd559.1793681851.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793681851.git.zihanx@nebusec.ai>
References: <cover.1793681851.git.zihanx@nebusec.ai>
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

When the RX timeout path moves an active session to WAITING_ABORT, stop
its TX timer after dropping active_session_list_lock.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://bugtracker.nebusec.ai/f/11143
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/can/j1939/transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4958f7c47ca4..c85d7bb3c12d 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1387,6 +1387,7 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 						     struct j1939_session,
 						     rxtimer);
 	struct j1939_priv *priv = session->priv;
+	bool cancelled = false;
 
 	if (session->state == J1939_SESSION_WAITING_ABORT) {
 		netdev_alert(priv->ndev, "%s: 0x%p: abort rx timeout. Force session deactivation\n",
@@ -1414,8 +1415,11 @@ static enum hrtimer_restart j1939_tp_rxtimer(struct hrtimer *hrtimer)
 				      ms_to_ktime(J1939_XTP_ABORT_TIMEOUT_MS),
 				      HRTIMER_MODE_REL_SOFT);
 			__j1939_session_cancel(session, J1939_XTP_ABORT_TIMEOUT);
+			cancelled = true;
 		}
 		j1939_session_list_unlock(session->priv);
+		if (cancelled)
+			j1939_session_txtimer_cancel_async(session);
 
 		if (!session->sk)
 			j1939_sk_errqueue(session, J1939_ERRQUEUE_RX_ABORT);
-- 
2.43.0

