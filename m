Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4341A4F2;
	Wed, 29 Jul 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320973; cv=none; b=khSs0MhGI4sDs51l/c+dZaLvl9J9h4nEb9TLn5WTamUZb/slyqsRCpCZTvct804OWh4qqJEXkAOe2nInYIGnmakFWxKHgHjvfvxzsmyasr/Isj/DHWlDT4+wN4FICIB7oF/D3uwIqFK8jUSAO55WOzsrP3TK2E9Xgo5zEgSTruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320973; c=relaxed/simple;
	bh=x4OgMGyxL1BmW4nh+arK7xNI+7AtaDNdb3Ahji3Y0Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDkt46RbRd33kEtM6kS6XMR3CN1IE/zBbwAiMiA3vOPLqzMH+YoxG89iSrx9Yq4sPglesCKqfyoyR7oWlIixp3XYt4z3WBhAdW5lNLHvO/Wpy2eN5TGkv/jTOf6X6+LQtPhhIUZ3uIKGilOa2mhRBVPrLE0TAcY7kXkf0cptCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 67763202B5F;
	Wed, 29 Jul 2026 12:29:26 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wp1XS-001rnB-0H;
	Wed, 29 Jul 2026 12:29:26 +0200
Received: from blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B57EE575DBC;
	Wed, 29 Jul 2026 10:28:10 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Ji'an Zhou <eilaimemedsnaimel@gmail.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 02/20] can: j1939: transport: j1939_session_fresh_new(): initialize receive buffer
Date: Wed, 29 Jul 2026 12:12:42 +0200
Message-ID: <20260729102802.505168-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729102802.505168-1-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

Zero the allocated buffer in j1939_session_fresh_new() to ensure it
contains no residual data.

While there is a potential performance impact if users allocate maximum
sized ETP buffers, most real-world use cases are not noticeably affected
since the maximum known buffer size is typically around 65K.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Ji'an Zhou <eilaimemedsnaimel@gmail.com>
Message-ID: <CAPAUci5dykCLjoijqkUtFqJFesgncrD7+S6y_V=gjbFkY2Tifg@mail.gmail.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260728055835.1151785-3-o.rempel@pengutronix.de
Cc: stable@kernel.org
[mkl: add Message-ID]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 98f96362b20f..8fcfd13e5e6f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1581,7 +1581,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 	}
 
 	/* alloc data area */
-	skb_put(skb, size);
+	skb_put_zero(skb, size);
 	/* skb is recounted in j1939_session_new() */
 	return session;
 }
-- 
2.53.0

