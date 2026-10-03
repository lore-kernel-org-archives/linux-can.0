Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551703537E8;
	Sat,  3 Oct 2026 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018398; cv=none; b=o9ADtmDg0kszass5yFs4M12sk/UjOl/0HNkdEBgnV0OsO61+nxhZdu7C6d+KyX6+cqT17GXBdxsxzhNZEGyOH5oxLxn7Fr/qVg9uxXx8xxzrVmZBiRRV7wYK9usyerslQLijRtPXML6txSCjTX5NbAFlIwaWnDEhBlDoulwtMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018398; c=relaxed/simple;
	bh=C8hn0OmWEwKv3HFnLyhjwUesJF4WIm0deCXPX3bqI7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJUsTWlpIlfrl9QSX6/rEFbFD1i9Cplz0u8puKXB5/wQRRUXle9og30IXDOFy6Hg3gSrY4hSYylNS2/dHg7hkOnDWGbuTJA2D7uuDBWjvjmEDZPA3n6cv0yAGqXcZB5Z+e6mACB+W6zQP5CqieOCaH9noBW/qGUn7jkacfLWGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBGCzPG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBGCzPG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CA61F008A0;
	Sat,  3 Oct 2026 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018397;
	bh=Wv72l0hD8jDyK3VWKJExO+bl1rbU9EYOwEy7E6rmeXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBGCzPG19VqMPJ/xEM8Kkge9Bg0ygZJ3inmdOrgAgzhyOYWy6+jmxQqIPUE0f5o+I
	 p8BF3hziXT/Z0Y7NjBWfY6ArV8LakvLRQp9yR1vkbBYn+1XXqIur1qqKL2Ohkr3+u9
	 7STomURNJ5izwpHrRPZ06G1UCC9UMpsUxY93RArxjW0RY/QpFba+MtYC5n1XQc//rb
	 bV6dPQAEzoCucmBCNcGAcvjyk/HU+RrU0MkBwALYpwVaaCwZeJvysAA7XuGkwlxds2
	 tBaQzRuHZPjIXOyOmxj8f6J7D8FFVZmyd+r4QgrdYiPYnjwy+YNnfYbWVbis9Rvx+T
	 ZcO5L5KR192GQ==
Date: Sat, 3 Oct 2026 11:06:33 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Frank Li <Frank.Li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	Aswath Govindraju <a-govindraju@ti.com>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: (subset) [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte
 Charge Control Y
Message-ID: <asDFmf_G0v_MWY3k@parshuram>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <179016749941.155868.1810345055482953110.b4-ty@kernel.org>
 <72033c48-5219-4ed4-94fd-1b7d8ef8017c@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72033c48-5219-4ed4-94fd-1b7d8ef8017c@gmx.net>

On 23-09-26, 18:11, Stefan Wahren wrote:
> Hi Vinod,
> 
> Am 23.09.26 um 14:44 schrieb Vinod Koul:
> > On Mon, 07 Sep 2026 17:04:16 +0200, Stefan Wahren wrote:
> > > This series adds support for the chargebyte Charge Control Y, which is
> > > an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> > > Charging System) charging stations.
> > > 
> > > sashiko reported in the first version of the series [1] that X_nRST_LAN
> > > is available via GPIO line names, but there is no reset mechanismn in the
> > > device tree. This finding is valid. Since the reset line feature isn't
> > > implemented for LAN8651 driver yet, I like to proceed with the current
> > > version. The LAN8651 handles reset via SPI commands and in rare cases
> > > we still have the possibility to control the reset from userspace.
> > > Btw the pin has a pull resistor in hardware, so it's not floating.
> > > 
> > > [...]
> > Applied, thanks!
> > 
> > [1/4] dt-bindings: phy: ti,tcan104x-can: Fix property constrains
> >        commit: c7f2322431cb6d108b18fb4154606b49e2bc50f7
> thanks, but what about
> 
> [3/4] dt-bindings: phy: ti,tcan104x-can: Document Microchip MCP2542

Not sure why I missed this, I have picked it now

-- 
~Vinod
