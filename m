Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488744;
	b=ruALGCWmJIi+j+wZW3Ux+00Gny4ej13hPfDOyUF1Qd33TRsytQ6HQW7bq+eUZdmtijOe
	 Qq4+Rl4jnFZMpkNNWUWoB7zoQowmbo9cEMRATuSUbFB3rSHEtI9KVIarJQfQ5wa6UKbMl
	 DDL26idTdMybEBHIQbuAkDoaCEmbJ0FSXNIe1HgvpMJBE4n7w9B2uyEbxxWIwEp24Tl19
	 hrIxZnc+/7Dj0PHe7RBWGJkJTMBznnAj3wdTMNwdcNmQ6rSliDeQTNOLU5/GXQXM5rqHX
	 YiMJ9SC5j1LLF6r5QTtoD8xJ356KHdZlDVkho5gpfpjgk5LUV2BFohn4cPkZi0YMpAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488744;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=c2z69KVJe3u1aUsCRR50IFJdMIQMZ75r4SypIRJZrMg=;
	b=NZZhBv4urvyPpGCyos9WysUtOiOx7m/dI2OJDaVFNpM+7mZXqQYgg87+NAYBZmAh6olR
	 tTsa8OH98oAt+HqVpAus8Ma+UQoKuVkQHanIqQWwBnXDpYHXoqnFGIpEaybpVVc5xxt+n
	 RPszEKk+LDajHlC8IZPIP33DIJ083QPjse0iHlRPntejWSTCkZ73vFn8UsSan0srT5x/y
	 ya+WlWZ8rA/MPkuX9xKvVkU6H7NkH4mAheaCI5m8mXbnNKA35P7xdfPg7aC7Oikiuy2eU
	 u7+8Pedb93O3QRJAet2utJytsJc5FNcEhtkHMQzTJsqXQDtyRdWRuxSBxxa6oc4wPLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=S7nO8AOs;
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201F606A323
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 13:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3201F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=S7nO8AOs
DKIM2-Signature:  i=1; m=1; t=1794488741;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:ip0hYR51OLjFHWnnNWVi7AxODokC
   F5JDT1YaeUexNGDCw8Sz1dMKLi7e1qolpJCQF3pW97ogaBbo0dqyNfigm7a0rhZgBCAtP5+KR2c
   V4ptJcisv5ZLhrhkDREIzTX6GvXQOpgXGmGgjwzNwglwcMrt6zYs8sJ2s3+ytUNRfxIN5rfqD2S
   vn/ooFuvUje4DTiyC+TDwURovF6cPFtcyCDko17IwG2VyWQvSpZHpzzK0ydWbZUYB/f1geB8hI9
   gqu8R7I4/C+zFYDqmjJ4wVlnpKxL2JnBfBGDQxWxcVe5QK5ynakdBArh5Zun+DbOdGeJJx5j/az
   gRdOoUlwjRuMZQ==;
Message-Instance:  m=1;
 h=sha256:
   b0+azF7cUSuGj3arbN5jEbTzTrvIQhDmyrMlq24s8N0=:
   FJd8HImp53+IzwQKxd8edEXQLcXHRP9hhlWdAalERTs=,
  sha512:
   JfdWpDLXC2fTWwOzSIR2OQdZ8wRdAjMs5Y9xl/4HDJsUhM6n32oSl++B8uF0YdkHA4+FP6N1qG6o7LuHtjmyFw==:
   ZARy66zu8Karuc/TkFEPwfBQNSAU+5sriN8yTzJtazLpfoJ4vgmpy8WBBHTCcOpm5OkaU0uJcQWEKZsipTulvQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794488733; x=1795093533; i=wahrenst@gmx.net;
	bh=c2z69KVJe3u1aUsCRR50IFJdMIQMZ75r4SypIRJZrMg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S7nO8AOs6pFwHCHCh3R6zQr2SFHGNMy5RiV4rxIL0Z1c20HVb9nlv4Rf/2qpmfUY
	 mWyaSTfcQF+rwlmPxJ1fpG6MN6RmnEbw12VjK3nrn65sCCFPLC7eznhSjxGbRLHWF
	 rY2UICSlx42T6hKHmDEVdjsrRLveCPNu5bzgJewAY+QfqSxzdHdy8KuZ3lwtJrnNe
	 AJ+LbVNNJcgkNxUPV08owoy5tmnFyVv5Ivh5hm4KWsQPTN9X4zB/RxnvYBruVOwup
	 HvMkbd0UY+TzTW9uuZaBtRpRO0oeFae/Io8zEbaKNla65DDZ7maubG0wYG0BWo4Bp
	 Q7rwxvY+3cIw4HPCqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1xRlbq1H3D-001nxN; Thu, 12
 Nov 2026 14:05:33 +0100
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
	Stefan Wahren <wahrenst@gmx.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V2 1/6] dt-bindings: arm: fsl: support chargebyte EVAcharge SE
Date: Thu, 12 Nov 2026 14:05:00 +0100
Message-ID: <20261112130506.12823-2-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:n0eJrjmIfgjPrqTRsqC/sIeDJKGBBOwN3IyX1o3oL+7xcffyFxT
 7BK43e7xvpoI5Dz6h6hiLFLYgGAvTklp+iNZtpRwOpsFzl7ErQnhQSPpfUo0xcNw9JL3CPN
 WekvabYOCg3VzhrBma8txLaDkZ6K9/0nG8xWhTJ6dHfhMl8dCT6IEUpN8DmaeBSHXeoRHbi
 zssqR1C4KAcJ/L42lMC0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iT7+U31niCs=;7vSkgsi2dV22vcciSNgmJw8DVyW
 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
 lWYlSkVn897AS3PR+5Q74R8Vo53GJ8=

Add devicetree bindings for chargebyte EVAcharge SE board.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
=2D--
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentatio=
n/devicetree/bindings/arm/fsl.yaml
index d0126f54b387..65cfaf5ef6d8 100644
=2D-- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -92,6 +92,7 @@ properties:
               - amarula,imx28-rmm
               - armadeus,imx28-apf28      # APF28 SoM
               - bluegiga,apx4devkit       # Bluegiga APx4 SoM on dev boar=
d
+              - chargebyte,imx28-evachargese
               - crystalfontz,cfa10036     # Crystalfontz CFA-10036 SoM
               - eukrea,mbmx28lc
               - fsl,imx28-evk
=2D-=20
2.53.0

