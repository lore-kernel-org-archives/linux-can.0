Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794311480;
	b=CdmkDnC1JXb0Q6ACxrdYQcnmIqYIILaa3aUGCfWL7irZha6wCdWvghe/7LUYIeD+v36R
	 4JHoLa/yxQcAHvE2F/x1+CWMNnfI+9g4xmaaUVEobCrbyWgummWNHldsy5kVAgc8w4vZb
	 fvfeqW4JBpBuKXzd3Jqz5lHviieffO5pEItmVcFv/FXghR63Di9Mra0uazz1WLJd0ZouE
	 tPbmWMDduYVmT9FfM+m5GzPhf+0igsu7mPFvMFrnQ+4TiSb4O2jj84WLI2SmkAV8DudqF
	 Umt7a9mepGh1ovatLdeH8QSo0fl7k/QmKQdrZatCoIqSCv5yhX8ZpPzgHsH1V5j/9Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gY1SdMF5KaPpqAd0bt3WtTp99u6PBj8Uw7hO6LDDWRg=;
	b=Up0mCSdammI2Yg/nBwOgPK/5Z1mYVD5BzzjxkqLYaiskh945l0fi7h0rd91n5taCRKLU
	 CjzZOuCAbQlHKLPDCMDxrgVMzs98PCwPOvsunCNbt1y5W3kLRlbE/9QweRI2d1VRj5Vzx
	 IgSxVZMFoEc/Lirp1ffCcbaOqnlAQPBi58hkNDCKvrjF8MMQIwC/BilviHJxCdKsLDc3p
	 lNaJr7oFQDHXup5AGv09Mq9phb5o896IU0XzTJXAm+puqsk1JNht0DHtglxTiZDGsebHr
	 KsTwPzKB2uGkQG4sHGbymOu8EXfTOCNUvtEGekE0Vx+4cdQtj/MYkhIHr3vvsfHoMew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JfP6ELOG;
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F94606A33A;
	Tue, 10 Nov 2026 11:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F94606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=JfP6ELOG
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9C1312000EB;
	Tue, 10 Nov 2026 12:51:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gY1SdMF5KaPpqAd0bt3WtTp99u6PBj8Uw7hO6LDDWRg=;
	b=JfP6ELOGrP4W6gQ5WtRh95VPd1Fh536nK3ofcXuRbmKPLbUjXd+fZNB4IiMqaT/alZ2Khv
	xRytNZ/X5nxmo4ObR9OSV17ak1idJkTaTnAgXq/RyS2vlTwoG2BLWmQVb8ZW2a45ODDXiy
	b741OP+4pBABF+5Mu7uO7+9oJHBAlbY975Tp9y09yfHGxRWn/VKYPVa6S5rwOmwlVOuoXE
	q/E7UFBF/+33fBYzmjGP4tNbmyun3MEyjlHqHNKRE3vFea/yR0DY70qEKRxK/yWqcPh9ov
	Fx2KS7SsA4i8eIgp19n795zAiEmncTNuKko776aExp52k/fzUIzCFOeo0Apa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gY1SdMF5KaPpqAd0bt3WtTp99u6PBj8Uw7hO6LDDWRg=;
	b=P550VUuuEHh9Mj41RtQ/RU7kjN5m9oWuaiV0A/amlKzugKRsMhoYyVRKo2xTX5/lYSQX3i
	a5aFR7kqQGPIdDy75hoVNFPfan4y8KWwBuBbGw70XBaqoKWJp6j5h1SajhBGTviypQkrgQ
	4U5iOE6xn0tLuHRBl4Z4zYAANnVgr1DKELbxEx8PlZdirjFgZ8QFjJFmdxtZuPn1z1gxle
	sE/+IyeMgS4sdK8dKbf/aFU2eueyJtg7HIntiuPWe6Q/gao1CuSzF/yQ2Tvd6fDnvE5j+A
	W9xql89mZqZqBjmI8vdIlzvK0FJsXNmk4hKXIOT59qi7lctl5VOfFFzTihgFNA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311476; a=rsa-sha256;
	cv=none;
	b=JOfR8Ybm3hNOG+r7ByYdqr+FQZZUczoLfQegETZjNk84oCBGhRvyqxLRqDcTx1GVKQdoqk
	kHmhrvuEhyB/mgZgQLSSCnEI2XHsqS97muD3xnoVhNJDj/Cv+jtlsZdMACtOkT3Tlx+BZg
	1u8CsYaCzWhmeAIPzH96ss1DlEL5nEyARkkMLp0alnTXPFld89MUWDuqVIYfJsZY6KwcAt
	5y/gSEowwMrmEL6HkXeJSTnN7rYTLTwD02cau82tIqh0GPYXSnS2S0WCoxb7LtxHLWJEtx
	7WcUayqoUDigxMQh18ilBUmkQ2AjThs2Z6D1naa2GewTHa5LCwW4l7xwpJKdsg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEm-1m;
	Tue, 10 Nov 2026 12:51:16 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4CE5D5E6889;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/12] pull-request: can-next 2026-11-10
Date: Tue, 10 Nov 2026 12:41:23 +0100
Message-ID: <20261110115112.3807247-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
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

Hello netdev-team,

this is a pull request of 12 patches for net-next/main.

Claudiu Beznea contributes 7 patches for the rcar_canfd driver to add
support for Renesas RZ/G3S.

Krzysztof Kozlowski's patch updates the renesas,rcar-canfd DT bindings
to restrict the resets in top-level.

Biju Das's series of 4 patches add support for Renesas RZ/G3L CANFD to
the rcar_canfd driver.

regards,
Marc

---

The following changes since commit d26955e57475434b59d43ba372b2a50d33d5e0ed:

  net: mvpp2: fix double free of the replaced rule in mvpp2_ethtool_cls_rule_ins() (2026-11-09 17:38:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.5-20261110

for you to fetch changes up to ae842166410d5f42ed3257c735dd2ea3de931f5c:

  Merge patch series "Add support for Renesas RZ/G3L CANFD" (2026-11-10 12:21:16 +0100)

----------------------------------------------------------------
linux-can-next-for-7.5-20261110

----------------------------------------------------------------
Biju Das (4):
      dt-bindings: can: renesas,rcar-canfd: Simplify renesas,no-can-fd description
      can: rcar_canfd: Document that RZ/G3S has no Classical CAN mode
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3L SoC
      can: rcar_canfd: Add support for Renesas RZ/G3L

Claudiu Beznea (7):
      dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
      can: rcar_canfd: Fix typos in macro names
      can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
      can: rcar_canfd: Do not set registers selecting the CAN mode
      can: rcar_canfd: Add support for Renesas RZ/G3S
      can: rcar_canfd: Check can_clk request for errors
      can: rcar_canfd: Use DT clock names in the probe message

Krzysztof Kozlowski (1):
      dt-bindings: can: renesas,rcar-canfd: Restrict resets in top-level

Marc Kleine-Budde (3):
      Merge patch series "can: rcar_canfd: Add support for Renesas RZ/G3S"
      Merge patch series "can: rcar_canfd: Follow-up patches for RZ/G3S"
      Merge patch series "Add support for Renesas RZ/G3L CANFD"

 .../bindings/net/can/renesas,rcar-canfd.yaml       |  57 +++++++++--
 drivers/net/can/rcar/rcar_canfd.c                  | 109 +++++++++++++++++----
 2 files changed, 137 insertions(+), 29 deletions(-)

