Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E63B5851;
	Fri, 17 Jul 2026 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280028; cv=none; b=jkIhbNHrNrgEEmybV3SB7ELRLlO+z0mlQRoBY3Q1LXOH4PLSyVpruyF7tcd9bGpRQekBYdYF+8uwv0hXGOkt6sE6aWGsxzTtY9LaY86I1vnlKc4R0wAmvBpkQd7dmfxJX7qUa3H5Y77Mx/iF9lm2Y06P2rgscOpsCEBgNJZoZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280028; c=relaxed/simple;
	bh=qktFMz947HYMRW7S0C0bFpl11gPHJx1tasL7Uta0rWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oe/K8a9tSN3dqmIxLKgH5ix5KoCYgDFlCznY+vAPFewXjLvS5b4WDe0uA+qQZy7i71iBAP6ltvPTRkKmY31u8xGlfU/EzZsQRmU09M82JtikCC40q9xjD0ROMXvAo9JBoMuGOfAnaGR4th/O3rprpg2NlwM93l+LiWuYJZ+/qGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sjxw9Qwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sjxw9Qwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EEB1F000E9;
	Fri, 17 Jul 2026 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280026;
	bh=f4R3cxIMePttvrKg1e90PVDnx6t4gSLZY45tTG8rEzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sjxw9QwtTff4v6rLg2EnxKi2c3nqfXvn1+TAmBhdP/gVmZpiJMidNATRfUWs5+RSI
	 UAdiidABsFIEXZ4ukiAKP5en0pOxDCV2qr307JTiYnRre/GMdErB0eUEvw1Lq2roR8
	 9wl5cCw+EtjQD16WgrYjooXu9lonzUC9Lyydta4HBKEHQ06gHNEC3CmlxexoAJWjpW
	 szeTqTsADnjozyVXxps/2nqHAqsCIa+QzdD/4UnROaPDbAD42NgctOjrRsKg2u0uGe
	 NF8+la8yN5zUU5vYUvIgFYQWNvmMDTjsUbk8t2CTNTdN3KXglimdGmFUTkKD01tZyj
	 3+JDZ3+g2H6yA==
Date: Fri, 17 Jul 2026 11:20:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harini T <harini.t@amd.com>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com, 
	appana.durga.kedareswara.rao@amd.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: can: xilinx_can: Document phys property
Message-ID: <20260717-determined-mindful-dalmatian-bfa374@quoll>
References: <20260717021415.2234865-1-harini.t@amd.com>
 <20260717021415.2234865-3-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717021415.2234865-3-harini.t@amd.com>

On Fri, Jul 17, 2026 at 07:44:15AM +0530, Harini T wrote:
> The Xilinx CAN and CANFD controllers can be connected to an external
> CAN transceiver on the board. That connection is described with the
> standard "phys" property on the controller node, pointing to a CAN
> transceiver PHY node which models the transceiver and its control
> lines (for example the standby/enable signals).
> 
> Describe the optional "phys" property (a single transceiver PHY) so
> the on-board CAN transceiver can be described in the device tree.
> 
> Signed-off-by: Harini T <harini.t@amd.com>
> ---
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

