Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006503;
	b=QNbHsE4uYyNzsgYEtWB/5RBejIUCKNugcyvQq7NUoZMSHlKekTiN/DQP8WN/dgsmB+Ra
	 BidiRXFeGbn2jG6rDQyApchJo0sMwnX7UZ5SopfgPxyHzu/doZDQL95m07lRayDMhu+dx
	 bQdlG+5YkIalwRAOMviMWtqSVnPdHJW0JNjGcNsCdY4bguieYp09v7h+xHeMeZypo08fv
	 Bp9CRALfmUyYgfUn+0vCyt+XWgJRtsJ+a8r1XpRH37wTDJYC2UVFeNn/dZmP9jq+hEuIL
	 GyJA0SXKwVT3k62ja2Qy+WZpwFdltvIeAfnCmV4mJQcVFdyxYKLNrKeyoQJXEqh7WBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006503;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=F4aVukbVKqFvKWW+P1X4kJvr9YdOcK6VxZvThbRTXQ4=;
	b=Ru5fJ1go4aZ56Z8Ok/vnFboMO01IgcnES3K6N8rMsW9tKB8DJD0ypK0fBO5nxZOfDUUF
	 lHEY86wbr8b5tlbdmq87fbuh/SDUQjplnLhmF0PKqKOyGrX/uxfMMdS4fJ3Kjiz01NZHR
	 gAh98s5ofqj0vuLg9bx9ocYkrd7oOzslyoPRVMwy4/GPp9tYqRgZCUvTUyP6mas9JLX1H
	 WsKBy1Crb51Uzu/niQmsQLjGp+rtFkAY/XxCU7oAQg3WCK3rf/yQbNXMrdg/rJxUei8RY
	 qcbrXM45CVHoenNBb+/GqP/9GoJs19KTB15JURY5wTSUYR6YYBoeu65K3JQKhQ4t0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=SP3+FVmf;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD3606A32C;
	Fri,  6 Nov 2026 23:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22FD3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=SP3+FVmf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794006480; x=1794611280; i=wahrenst@gmx.net;
	bh=F4aVukbVKqFvKWW+P1X4kJvr9YdOcK6VxZvThbRTXQ4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SP3+FVmf/5Htq1WSMGYMMCxEG1mXIYy3JLsJsmW48GFt2imYRjCB+2AOKY/xxoNi
	 Kck9oy05eEUXj/jBz7gdp8r++u/Phio770ZPkChQdYSxLiN4iNFG4+AH0Z9/oDcyh
	 t0xbSrZrRA+WtxLPCL1X2KVUIm1y0lgzOtbKESEE9+6KcPf3nCKMzCGERSz8oz/Rn
	 Go9n3gsfkNT7EFB+POjnmgJs7XJJ3FqDrFmgkmdCBvvN/Z/axc3D3PgxA591H3aCC
	 x/2tUG7EFvvgvCXPF6dlc2Jd7HlkX0ySH1r+qej5etaxoeKgeVtmiGLM9fVE2iRmp
	 tqxNUiQ2lCJhySjapQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KUT-1wSQD849Sj-00vjGl; Sat, 07
 Nov 2026 00:08:00 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 4/5] ARM: dts: imx28: add alternative pinmux for CAN1
Date: Sat,  7 Nov 2026 00:07:44 +0100
Message-ID: <20261106230746.21954-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106230746.21954-1-wahrenst@gmx.net>
References: <20261106230746.21954-1-wahrenst@gmx.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nq1X6TPcjtomjhn1cuLIM+n3AxWlJQSRmiBBia93S2AZVXlwLor
 8i5kBJwF/s1C4yGFly4vXcNrDdXvzbJ0fYlg+0KBmm204y8buG+jkjka0V1L/fGhUe+bVYt
 wIldczFB20IUoT1aIONBN6ysTJ3My0cLnmLDJsSO2QVrzAXN9SfCThGBquAdCliVNgFWfOn
 tz62voHFCxedHO9f3pqvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oA6jw78F4Ic=;U0UIZ3Arhemey/jHrbp1A7he/lP
 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
 1bASK0fobgQ==

Add alternative pinmux setting for CAN1.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/=
mxs/imx28.dtsi
index ece46d0e7c7f..ee567aa6f561 100644
=2D-- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -885,6 +885,17 @@ MX28_PAD_GPMI_CE3N__CAN1_RX
 					fsl,pull-up =3D <MXS_PULL_DISABLE>;
 				};
=20
+				can1_pins_b: can1@1 {
+					reg =3D <1>;
+					fsl,pinmux-ids =3D <
+						MX28_PAD_AUART3_CTS__CAN1_TX
+						MX28_PAD_AUART3_RTS__CAN1_RX
+					>;
+					fsl,drive-strength =3D <MXS_DRIVE_4mA>;
+					fsl,voltage =3D <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up =3D <MXS_PULL_DISABLE>;
+				};
+
 				spi2_pins_a: spi2@0 {
 					reg =3D <0>;
 					fsl,pinmux-ids =3D <
=2D-=20
2.53.0

