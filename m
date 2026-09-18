Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32644C957B;
	Fri, 18 Sep 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729102; cv=none; b=n6+oi6LKC7H04V5iE1y2mpzvODcnxwxQwPjW02qQEVBOk71BG4oQeNeN1bJXaBA+Ep279QlMOnQm1hzFCd3HGGyFw7o88YbL1RHRTFydjjYiu0DR6HhraFY0ZdRtBB7z+s/jImZcsNq4wrSGrj+EHOixsKFW29Mp6m3lNJt8U7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729102; c=relaxed/simple;
	bh=dMVUjPAPcZ5t0i73zThqgVGb8fVx+3qXaQRGh15EfhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzrX9GmoozEgydcfz4rYiHBkLgXsyoWX0u7D49LWo8JFcRPR/OskHW8vml31G4RL9onpFcvErYmemSIdAUSPQXgIj4d8KYN1tOa8wnRgnJOwUtzozoTZgq0T9Cf/GhwGFrbfBtEHLekbnhkXBzTjynbi4eFLA7+/gVXNoBhhWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX6miYZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX6miYZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAB01F000FF;
	Fri, 18 Sep 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729097;
	bh=m1S/tznoTQw+vAi7GEBuHVHmSR4dRiXITXrdjAtyCJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gX6miYZROM/WCUo/3itVv5k9IdhKCUOYp45hmLgEMGezllawSb1SK0j27sP7PNRCn
	 4i7yDH67yBdTDtQNUZqOFuPJYGe0WA4hGMYwjSOhrVM20eKubFyzoz9ZTj6WmAQZGp
	 /BSCgWIeBaeq5Ye6kmnQdQISJQqTHoonzTc/c7PiuqpunDvjxrZ5fFsBZFihX/2wh1
	 5RxQTqW6FG4hcfTu2piIweKyYI8IB6d8hZlqF1/is8ons7X1fRY2506Ne9Stii2JHN
	 3BiRmQIQlXBW5pwGxMky03hSWjCP6oLU+sMNqYWTbF0Ssie/sVgKZYhcdC6WQSY/Nj
	 SxmNIETMxSgiA==
Date: Fri, 18 Sep 2026 12:58:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Aswath Govindraju <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6563
Message-ID: <20260918-energetic-cheerful-hoatzin-aac346@quoll>
References: <20260917062543.534416-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917062543.534416-1-marex@nabladev.com>

On Thu, Sep 17, 2026 at 08:25:26AM +0200, Marek Vasut wrote:
> Microchip ATA6563 is High-Speed CAN Transceiver with Standby Mode.
> It is pin-compatible with TI TCAN1042 and has a compatible programming
> model, therefore use ti,tcan1042 as fallback compatible.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

I'll fix up the binding constraints.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

