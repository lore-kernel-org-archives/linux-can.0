Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006496;
	b=LRVjClUg7IthWTJATcvrFWiXFQ32UGGZcboxf02ZbknSFy2bq+W2kmKAxsIF+VqZcFl6
	 KI01hZ0VRvHuNIUtRdW6vrIXwtMeG2MsXvgSWdghDbOXZwW6aKxdLhxsIjoNVpfLQWAnH
	 SqsIRqPGMCwfPNj750HqB/BIJ67Svq+U7Hs+GuldBKVzQA8O579oekZX3FpMONg2PjYfz
	 P6ullqI40jcsPFqcahvHyLM4IRB6/urzS68HRpPDzAEN28mAuMcWMKG2kjBun2wBmMzLv
	 Mz8HEg9oYgi7NF09Ej3kDzYJR1JS+eziz+jkxQqPLs+jVz/IuQeqyXrz/kqG7CP/F4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006496;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=WNhZ3bjj2Eb8mgbv1kD0sVMUWIuT3xxiAYU3u8mgKdw=;
	b=2/6bViQVoblAvQDVpH9qOAiNb88NR3Lu449lmOs1U/SWw7yvS5xpPHQl9E64MMT5pCP6
	 ErtelWEzJeLzFWHIhb3woHrVycBLuZM+iA96L7Bqf3/ahBfgXDqQlYfZ+lBcyFOlGFqIa
	 xV0q5C89gA2Nd1+KdgmL9liUBsUf+sBNzd8RKa85LSTaoV17OpWbvYMOhs+M5dEQ6A5uK
	 CoCxc1mZweH2It37nPqb4/bAdjKNaolLncEaRp95uacZ7a6RTefSlwraVriK9acpOJOGS
	 u1fAsC33FlWqc9zYpP0oYAoepUtoRfV+qC7VZFctmusehLe5Japdt00Na1WxzoBJ5yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=LHwt77bX;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03A4606A326;
	Fri,  6 Nov 2026 23:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B03A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=LHwt77bX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794006479; x=1794611279; i=wahrenst@gmx.net;
	bh=WNhZ3bjj2Eb8mgbv1kD0sVMUWIuT3xxiAYU3u8mgKdw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LHwt77bX/IgrWrdyom8a6kWLJfkBC79Zw5uEEVXRdDI4ARWzVpAdqndbJbTvRS5l
	 WXIsI1/7+JCX6R/2JVfek7pNLQgRag6rtlz45OODX7fh/gYjU8mqQ7/84mc2x9M1s
	 aXukemyj4eTo+hDywWPNYSBc+yvSACF1FejSb7ysUaUI1hzouJV0UF0if8KMmBGXM
	 hWEgwDMqdTJkrfTVQ8JVYbaYMZE4p1VZ5Rfl00bWQAfwVD+pyuPRvaGY6xva7qART
	 bJUQFg8+zrSYRcbR0Tj0/Uhg8FDmJ/P1GUalhygsonH8ogc0T59lgtAMK+zYBklpk
	 0Thr2S18aJBjjhz/YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1wTWfr2K2v-00z2ed; Sat, 07
 Nov 2026 00:07:58 +0100
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
Subject: [PATCH 3/5] dt-bindings: gpio: mxs: Allow gpio-line-names to be set
Date: Sat,  7 Nov 2026 00:07:43 +0100
Message-ID: <20261106230746.21954-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:H80gyH0AAke8yHwE10gt8xbgC3FEgZ5eLkSGucmI2e3jldXufXk
 eoLN+eO66OHHivXhP4Fy8HVhwGdGbtDx2YZqtUHwT7zQg2+x07mQYfn+a51CqOXajp/bEPt
 YzOZqiQoeEzo1Wxw+dW4V3592adbJIQRyVw4od/NzkHJk7vn5O+iuMsAGuwU7MHSij5/T0V
 2jmzhMOy7cSCISbH6fltA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fDzb8SM7lac=;pWRKCZYVT7K+5JOFjrCp29AU1V/
 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

Describe common "gpio-line-names" property to allow DTs to
specify names for GPIO lines.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/devicetree/bindings/gpio/gpio-mxs.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml b/Docume=
ntation/devicetree/bindings/gpio/gpio-mxs.yaml
index 6cab04ebbdd4..79c9b0672334 100644
=2D-- a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
@@ -119,6 +119,10 @@ patternProperties:
=20
       gpio-controller: true
=20
+      gpio-line-names:
+        minItems: 1
+        maxItems: 32
+
     required:
       - compatible
       - reg
=2D-=20
2.53.0

