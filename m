Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F297384CDF;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029233; cv=pass; b=PxGKTnDLUpuUgEQkevCVZ2vmdjXnEijxFTdK0fIqeia91KHH2vqiWnfRu06PsvRAcM4OHAb/A5i3PLew5IBd85VQyoFeRbOmMO2Ly9yULZks/wshGjCdYU/9PD0AAvo5Wds2IhbKoTtqc6F4gJChhGYcr2x9yX0ATJ6Gw+pAiMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029233; c=relaxed/simple;
	bh=O9a6x6RZdsTMo4G4BsCYAJxP1ck94iOgIkQMX8BUiBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBJBewFQDF+yCndeFsLKPjq2o5GJoqUry6mea0c7D9WyKM2TK0RuMlblj/xMA/hscDb2EDWNLltvOMy9CzHLaqiIz+4uZDR4kofydATHaOelZ/mwYVOlU4MmyKZzhgWl3jrl2bn1o3tjjFvxjfM8qPloSkLhnk2Iy86R849J91U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ci7XpvAZ; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ci7XpvAZ"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 81CDB2027E2;
	Thu, 15 Oct 2026 03:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05M8jv3aCDUblug2dvJEFFtEW76sFU7hQZdrSMrInpI=;
	b=ci7XpvAZ7LqzdLMv1ag+c+fIHxcg7K9ja5SPv7+LCRERyO02l3XQ9Kolknov38iZF547Dx
	oUgdeA4PAuiqn5jxDRqlrbnrpbQFaLf67EOMu3gD3PKkJ083cymFIt2zyw0aeMcJjT6hun
	hFZHxwffEA9PUZY8hFGgt+BMuq35/rQ2IRpQJr0pze1zxQWQKpsAOHfHdc/v+G4M5MMEyA
	PEj1Gw3cQ4ab50Ec9c9hkvPuaCkJIEpz2yF9dNfX8T2XsnLcfal/w0tugGtQ1ZMBHbzIZS
	DGXQFW5l9t+VXkTHzqNkx3FG2exRt8yxgz9HnbTPGnV+kngWd0yNKZWOkinbNQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029221; a=rsa-sha256;
	cv=none;
	b=DoltNIHhmALqyryUSxS2D72xRuv1sMGs8AS2OFuhP0DVSeHlPr6PxYIXlqkBfKF6Ef2RMT
	ZUbUGC3xI9pAPZ+prtDI9EvTqaucDXSwBVua9iltORM5FM1BIs8/hZR9ZHdoBYQfa6uAvk
	Oma2XarGJ7fBnbC59lLNzoK4rxVJlWUrBdmKYQfHh2Hd1EBk8bkEQZ1PD48YM16PLP+EOh
	8adXK7GgVEOeZGQfCFrHTXLJr4kNpXr9kT6WvYB1um59NwIsNJheue8NdR9b1aPlsWVnvc
	jHY8kzwgi9yGqsqHgSvyaI9ubQsbJMYurNzlbs9TsMvD6f0W2+URCKcf9phCVA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05M8jv3aCDUblug2dvJEFFtEW76sFU7hQZdrSMrInpI=;
	b=R6nbLCr0xxEZElEpRSPrgt9TCppE5ADyQmS9JF19SwXB+HJdTt1q/b0A47u6Awmpuas4ZB
	uVDmtzb6ise6dbHTt0N74aYUtkOB9CHyuyzDNYErtkP/W6QWrcjfwsHiUYYNGm7/YafWpc
	aqfJLhZWMaMYNpMeyCGR/MG+wnNPyFaphoppfAYF0G1I3lMUcho9hoZMIamv6g1dLjBCn+
	TreeI9ujX3rlMBop54jzvSmD+CLEw4k+fbLX/hfuPbfVVxR44xo8BJGgq+dPWX8cd0KaqC
	suc9GGGfyT26JXsq+1BQ02nD96cYp+OwoYJ5mQeig9cNTXbZgjxmT643+MqzfQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf7-005wr1-1K;
	Thu, 15 Oct 2026 03:53:41 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 29A0D5C4790;
	Thu, 15 Oct 2026 01:53:41 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 23/37] can: grcan: update the binding file reference in the driver comment
Date: Thu, 15 Oct 2026 03:40:21 +0200
Message-ID: <20261015015336.816543-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quchaosheng <quchaosheng000406@163.com>

grcan.txt is replaced by aeroflexgaisler,grcan.yaml. Point the comment at
the new file. No functional change.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260929073703.2748220-3-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/grcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df56d..1b4944d1d06d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -10,8 +10,8 @@
  * Full documentation of the GRCAN core can be found here:
  * http://www.gaisler.com/products/grlib/grip.pdf
  *
- * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
- * open firmware properties.
+ * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml"
+ * for information on open firmware properties.
  *
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
  * sysfs interface.
-- 
2.53.0

