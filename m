Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D07342524
	for <linux-can@vger.kernel.org>; Sat, 19 Sep 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857271; cv=none; b=ekHJhCfCYJx5Y/+mLuzot5zgYKxdWvdwPA2gn2vv+IYqbg6vmqJAlHvoizWi8sGg3F/yILsE5p21sKM9J+0XxLnX5Vqjd4FXQBUIdbS1c7xHs7TStE9pjpoU28856cTAG3aCHf9VkcBmf3aQdVCcXCRt8cZXoeaspIivmKztG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857271; c=relaxed/simple;
	bh=lRCb6HkDic6hHzHLZUcVbPGPOfOs3Lh0b7gVudKpq+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urb3lzG3Yo6QSJhkGnzXJGgGNfNpnBBOK1RIqM6e+xBtPyHovCYtDe7SneSOM0ST/rXPDBCFWyhFLUtvugVW3mwe/fgIesKqghSP+DtaqCxyaWashKc0vWKbpq1eoaA23mRddz1nmwAF3Q2gogjtnBOUnPO0Z62dVvxXIYc4do0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNXKsDay; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNXKsDay"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2ddaa08c890so17123545ad.0
        for <linux-can@vger.kernel.org>; Sat, 19 Sep 2026 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857269; x=1790462069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ZPy0AencS6Jmk3FwXF8rlSKFKsz3ZBOP8R9mzvOloo=;
        b=BNXKsDay2MRDWXW68TGfSfCa+wk5ml4yBmB4TWd2ZM0A6FG+wXn55zpXTrKdzKnq+E
         l81D6lQEOfd3YlmNfX/xs3PD/ox/yK7uJKHQWMYdq/o72dRFNk1Hgd6eUk/gSPaLzjil
         m1Gbkc5xFR6oRzg7g8ZPDcBI/LwOsgOSIElH1XJzF0WL0Mq85SJoAVaQA2mPbZB3mReN
         nz/AEK11pLrL/+7SHlV1U51uPP2K3ykpDKVq9Goj1yxTFOD2dku7WmTclyGasoeHYNtR
         IIM6jAbJayoeoXhB6HVrFaZq8ZqrFfHIYLMYm6rfsh2zaPpBTp5ptospJhvkQvMIHKqt
         OgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857269; x=1790462069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZPy0AencS6Jmk3FwXF8rlSKFKsz3ZBOP8R9mzvOloo=;
        b=wEmAxSCelPzPD4cgucwYtd/WXGfGJ3Uhgn30KONuhK8GMsN83+i+mmUTXdqwu0nT8c
         tvNgAV0a11lolXa75m2n2iPH2oXxBaoP7YzYn5/URLDKGAi1wiKielOm7gHSAh+gngjv
         Y32BUGLDY6TiMI1dTK/cudHA+8HnQlpTaAWh66Jyu546uT/mNI+SvWletDSo/jbqBKOQ
         haDl2bdOihGw9VLle271DNw10CSHSYEa6CkhfIqWhIU7z+uALG2ZaBWHVD9KB81OlLRS
         ouQhjjjExeqRBVyFx772R/LjhzpJGCx3Pue3ZOXy34KorMb+ft2oeE+upSqP1chx19m4
         h8pg==
X-Forwarded-Encrypted: i=1; AKwUvBwL5QgBIcY0Ct47Q5fbTejOZT1JutU1bUPRYL0onrfsIDSLregeRtaRckT55gKRC50ArzqDbc2Qm/A=@vger.kernel.org
X-Gm-Message-State: AFuF++m74bOxdaMe/PcWaq5y1w551jbm5gvJXjdAhjLYS9jWopZN5QTb
	0wjdnUs9lEsTf4J5XQ6OJpbFxZabc3AZWa+ow7P/YocGoRjLfQ0ZgBee
X-Gm-Gg: AYBFou34AqeMtEyD8cCf1PbsNCIdQz1p/q3LYBOTSuvyn36NdOqVf7QRM3r1CUNquY3
	lD2nnquQofltfHvwsOTx6NZ6pIQuAC5MDKF19S4fT4dmgorcCo4rktJYLSPlgtuKoIM+0Hr3UNB
	4jES75chntKjMLv+77fBL8Jpq3CY6pls1rJqv9urz9y1L1n82DtwBBo+Xe0KLcEaVUv69nLPoME
	pmK3J/a6fxnvCzUjO1HJg8OZjRuPQETvC9ATolfcf+iRZpDFn+aDCLFX5Fdmd8pgM3NqSFgNpO5
	ESifyPdLWjKx4QDYnQ52FRl9CHPH6nr7S7G/0s2gk6v96/jPDlCnJcBoUBI3+Dq2bqvecde0RhF
	IIrYiooQBf7CIED3pc2afG4yq0rVNGKxpRnowQYhmjZI70TS/Rn0XPz9OcBZdA2jpiSfsrpYD20
	pnmyhNQ2rXU06b360IuZbXUB2WOn1Z2t3jQ/uFaf9HwS4Rk6lrJ9a6nsBy18s+WDLy4wGijqxtq
	aQpRqECcOC+yffbO0v8H7tR0zkEQkWocQxeTy32ODAeF7GOFFnrAemmqdcoQwP7HnDjT+HkbmKG
	BwhcImV9Mg==
X-Received: by 2002:a17:902:f78e:b0:2dd:c100:7cb8 with SMTP id d9443c01a7336-2ddc1007deamr45185035ad.52.1789857269496;
        Sat, 19 Sep 2026 15:34:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17d6c70sm13223915ad.62.2026.09.19.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: robin@protonic.nl,
	o.rempel@pengutronix.de,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kernel@pengutronix.de,
	socketcan@hartkopp.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: j1939: fix transport session leak and socket bind/connect validation
Date: Sat, 19 Sep 2026 22:34:27 +0000
Message-ID: <20260919223427.3881575-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in net/can/j1939/:

1. In j1939_tp_rxtimer() and session teardown
   (net/can/j1939/transport.c), ensure active transport sessions and
   skbs are properly cancelled and released on error or timeout.
2. In net/can/j1939/socket.c, validate socket state and address fields
   consistently across bind/connect/sendmsg.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 8fcfd13e5e6f..712bca1174d3 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1672,10 +1672,15 @@ j1939_session *j1939_xtp_rx_rts_session_new(struct j1939_priv *priv,
 	session->pkt.total = (len + 6) / 7;
 	session->pkt.block = 0xff;
 	if (skcb.addr.type != J1939_ETP) {
-		if (dat[3] != session->pkt.total)
+		if (dat[3] != session->pkt.total || !dat[4]) {
 			netdev_alert(priv->ndev, "%s: 0x%p: strange total, %u != %u\n",
 				     __func__, session, session->pkt.total,
 				     dat[3]);
+			j1939_session_put(session);
+			j1939_xtp_tx_abort(priv, &skcb, true,
+					   J1939_XTP_ABORT_FAULT, pgn);
+			return NULL;
+		}
 		session->pkt.total = dat[3];
 		session->pkt.block = min(dat[3], dat[4]);
 	}
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 1d4af472de4a..889d4718c46a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -470,6 +470,10 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr_unsized *uaddr, in
 			ret = -EINVAL;
 			goto out_release_sock;
 		}
+		if (j1939_sock_pending_get(&jsk->sk)) {
+			ret = -EBUSY;
+			goto out_release_sock;
+		}
 
 		/* drop old references */
 		j1939_jsk_del(priv, jsk);
