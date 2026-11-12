Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488754;
	b=g7Y29IZb6+MZLnxZcVRvSiOk6l7mDUSI5zpth9Hpo7VrHHK/FhYT7zkfZHf9YfUciS2Z
	 0hKesGrFDOmms+tTi+VIE0QwqsGJkKfFK+RGsUyib4PHogWo16dGqgh6j9or2cqECEyXY
	 BNmeC/Iq7MN3OlWyFP4rlxkrQjo/VOo36VMcUkdHBkPA6vSVMXdbMfR6yaviPLV3RqzqC
	 fEM8BD5J2KKzzUJ0OhZd+MCefnFAcK1R0Nw5YA83CuY4CyjlIYyhqnGDwZrJQ29sUZb2x
	 a/dIGD/EMLvJqzEGBvaJrgzyI+zhIq9DUqN2KUu/zhN5uhXaN/Ip0IQQJIfKBv0vOzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488754;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=9OJxXrs1nkma0pKsbD4lFFNuZe+hFs0xCM0+CqRO/lk=;
	b=XjbqzNrDhxJtTuRBFSz/48ZAaqNZeHbS8Rv7nPvuyTlDUuQGFcxOCDT/EYbXGuMhXH5C
	 TEYFWOh2ch4Gz/Kgb/ya9hL+TkZVrXQ/mLrmlDrisDfTGIAN8vqYQcqX1cNvOW52rAOkA
	 bybX/RwvcOtylj34IHR6kJYVgnrp2j2MX71/OiJ9bGmoU6yX1L3aHsWVTskIHLx1RRWvX
	 uJSLphSojHy1OY83AWWhgFVtis9NJVFgTXRkY6on5iGyR9DdQSXVNlHQ6MbrwlvLaVHef
	 77bqo2hg2shpax9/PZHVh2J5jcESQdiB3wsloUGK0cCLiIoQRSZJuPMzwMzb1nP5VGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=eF3D+i8f;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5010606A321
	for <linux-can@vger.kernel.org>; Thu, 12 Nov 2026 13:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5010606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=eF3D+i8f
DKIM2-Signature:  i=1; m=1; t=1794488751;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:i7Siq8nb1rmV+ak7Yl2cFjvp4nW3
   eV8qb/EA0EZgX7sTTrvP1ETzyNv7mcxqXYhEbItAGqfqSprC+hABdyjgI1/KcCiVW/y5PgfHwzC
   8snIWNY6UVR5mcw1sDknHEB+Iniq2/1JvogTPylWwWVLcHZl9Q/cR0ssqN/Rb6THDhDP53J7WQj
   b+Jb2a6ROwDlO2lry+Z0AKUP+NF4anSxgL1/mCM24CH5GqJE3H8R+bY9nKQRtNqsR6ad8VuER6v
   oygF2DFJ9fqfPQedqgcovNntuFdFdcjcDYztwa3n7e3Pa1HqNkLsYjTOXj4TPw6puPtrQSfPHoj
   cKtdVt6YfsiMUg==;
Message-Instance:  m=1;
 h=sha256:
   pvbnKKE5eotjN3Kg7YTwKxJzUFO/P4Bda/F3ZKWKevg=:
   rfFYiyDduHpap8IhGnrUwkaLhdgUDz7iEC6HpRpCGMQ=,
  sha512:
   ZXM8n8K/NO/AtQbkHY8AUzkzy+dnIXi5RS67EgWiWbCm4nRJXGnZEIl5wEpHroEbaB2q31nWEfYosrkJh4IVTQ==:
   ZfJbhY/+QN5mGJeyUyg0bDIHIHqSvUBWwnYTwHrNJK/LRgm5x+TchiysZUn5gGne3N4bUODtMhWT+bwihI7/CA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1794488736; x=1795093536; i=wahrenst@gmx.net;
	bh=9OJxXrs1nkma0pKsbD4lFFNuZe+hFs0xCM0+CqRO/lk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eF3D+i8fUyb+dVsNrDRmU7OWbiag/ECITJj4l05VodkVx3zV65L+/hd2U9XxM/jB
	 ez1EdavHH5WIbScygdAGSAog9aSTrzALZItr5EOGKHx719etNMH1skJEFw4d7B0vF
	 vDIIvF2z2Nje4UdpFfeTdF4sV3AS+j2cc1ZEJTPJ2rWUztBtIhkPwtj7mSmW2imvY
	 Ffg/7h/HEKBG8N8cxCRSQEESoJDA6AUkkfQKL1uTXkjBHsyPg3zVYmWyIRXNqZUAl
	 ohUu2YrWpj8lBHc4/rm1ZJrSzKN/CpcWKNNEO5qq1w1tBJoDHjzfYeDIlIFT98KNc
	 R0QOj3W0peguqX1Lig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4Qwg-1wRFRB3YQg-010XtI; Thu, 12
 Nov 2026 14:05:36 +0100
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
Subject: [PATCH V2 3/6] dt-bindings: gpio: mxs: Allow gpio-line-names to be set
Date: Thu, 12 Nov 2026 14:05:02 +0100
Message-ID: <20261112130506.12823-4-wahrenst@gmx.net>
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
X-Provags-ID: V03:K1:rmhWLR/ud6QtamiptfgEXDjtj5eE6S2wUTxJqXyLxRubFhDBSfl
 HGZJcsv/5S3lt38+4pJ7Ef7AKfqbrVMwIPPBSnyEYYAnxqjAU9xv/uonRngY1+RzbT9HSUN
 rfQmWhds92BzLEUKKSpR7KTtsLOIJkH7sbFTm4J2xckVAC2k3ue88SNd/1ySy41gRyku9M0
 7WAag7v7pCHcO123l4sUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VpG8GIjBr+c=;DmL/GRMW99LVoNYQ3lmWQE5AL9y
 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

Describe common "gpio-line-names" property to allow DTs to
specify names for GPIO lines.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

