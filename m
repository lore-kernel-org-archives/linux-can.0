Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2236197E;
	Sat,  3 Oct 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068030; cv=pass; b=jP8R2wA9K+xBqfTTqI6K+9Dr20eh3PKR/SeXQQIVI1pkqWiq6JI910jHZ9HoWKnKjN7Wr1Q6dugpBfJVjAM9UCS/75h1dXziJwCsomjKMGSgKYUNt/+Q2qzHXQFkbgmJGiUcXErMG0H29U71SU/eI38UASuh2S1jcQBrcnwVc8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068030; c=relaxed/simple;
	bh=vh+24Prfb5BoCMeqnxhe5RWuOYmz9MX/V8YqNmtZe5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t7XtbZ62AeKoWtXP6BxxtrbTJEfRBMbaZnpAZGgD5UMS1U5zK9A3RH0RH+ug0EA8wNn4RTbWsED0rN8TMZRYg9yUzp3q7q9mUbLMfps55NDS7mjNJKexoqmxALs/Z4xngbxohlckH4mJp+L/nTBH2Jfpnjwj7G2I9i5vB3BTMoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=XJHHpaNc; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="XJHHpaNc"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DBBD3201ADE;
	Sun, 04 Oct 2026 00:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7jR88633r7nkV05z4CCjBfAPODMJchUadJ95SB4G3Mw=;
	b=XJHHpaNcfSDRFMaW87m9DIMrsxAYlAIQzze/oubBL0z6xIIs3+W8869duuQj6vMU8pnzwk
	xiFq71d3ZlFu/wDz/FmzceynqaJb69ImEFPbH3DWdCe5rYzB+K19Nr5Uj0wpkvjJURw4Ug
	skcMucWX5+qwsVxAhk/Kjo82X/Bx6+68g5KJ5VDm4bV20QmByXOO/k0Y7a2hzKJheK4T+s
	7iVRg88xj28xjPXMqaXmehbJ53rEIJoixOmDAYXpquE5nurqNUd/MALqs2ESxTPi5Vs7O4
	7yTmc6b9klwz5FL9vkLKXXZBt0kyKpyHnkYXAXnk0CKld8UDfOmYyqTQt4Nlkw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791068023; a=rsa-sha256;
	cv=none;
	b=Nofi0lmKzkwzAEdBh6v5r5hS2aK6R7jR/+iTSuntA8vqjQlx05ZUhMs8w0QLyTDXIT5M4F
	FULgUNJQaD3WYDZPk4PrwJBtq/G6qskNdRt1yjBF8j/SemclkDzrkrJ192J1iqWXbwdafa
	ihC3TEDiZj18f7eOAOzekxNzdZGKFSeEI2dDyi09UgyMcg+TCJpWFcIdPen7HJ6nXkR0A4
	xwZhpbZu4GRKJlydRQ+bNEDcAAdpUPVWzf6zlq/hNTMPBUjK9mpGNF0Mk9j41VYv2uFsjT
	MU1qQS6DIErf6QvKlQ2VDUXLPt/t6uEx/rVwQuAXnSIs5fuZQfa50fltfh5ZWw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791068023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7jR88633r7nkV05z4CCjBfAPODMJchUadJ95SB4G3Mw=;
	b=QOczcOM3C3TgiLQTmAjzJInNPNj0GXeyeXROkPokmLEQFcaKqR1pKRzD4Lr++evpgc9cpp
	qvprWh4xyamRWBf5rok04FtYBV6hpoJMpdxoWSgHFHPAwEVcAlUp/lRBTp/lBCFfbKmL39
	btRUviW84dIMNDyWcp1LhpCCDZtvxaR4jEAk2GynO55DNppy179Jrqnm2Xt4uIHsgdVgva
	f1grXn0xyMJBS+glZvU9C5xdUnjB/ZxZHViVzpOUXfFQkCHZGPe/vqbGgiJSJxXqMhfy0l
	AaodLxoHJZb7NFsQCo2W4L1uiH/I0LXDYXlvY8sam/g++gchQLlGEVjQOAT6UA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xD8bv-0047mc-2Y;
	Sun, 04 Oct 2026 00:53:43 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 875695B93A2;
	Sat, 03 Oct 2026 22:53:43 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next 00/10] can: gs_usb: cleanups and fixes
Date: Sun, 04 Oct 2026 00:53:09 +0200
Message-Id: <20261004-gs_usb-cleanups-and-fixes-v1-0-7b4b06244a77@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2UA7oaK/IiJpls2KxNGsYzD27
 9bt8TjuVjDJSQxuzQpZ5mTpqxX8qQF+kQ6CqasMrWuDd+6Mgz2LReSPkJbRkLTDPi1iGPniqb9
 6DiFA7ccsu6j5HZgUVZYJHoexEt/C038N2/YDf7Wwn4cAAAA=
X-Change-ID: 20261003-gs_usb-cleanups-and-fixes-bc71af91c666
To: Vincent Mailhol <mailhol@kernel.org>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vh+24Prfb5BoCMeqnxhe5RWuOYmz9MX/V8YqNmtZe5g=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsg62J71pXOX/4NF7x1vJ28VTk3z9DjPKyope8g7jEeru
 +n4JdGOjlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAEyEuZyR4WCIR+MEjUuMZVdX
 hJhnbtJwdL3+ZNeP760HlVa3hsvVmzD8lTlr2xI/ecFTluUPTx8TLl2oY/grf0/NFN8+6WW7iy4
 b8QIA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

This series contains all the cleanups and fixes of the "can: gs_usb:
implement new features recently added to candleLight firmware" series [1],
as well as some additonal patches.

[1] https://lore.kernel.org/all/20260720-gs_usb-new-features-v1-0-427a8013c380@pengutronix.de/

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Marc Kleine-Budde (10):
      can: gs_usb: remove unused define GS_CAN_MODE_NORMAL
      can: gs_usb: replace all GS_CAN_MODE_* by GS_CAN_FEATURE_*
      can: gs_usb: gs_make_candev(): reduce scope of variable bt_const_extended
      can: gs_usb: gs_make_candev(): sort evaluation of device features
      can: gs_usb: gs_usb_receive_bulk_callback(): check for overflow flag if SKB allocation fails
      can: gs_usb: gs_usb_receive_bulk_callback(): add missing call to can_rx_offload_irq_finish
      can: gs_usb: gs_usb_receive_bulk_callback(): report channel number out of range error
      can: gs_usb: gs_usb_receive_bulk_callback(): reduce scope of several variables
      can: gs_usb: gs_usb_receive_bulk_callback(): no need to assign CAN_ERR_DLC
      can: gs_usb: gs_usb_get_minimum_rx_length(): enforce data_length of 8 bytes for CAN error frames

 drivers/net/can/usb/gs_usb.c | 127 ++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 61 deletions(-)
---
base-commit: 4fc3e28a2929f60f2a9f05c612f96384f8c8f5e9
change-id: 20261003-gs_usb-cleanups-and-fixes-bc71af91c666

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

