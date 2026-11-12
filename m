Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488784;
	b=I8hJw/WBf0BYHa9dbb7U/B+NN91geN5MXdeUoN2ncoMuH+aaAHNCtuof/1yKS3oOHd+i
	 Qk359NpGAKcJtPimejQs2R81lh+4qxyoqLXyO6HEq0BH4/wCICwZ7vybCZeynKhiCDmVg
	 1uwAg5Gy5N1sWkTJ3FpucWy9IE7WSZ69qsllZ3pW6yCWQGgqB2DY8DCEzBPcgbt6raZ7z
	 3+764fXvknxC+KLJzLAGsYt6aFN0qw7aP+znKBPYNhTU/r8jhunZWekLz2vP6eNmwP0ia
	 zbxbUhRrQnymivTnObCmgV3Zzt3LAmvjD7FCEfL4csECFh5pACi4MCpyJkyZEuKh4wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488784;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=F4aVukbVKqFvKWW+P1X4kJvr9YdOcK6VxZvThbRTXQ4=;
	b=3o9O5tYLj+1QB415387O60npJbEEriGHwPdmTL2TnGaG/jNzoLLuJ+G9yAN1A5wKGufb
	 A5CzeQ/BDYKplPNP3Egk27/uzAy11RD5ZZGlYgO10hDMrmytrmJCEmJRmXeAl10Ct2942
	 e4P+0AJ/NUbpEriZc+Dh/zcbLFPlU2QqezlGrqES74gxcMqWHe1uuhlbbi9JIlSgayx4S
	 hkIXsFaoMFg7zznXlbGJkB4GpsEZXCvcmKSekmPh2Z4i+HwhtsBfnk3UyAF7ClYCA0X1x
	 6yacSY5d8D3om327h41QYWkzK09NsbZeH9UA94TwbwRB/XtPY+FDqW3DKgojBUjUTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=JOvWtnz+;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16973606A32D
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16973606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=JOvWtnz+
DKIM2-Signature:  i=1; m=1; t=1794488781;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:nC5ctze+TdrReakXfbrZ+SA2Z36d
   CLRigYgtQlqqUmDpHAt9/PdlZYTwhT5QZcoBWTMdjJB1x4W6vTi22xMDdRk+Sl+D8IWVB80wIdy
   9rvMRlfgH7hZB3GnaqKGFs9e1i8zmqmV8TyMHWgg1fbZGKMO2/r3tj89Pxyxna+joYUt46cw1W3
   vcKlDS8gDP0V+HlJvf/93FSMWYSrvmsTvuwFlBoF94Yayz63o6bpm2oUhFe3kls5LqN/ACavQjY
   8hISVFMW6lBbBqj3Uz1dSaqwJxPPNoWPh+29LuR4CA9uJem1kfFw74LSlcDHlAfwe4yVIYXUOOn
   4zr6vp7KvwJPKw==;
Message-Instance:  m=1;
 h=sha256:
   rThwJmOtFUkqksKtxx+F+Bn0Tbm6WoYvKtjzPqv/shY=:
   hyoMxlfZ1RSWM87Hy0vFgNvILq5dqvyxBgfAbn2wK/E=,
  sha512:
   cTOzSYnti472YTi+yi6Xmy9rLtWh/GrZE7juD6odlUHYUNqQaBtR1rxCbGIopH4RG6cK0z2ySUXaI4HmL++nxQ==:
   rZOa6D1L3Oz2zyw3RadhmxGG89LsZpfolOut+2sp02AqtOrpu+WgYo3pCheOf5FfvJHXY0/84YbNW0RBY56Ruw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794488737; x=1795093537; i=wahrenst@gmx.net;
	bh=F4aVukbVKqFvKWW+P1X4kJvr9YdOcK6VxZvThbRTXQ4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JOvWtnz+qETJcBiDF8Onn8QxPZzzjkAN+nUN+AdY0sO5wt2BRD7+IFZhl+WXnYGa
	 oV0Ljzhh5eMtEw7BPHRjfna81ny2Sx5J+Y4xduiw6EjLCjx0AOvndFytnw/yDainQ
	 OjXHfFT6EseOlQhyYZTGkRSYdP+A8WeSfdSFYRh5nbrS1OkoQaKIAXZ5N3JEidvQX
	 R6EVqKwQXbqFJYO2SK8p+4XXESdrvx2CR1CkoiEpScUiSEfXiJ1Qi/JUeSvpTs4FL
	 Te5PaY5wY+6JuRbYfN1i5RK5LMfQGtWUKy02tWAaw0broMt0/bPH3DCbOOIElraNu
	 DjfZmtIImufk0z3TZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6Mt-1wsQnC05IJ-00arj3; Thu, 12
 Nov 2026 14:05:37 +0100
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
	Andrew Lunn <andrew@lunn.ch>,
	Manivannan Sadhasivam <mani@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 4/6] ARM: dts: imx28: add alternative pinmux for CAN1
Date: Thu, 12 Nov 2026 14:05:03 +0100
Message-ID: <20261112130506.12823-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130506.12823-1-wahrenst@gmx.net>
References: <20261112130506.12823-1-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:eqY2DBwO8mluIcfS4t4H+MZBgbBYPa/SdYHxCAJpNF81hWbgkim
 7COUSJ+x7JwU0Lh6c4BBhAvk4iCiqy+FUGA2tJ7sHZa40sLZer92l1TWnK86CizhngrcjJc
 eaNJYqwQJKA/DnOyiF4DT4CZELEVeIA4nVHbje6OlaeAtG2Ca1tfJURAaWF/1614YT2bhPg
 DkOJMJUulq4iMGRAC2BCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NyvWIWvcBz8=;xMK7W2XZ/HLoBcC6tmPot1071nb
 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

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

