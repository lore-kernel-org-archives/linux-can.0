Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FA1A38F9
	for <linux-can@vger.kernel.org>; Sat, 29 Aug 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787983820; cv=none; b=Zd8vMNp6EMCGZo0KvpBkkUdNjs/Tuzc/JVf5ttu6XeNwQcUxCYrJq31JaU+sZebUUVW2gHivMspVmQNlQXld2dAa8oe6L/ylrbGw6q8fD+BbfTpIYCp5E6psPvnj7yixYBN/yFGJABQtvMYfMWymDYQmBHtZVRnMhAiIypShvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787983820; c=relaxed/simple;
	bh=s69jawAqeIjGLgtSCVeyaIovADKsHyO6wqtfFQtkCgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSUayWPgE8Mfqv7FCKm5BLS4ezk8zB7wI2zK10qFb3oiMVV0bQL8tG13d90ssoArhS9El4jSzZ/mheOBg2G4r5tKuZpm7nB3DBS6+j0xSnogHXdR99PR6YSHctopP1oV5HX9wN2NJHK8Srq4c0CSK7QY4K4Aha141Ll8C9G3908=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=PWg6haFz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="PWg6haFz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so1375007a12.0
        for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 23:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787983819; x=1788588619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Huaybr5U9g5vi0qilHf3fm9gcAefRSblV/T1Mc+TMsc=;
        b=PWg6haFz8i6vip4ra57UfynaX7Z1HfyTc1nWQnX4ce3a6CnOtj40yJ0LPCpyBjTOSO
         VNAmB1ztW+bEgO56blJWkQ05rXM39p3qGsoMS+SotHshuMbtUPD+l9gIQnAqpcFZYoSt
         Wp13gZ7UyWcU1wtsBkHQGj4n5oHviBU64EZ6IjnWXI46b0IJu0yaJctkksN43pE+8R+q
         xByNnUheWGJvW3u9nhtoU2yr3Rzrht7C/A6CLx/rDIAY3L5HjxgeRgJ+BbHfvURbe+Si
         HFOylsl4hOKdHd0gsWVkDDXe7SMg/AiYU6a/rM4dJTxHMwJS1CCyy0NRqQFKiNojS0XY
         GnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787983819; x=1788588619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Huaybr5U9g5vi0qilHf3fm9gcAefRSblV/T1Mc+TMsc=;
        b=XsaOUsDJyFb3sXJQM03rEeIcyuRy8M6dIPo6tbH9AokSvpnkC0aKWplyzE/O3gcdyx
         2rwsURHCI0pSl0eoA6XlGpeauEFIJTM55ExEWX+xCHjLJl+hniZdi09soNTkyL7CNbYe
         dxIJmtnru+yv2UNEDmo1cQiWIMpseY/7RZUBUDctWwbliqYQDgYumLAypEVs2LXcsE1G
         TanA71naJaVpXavfW71sFtNRK3grziwktRHdaZVMAHbtNl76cHM05+U0IRaeda1ZhffD
         rRtJX7ho+xeAjEzob6TFSyWUVv14le3dthEMzJ1eIv9cVLrf17PnIsAoreNKxWrn0+Oy
         5LRg==
X-Gm-Message-State: AFuF++nDBGKIip7+BQ7q0sd3M9rkklNMmaiIU+wekqCWAHfG6o2uKYDS
	idzcuAviUaxg1xw1M5ciNf0cgWotBKVIofuBmChqgFxQr6gYMP4xE7knoK20EjHxAUcc+x+bajm
	Bxs2K3EEk0PQ=
X-Gm-Gg: AR+sD10CUNUD5ePNBvJRHLgwrS8ehEH7ZeZxTH1FxbzGmba7CxRhC2PdUFoMvXOB8St
	Dk0MHPYwkt4W1r9kWn8ZZoEphrHnJfUVvBrkivmj+BcAgQks8MDKrHNKN25g7o0Z4MwLOygyEBn
	KJJebNzb+M3Vj6WVG+dVJxuMYdqDs6Z12xmbGvvE8kUZGauKQlWQg0igpJR8WoCqr+6Qtu2ErNz
	DmeMXY2KfJQ1WXIRV8GTvxcA6aXeeLp6JqUiqGbTvBHF4+xehqe6EkvzvR23q8skDtToUv7PENz
	TT2fhgdQfJSh+WCfLPD5SY97Rr8sZp3ihs181Jte+oIjOUQxYM6JB4ywkdi7Pkyew9mmqMBz18C
	lCg0uEaTi8CCvd4E3XAdOhhOzlydVd1smaA5SxWm1yqjhAkiv+8OFysVJQFeK9jPvw9xAk59D40
	9Jl862pKnMsFbCq61cSoCC6vFuh6zWcdzp9hp9MkH1pa2oVDx5yydp/8nX5RPfN3VBbjRnyWf+w
	fmXcX8=
X-Received: by 2002:a05:6a20:2cf:b0:3d3:ae40:51e1 with SMTP id adf61e73a8af0-3d3ae4056b1mr7964224637.21.1787983818533;
        Fri, 28 Aug 2026 23:10:18 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm11144869eec.21.2026.08.28.23.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 23:10:17 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	maxime.jayat@mobile-devices.fr,
	lkp@intel.com,
	ecathinds@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] can: j1939: reject activation when device is down
Date: Sat, 29 Aug 2026 14:10:00 +0800
Message-ID: <4038947f8d5030ba8b2f75fb6de20000bec1883b.1787982820.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787982820.git.zhilinz@nebusec.ai>
References: <cover.1787982820.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETDEV_DOWN cancels active J1939 sessions and drops queued sessions,
but a bound socket can create another transport session after the
notifier runs. Since a down netdev remains registered,
j1939_session_activate() adds the new session to the active list.

The transport timer later receives -ENETDOWN and deliberately leaves
cleanup to NETDEV_DOWN, which has already run. The session consequently
retains skb, socket, private context, and netdev references, keeps
skb_pending nonzero, and can cause close to block.

Reject activation when IFF_UP is clear. The existing activation failure
path drops the session from its socket queue.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/can/j1939/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f8..6ae439abf1ebc 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1601,7 +1601,8 @@ int j1939_session_activate(struct j1939_session *session)
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
-	} else if (priv->ndev->reg_state != NETREG_REGISTERED) {
+	} else if (priv->ndev->reg_state != NETREG_REGISTERED ||
+		   !(priv->ndev->flags & IFF_UP)) {
 		ret = -ENODEV;
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
-- 
2.43.0

