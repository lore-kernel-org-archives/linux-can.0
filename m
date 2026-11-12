Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794474243;
	b=cDiAdvoQ89vT7cSC5NlIcmiWrIJPoYVmkkP5s+RIJJEUsqJm7WtuiChCqBpoCmHvhbpX
	 5RbZ46jtUELt6WGwlsWgJNITHpR8j6r7Qd4BWoSsHMEDBqFeGXWKWygqrND7UKFl7H/ep
	 ds/SsTHfRA2WMnOQc6LKBEUhxK7EmH1XVywFf1U5zuJLTKlXHX2QNwu8e1Q/830/piUW7
	 A8iaUSkX1YmcuD2cy7fdcKMJx0qPvxUxZKucJvApGZn9lHAw01pt3rec+6/Up5TC7r5zM
	 E9VAZzI+NmVgU/ynt/N8xnGyszJ3GIAMWt3ONqYHIdFVIXaY5OD0m46f+aTH+73x6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474243;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=dWFD3THYHsWU9y1SttPbbRwEUnR6O/yGa6Xh8feGmTI=;
	b=JaIve9IE6iDT+JtOwOzvxteD/RD2S33t1qet3XAxptazK2hgMN9VP7bCphReTOu5j8Md
	 kmkxku6EWRTfbq1ctHiu8n3eiQTD/v7dC1gR1eD74GDow8/QxU2k3juGLdBkSqhfRQfZQ
	 UJdfHixWlEnvx2nP0fntT1wYadicDQ5kxQmtxU95Q7zSySKJ8V8Y2RYRF/McW2FhcK170
	 GmlSoq/ywvegYaS+unMBSkYUhxqKeSrKEiJZ8NC2BS+ZvL5BBKB4Ttq4QtrzkDHpTWHEJ
	 MKt8nnAjacAqqIKD/h6pNo52orOMuJog/yrswAcej2P6anwUEC13WLkTP6vbdTyMHHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzilFVWX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72637606A332;
	Thu, 12 Nov 2026 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzilFVWX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DB81F00A05;
	Thu, 12 Nov 2026 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794474243;
	bh=dWFD3THYHsWU9y1SttPbbRwEUnR6O/yGa6Xh8feGmTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CzilFVWXa4D/+g2U7PP0xEDL4dLuN5Qwy4sUdENoRqLbk+axDMjvWlYZa40R1IaAS
	 lj8EZhkMlcRk0vzyCzu572Li6R/Hkh7PCHPVPR/MrFTIQC2IAAUJWS7mBvrKOetjHY
	 v9Zlz2U6EB3WJfOAEW1s5WpfBrrUCnvopP0utWfsBSkUuCkFvwu2UVRXIsrXFauYPJ
	 2AdvdPawNQEVyL1iAVorUBA0gjGtPf1hcQvENWCYVYHuZ1lP8MV/x0x5vEaRQj+xTR
	 UHAarNplydgfLH3Liif/hlv+SAe/Uo/LNLeKo+woO1bZ5xgr66r5oLm2VJRz6+nxZ4
	 le0JY5ibm/7Lw==
From: Vinod Koul <vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@nabladev.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Aswath Govindraju <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930214729.809649-1-marex@nabladev.com>
References: <20260930214729.809649-1-marex@nabladev.com>
Subject: Re: (subset) [PATCH v6 1/3] dt-bindings: phy: ti,tcan104x-can:
 Document Microchip ATA6563
Message-Id: <179447423905.428303.6835437411622016722.b4-ty@kernel.org>
Date: Thu, 12 Nov 2026 14:33:59 +0530
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 30 Sep 2026 23:46:38 +0200, Marek Vasut wrote:
> Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> 

Applied, thanks!

[1/3] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6563
      commit: b338621a7e68bb9dc91d08e1774262deb0db50f6

Best regards,
-- 
~Vinod


