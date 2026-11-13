Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794554012;
	b=zif8vgQZ34q28774Pgm80uc82NJ1mjg4Mu9726Zt68qVCNJty6NcdB1tlKfvNLJQS5zE
	 clL7AbjTr4xnDS6MU9ugqYuzRtJfmgIWC4sYP8YGDat9o1a4uuXjrXNQ7mn1VnolmiwZN
	 /piwhAFBPy2Yr7ZovC7osAFWDyGBXaLHPnVZY6OISaQm6AgkPGJTZXO9AA5Pc3YynEkSo
	 cTveHrqbQ/AH00584WDOGaKGtbr4+l59i+fmsB2ooOVyFqMgsrJM150TfVJybpI7AkFwx
	 z0lN7el35hbNGIgo6BEZdywyG9S2qp3nDqxs7kXFCCOV3fLMEOqZ0FFSw5G0fn3xWbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794554012;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FzYdAfkbjY+syHdStaVPJXwRM5/EdRqrUNELRQqSmHo=;
	b=LIMoWmBMiGzYzF+bjZOAWsFNA1X3RgIZk4olQ5eOraC15Qkfis0SjWMmJNsYqX+S/+U1
	 eNkETtQCbPSz+dbq1KL0YkteGBE6Mgnpvuf8+3clFjfJ73mBXIDM5WIYJSY3cDagYhSBD
	 GVUqr722t7b4ifSFAE4mGwsMd1ALI5AwlEHi4a4AvTAivugsOuCAFVDRPJ7b7JxS6tCuP
	 fT36loGn8TpiElFVNBoyfvhYhCFG5QjH4Tyk2J/ucWVi5Ggzp+44D+pLWIyHAj/wn0g96
	 OtH/8ASe/lVe1q8hBkMZdQcDitmDb27n/sQHwfmTaRDZCwYeOlRCNdiiB5VCBDfk43A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GLnM35Ov;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695260A3812;
	Fri, 13 Nov 2026 07:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4695260A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GLnM35Ov
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DCAD52020ED;
	Fri, 13 Nov 2026 08:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FzYdAfkbjY+syHdStaVPJXwRM5/EdRqrUNELRQqSmHo=;
	b=GLnM35Ovgry5goLFYkUJ+cYVzXVsVxqI3Qx/x1OTZj8+q7g36arHW81uG3bGKne3/iiBIK
	GUs8omDBe5yMoOQnhjPzd+yYIpyDD9IQ9+bz/FqpaeKaZJ2MkBL6cz0o/x8BFrdHTGdimO
	NWvytr34VAZmGR4ZS56BgQ9ZS/XC1auFNybEuznDYiKVVwS+UZldKHgVhN/J9jvWR7mhZs
	Jf8b4JvirLI4XdwmsOt77KSdP58IU9TY8S3zo0b+pyakQ0oByVgbdOAQJqezulJWCpC2YI
	qB7G/6uzXy41mZCPIeqV7/rmvhudo950jNNjxGD5g1sCHFeepHPDBGC6twSEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794554007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FzYdAfkbjY+syHdStaVPJXwRM5/EdRqrUNELRQqSmHo=;
	b=VmCF0QQrKDnAs8aqJ5a3r84wSaJ/7m+nAPgrFeR+dGcz9/yaQHKm9Whsuf9d2DmGCuMRIU
	2KcJ6DuiNyZjY0Daqkz8kMrTie9NHWwgz9G64RSGHC1jguOYcvdud+2d0ArDXkYDQ36D/i
	N5dP1LiSs2YGpNsX58xIto4pL7jEiMBQF7e2MijHxOgZsWwtJgt4lEH+XQp9wPSDLTIWy3
	kOxcd41GKWsmItHKa85Vl3CaTJL3Cb68iRkeAxXcOt4AA1L9TxHaqbtMyqRBmXUaCsYRML
	xqBj22AAL6rSeUCcfLvgawFCzRIeGsbePdYNWXJ85kmsxiZNRC3Jr4UiZz57sA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794554007; a=rsa-sha256;
	cv=none;
	b=C0z7rb8oWl1jUo6pLgspRnrI3D3IgPiIKV8vam51s7cQjNQAuUgkaIQNGoc/hA6vB9Aq89
	DWeWIk38nm0YB3wXy0ZNmOpMZ5P5udEYF0X3D1ZeFq13gcEunSSRyPAdq+WqwdcMyrA3n1
	cKmx/+mcNwPjBmT/zyknEEtiWTHUSfWJ2mlCih2FPupLLs812HhCfWKiksTpMHDtjtQWlL
	ERJfD6NW+Ldc2BEufwDLjpZKzLMKIN87oHkPZ57YiSVhnCDzsI1RT8v6XboD9bgSl+fEUn
	akmc8A9HWMqS63jX4FpDAn6xD3m6I3+jwjo2Ym/0qgDbG47PmTzuw+9ZdKU/0A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRlTT-003xHn-2b;
	Fri, 13 Nov 2026 08:13:27 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8623A5EA575;
	Fri, 13 Nov 2026 07:13:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 0/7] pull-request: can-next 2026-11-13
