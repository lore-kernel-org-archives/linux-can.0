Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006502;
	b=cpWj6R4QVJ7WVckOHuwFHA/KoRdPH/b0h0c/J7zp9c1+7kaRb8CzhJhe4T7iFOT79urj
	 DMAotkRoMb1liHEKSxh5C4BsyXc5vz/PFTPCKMc729BeN10WrEAQoZMCphIy63NSwLdgB
	 sZMq0HKAvERaEHeXk6mlCUxGS0lAcgIlABDXWZlckQx5P3jBJ/dM9k9NtJz1SiDb3eNx4
	 qzm+xUMwQ6HJMDKFQOOpDYcO2kQtuRAPycGghNeBNI5zkJAFLbY8FJKFiPN9VC1yLVLwr
	 Qk7mXEjTaCU9sHYb7texIqB5IYMFQNgGjFdghmwzTZIfT6hh1s/AnlW2CyoK/Tpc7tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006502;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=XCphtgwaHYZiYUxWeWHC58n770OB1zHXs1a3OI8IrcQ=;
	b=pVH+u6plT5DpGrJsAarZPdEkHeobdbGpROjFXws2dX84cePGnhORTHdexRu18c2BsGEd
	 ncbL2tu1IRecigzXLnDV7sU46Mp6sA2RbSpxKvSOaDvNkz6kcQzzReK+pvDqfZOE9ZiF3
	 f2tfcJWLAXTtNBnXIVMBGNzYxdaGb31maiAvKMmMkXYSbt7qf/MeinmiTzgOmQYlm6C3y
	 45IBQJKKWygUKJoi2nG1C1zMD5/O6h7LQaNwx2oTOwsrn4S/S8NByvL4gA+jjjOOwgew4
	 OeFedvL+1hWkAlQeqHXxsXA0X27UjWEazfxZj7fNY9ukroxSiVK5e3BT7FC0s9fuRhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=uZuxI5X9;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBC606A32D;
	Fri,  6 Nov 2026 23:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2FBC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=uZuxI5X9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794006477; x=1794611277; i=wahrenst@gmx.net;
	bh=XCphtgwaHYZiYUxWeWHC58n770OB1zHXs1a3OI8IrcQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uZuxI5X9rIHLTSy210Om8GXdglVILy0XpzNOO30pSjzUF1quxmFr12lRwDDrXL8r
	 1EQvU+/Jbn/L0yl7WtGQ+vLFDQGaHbZuKo4Zsf7Qu3XBe6uv9HHwzGTtEyV2E8nCG
	 Xw9fGAtNvS2YapWHQb9kVqtJSHu38uhM4HpbyEDo86rkHdPlQBNf244UK3f1nG6kz
	 UG7yrb+i9Qo8URdxSCmLfc0K+80iQ/4Z9N9InUk5WEKvrm3jHR8JdZ4bYrvIRCEl2
	 gJ9XNH9Sr+XVWoBXQyUBkIh0SFkCKmECGuDMPjVk2dFsq2k0fZ8Ky0Ey+64OYkb7p
	 IAsYVkTQZEFJL1eztw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq6C-1wWWvt0lOy-00znrO; Sat, 07
 Nov 2026 00:07:57 +0100
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
Subject: [PATCH 2/5] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2562
Date: Sat,  7 Nov 2026 00:07:42 +0100
Message-ID: <20261106230746.21954-3-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:bXxG0jAVjtmve9y/xjCIIJM1iA1UrB26zC6D6dH8gh4JusSJ7Wq
 ach7hxTPRzkq8qWx9g807ghdD6rIXl5SozujA8UYY7z73OrDdNjPsqLI0eNLDNWUkC79Bu2
 WTtoa7Fd4obpE3suwxGdk6Copi/80eWG806xXRTXh2PQKl/zsNkqntojlfX0j4Nl1hCMeuy
 BV6q7s9YwgLi+/1Zlvk+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EtuJsdXVBkc=;pxX6LLcna5GF8dqhbtsOAWOCD1H
 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
 FPRpJVyU5yVbpNRpR2dw==

The Microchip MCP2562 High-speed CAN transceiver with Sleep mode is
pin-compatible to the Microchip MCP2542.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/=
Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 1a0dc9bbe6c9..7c356435c03f 100644
=2D-- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - microchip,ata6561
               - microchip,mcp2542
+              - microchip,mcp2562
               - ti,tcan1051
           - const: ti,tcan1042
       - items:
=2D-=20
2.53.0

