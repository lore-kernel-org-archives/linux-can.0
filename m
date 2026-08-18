Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C210403E8A;
	Tue, 18 Aug 2026 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044654; cv=none; b=gQ/ge7Bs81Z7AnjzazsV7wMBERqs7jNypTr4Z60DrcG7IVylJC2zWPqJieDcqTkCYJD/EUMaxeZnY+8rLT706+07u35vRQt3WJOZvxh9MTB9bG78ari/I9TNZhSvwSXu9Thbr4QkRU5GfW4TJLdhBto3u7j4pNrMzEkFCD1fPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044654; c=relaxed/simple;
	bh=EkYMoJjcd+mwxKhMnWeM8Yxz9Cd/JP+LxXQx3UAqzuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyUO+A0l0bfsDEczj0WRJSOd3Gnx5jYZ85WEOC5GbrL5h3sYnY3iU+gBSKbTY3hmZYfT3ezazBih27x9TS+vt1YxRXJRa76TbXpvxmwRU+Qpp8PkN1EOA/ekY4x1mAWRF/qhzyIH0G7Y6KN2ao80Uf0czPYhmkvpKDW1Dl+1hlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=oRQCIdl8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="oRQCIdl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1787044633; x=1787649433; i=wahrenst@gmx.net;
	bh=iuF51kNmtOoYiS4MLcYgZ1dxky6Wj1MsQju7qUjyp4I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oRQCIdl8ny3xof3xtP4aZwdFG1J4Lpe7c0LqKgxDPxSrtzDSoUPPRCjJRlcjocWY
	 lHgEOnoTh+6s5oB7IbW+CchLAWsT3smqhSwplLJ67y1M51MG/RVqmp0mmbkr8jviX
	 LZQxfPM60WG3e2/Hl/8r8NEv760AITTQjUQ0oRQ7zbMUXeTdAFNQagzjE/5AegPxV
	 RK8Muwhp5ji2mMM4iEkhg9/czbDTd1Xa4YGCf2ufAUPjLJrDDc7AxbNrbDcVk9BDB
	 Dc48KOvE4reVlKdEnYSdSZWxKDMFNfyND1zSt5kaVdL74oIHQkcdu0kCTX2M4e2eQ
	 Ww+WyJX58MTrFnSVug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1wZpZ02zaQ-00ljjo; Tue, 18
 Aug 2026 11:17:12 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC 3/4] phy: phy-can-transceiver: Add support for Microchip MCP2542
Date: Tue, 18 Aug 2026 11:17:00 +0200
Message-ID: <20260818091701.6441-4-wahrenst@gmx.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818091701.6441-1-wahrenst@gmx.net>
References: <20260818091701.6441-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+iI4FdOxeYBrIuzXz+MNpmbf2+f8+dgFnATdu3gbDBNH0p3QW0y
 ugK3AS9V0sDYPiva7t+7zH04XOA+fsw+30Cyr25UJZQRmkGNiaxn06A+M0Jhq7HwF1zOsV7
 WYTWmwrZSEMw4hEuZCYzQ3vdKzkNfPaW1VAzF/FgC6LyaY+26MF0hnmZApyxvVsG20SrqoD
 VoVhw1iwSrTa+yB7YG8FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qEqSPJAdZng=;bpecEOoHeFXwW7vrYXeuJg9Rbq0
 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

The Microchip MCP2542 High-speed CAN transceiver with Sleep mode is a
pin-compatible alternative for the TI TCAN1042.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/phy/phy-can-transceiver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-trans=
ceiver.c
index 75dc49e75ca0..1606384d4a0e 100644
=2D-- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -96,6 +96,10 @@ static const struct can_transceiver_data tja1057_drvdat=
a =3D {
 	.flags =3D CAN_TRANSCEIVER_SILENT_PRESENT,
 };
=20
+static const struct can_transceiver_data mcp2542_drvdata =3D {
+	.flags =3D CAN_TRANSCEIVER_STB_PRESENT,
+};
+
 static struct phy *can_transceiver_phy_xlate(struct device *dev,
 					     const struct of_phandle_args *args)
 {
@@ -238,6 +242,10 @@ static const struct of_device_id can_transceiver_phy_=
ids[] =3D {
 		.compatible =3D "nxp,tjr1443",
 		.data =3D &tcan1043_drvdata
 	},
+	{
+		.compatible =3D "microchip,mcp2542",
+		.data =3D &mcp2542_drvdata
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
=2D-=20
2.43.0