Date: Fri, 13 Nov 2026 08:08:48 +0100
Message-ID: <20261113071325.4092169-1-mkl@pengutronix.de>
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

this is a pull request of 7 patches for net-next/main.

This series by Quchaosheng, converts the textual device tree bindings
description of the bosch,cc770, ifi,canfd, holt,hi311x,
fsl,mpc5xxx-mscan and the aeroflexgaisler,grcan devices from pure text
to yaml format.

regards,
Marc

---

The following changes since commit 573af801552999954caa8347e4490b04cf4763f0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-12 14:54:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-7.5-20261113

for you to fetch changes up to b9c6014db75bdd27aae83f114ead1c9b0ba76879:

  Merge patch series "dt-bindings: net: can: grcan: convert to DT schema" (2026-11-13 07:35:14 +0100)

----------------------------------------------------------------
linux-can-next-for-7.5-20261113

----------------------------------------------------------------
Chaosheng Qu (2):
      dt-bindings: net: can: bosch,cc770: Convert to DT schema
      net: can: cc770: update the binding file reference in the driver comment

Marc Kleine-Budde (3):
      Merge patch series "dt-bindings: net: can: cc770: convert the binding, fix the driver comment"
      Merge patch series "dt-bindings: net: can: convert three bindings to DT schema"
      Merge patch series "dt-bindings: net: can: grcan: convert to DT schema"

Quchaosheng (5):
      dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
      dt-bindings: net: can: holt,hi311x: Convert to DT schema
      dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
      dt-bindings: net: can: convert grcan to DT schema
      net: can: grcan: update the binding file reference in the driver comment

 .../bindings/net/can/aeroflexgaisler,grcan.yaml    |  65 ++++++++++++
 .../devicetree/bindings/net/can/bosch,cc770.yaml   | 109 +++++++++++++++++++++
 .../devicetree/bindings/net/can/cc770.txt          |  53 ----------
 .../bindings/net/can/fsl,mpc5xxx-mscan.yaml        | 109 +++++++++++++++++++++
 .../devicetree/bindings/net/can/grcan.txt          |  28 ------
 .../devicetree/bindings/net/can/holt,hi311x.yaml   |  67 +++++++++++++
 .../devicetree/bindings/net/can/holt_hi311x.txt    |  23 -----
 .../devicetree/bindings/net/can/ifi,canfd.yaml     |  46 +++++++++
 .../devicetree/bindings/net/can/ifi_canfd.txt      |  15 ---
 .../devicetree/bindings/net/can/mpc5xxx-mscan.txt  |  53 ----------
 drivers/net/can/cc770/cc770_platform.c             |   4 +-
 drivers/net/can/grcan.c                            |   4 +-
 12 files changed, 400 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,cc770.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/cc770.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/fsl,mpc5xxx-mscan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt
 delete mode 100644 Documentation/devicetree/bindings/net/can/mpc5xxx-mscan.txt
