Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210A372663;
	Wed, 10 Jun 2026 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073441; cv=none; b=I1j1kV9mhrUGOjSCCiVjz1310AVASjWOFhBeCwBKJQ4CrTkU10GzCjkOsT0zpLRG/jWHYgW+OSHAR3C9sfVvSuz772Q0nASICHA5BetjnTx9S7TfCkHW49y1XROMGvdQpo3Uao8tOBd+SCtWn2ckNBu3qF3jkj4u9kSB4h1rH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073441; c=relaxed/simple;
	bh=y36luLyiZgtidk6T4HAJPmApUtNgxc9AfIJ6R+zzYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNtn1mcJWDtSQqofcq/757oDXq3uXAiJWaRpxYiIvFtTfkxjDv88VC01B1nFYBXJxCkkoMF/gu+JerHm9us1YZ75FiHsAMbpRxMnWxkISla/ggOKNHNI7w/kPSlBwCBfqi5ZYMNWzPGOAPE1Ddfk0kQHz5F4uxKwgUnZ0WFZHjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAYVMr3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAYVMr3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521781F00893;
	Wed, 10 Jun 2026 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781073440;
	bh=i0peh9BPV0yzb2/7tAvDBxb+1fXYB7Zsg7ey2Fi9LQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QAYVMr3VL8i2R9MeuoZCwTDDw/WAweSOBhiktrpWJhL+hTPub+f2EIUM4Yv/U1+kL
	 dH14bFzLv0AZQc/ccBmiiqSs7Qf6QC5+ex30l4EaWXrhWBlRCmp6HYRgAUE4JaFuSz
	 KIGnTwNyPOtu4FwyPVeX0AVPu4q22k/Qzz3cRBFtzdznfuOysKgdbTfhw8kf297+R3
	 MvRB88EUQbQmKjLcGMZyr08CfxtxRP+grSU77RDkEvUulRhOcoFTJJxDEQzfhIvgH0
	 YSjrNDUrzvUtUXH2RGaGrwXJmA/NRwJEx0GRISOLETlqcLzcSNsJUa1H01VXxUqzvG
	 goTUKOfj3pH0g==
Date: Wed, 10 Jun 2026 08:37:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	NXP S32 Linux Team <s32@nxp.com>, Christophe Lizzi <clizzi@redhat.com>, 
	Alberto Ruiz <aruizrui@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
	Eric Chanudet <echanude@redhat.com>, Andra-Teodora Ilie <andra.ilie@nxp.com>, 
	Larisa Grigore <larisa.grigore@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v5 4/8] dt-bindings: can: fsl,flexcan: add NXP S32N79 SoC
 support
Message-ID: <20260610-crouching-wild-mushroom-c8bf6a@quoll>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609142954.1807421-5-ciprianmarian.costea@oss.nxp.com>

On Tue, Jun 09, 2026 at 04:29:50PM +0200, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add NXP S32N79 SoC compatible string and interrupt properties.
> 
> On S32N79, FlexCAN IP is integrated with two interrupt lines:
> one for the mailbox interrupts (0-127) and one for signaling
> bus errors and device state changes.
> 
> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>

You cannot test a binding (in a meaning what "testing" means). Building
code is not testing.

> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Not possible.

Best regards,
Krzysztof

