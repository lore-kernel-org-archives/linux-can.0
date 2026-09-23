Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA732EEE75;
	Wed, 23 Sep 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167530; cv=none; b=cAJbKwI8Plbx42mTu97tDgubfpXnsfwqAS0cHj1l8XhrtYulcYiGkkDxrEeog/5EyoixqTpypLNLq5q/Ah4lhoRFMfrzpWqihG8SlpOsT0kN6pQdscBLf5ZVAsG5bl9yiQmiLVLI9O6vjOFhkyjPdPwnQF1FBwOvJ2f0ZiiPLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167530; c=relaxed/simple;
	bh=2xYqGn83p9qDa8rjkaGXNiskpOimnDMl27ZssfNfI1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUCMfJjNaS/0eAZnueCehtFpi4qdZeDoXYhhvfkt+GkYa9sID8EpOuUHUIeVj51wO+nCU4YnyPI39v5R/uIU2Tf7QjoSqWt5RtnncbEo1a62lrEN2I0exKECZfnjN9TFRC5saQP+1jxBfMsMAHl9aLJV8rNzstHVwpfJuH5GOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8NAhJ7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8NAhJ7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C161F000FF;
	Wed, 23 Sep 2026 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167529;
	bh=EmefoQc4jPjF+J0TGd7A2/RbBqOLDCX0rbqb1Fx0Osg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U8NAhJ7wizrCzNw6S0+XjZ1LdYSxSz93GWHotpuZo7QUlcz6vhwmTjfSEiG5Uqeqn
	 zFaQALfsTmT5mf4AwYG5kgzRKHOsWc23QV/Ro9KjCsUN/dN4YNr8j5l457yvNOf9li
	 qpEI7Ocq9DL7NisThDaoRbYRVhYmYVimGeaG/vxCBQQuL+gERUmRZ6ur5+Xw/CX4Td
	 9plBepGYn8qKYsIhKwJGZuAJBLceN7NcrjbiSxl9EoKRow/ojrlyzZTY0n4MuS1cmU
	 lJ9UXUcwVAvCr+zBR82RGBkfQVVqH86sJX/TdkuLyWIsPvc8lc6oQWVHcE2OaeYwvi
	 CjKXwYJHikDVA==
Date: Wed, 23 Sep 2026 18:15:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Frank Li <Frank.Li@nxp.com>,
	Christoph Stoidner <c.stoidner@phytec.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
Message-ID: <arPJ5TUZEeb2SAV3@parshuram>
References: <20260907150420.18787-1-wahrenst@gmx.net>
 <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net>
 <arFDUby0v52HSNnU@SMW015318>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arFDUby0v52HSNnU@SMW015318>

On 21-09-26, 09:46, Frank Li wrote:
> On Mon, Sep 21, 2026 at 03:09:23PM +0200, Stefan Wahren wrote:
> > Hi Frank,
> >
> > Am 07.09.26 um 17:04 schrieb Stefan Wahren:
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
> > > sashiko complained in the fourth version of the series [2] about the
> > > reset polarity of ethphy2 and the different drive strength across the
> > > data lines. Both is intended.
> > >
> > > [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000E9@smtp.kernel.org/
> > > [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000E9@smtp.kernel.org/
> > >
> > > Changes in V5:
> > > - fix delete-node for pinctrl_leds (reported by sashiko)
> > > - add Krzysztof's Reviewed-by
> > I didn't received any feedback for V5 yet. Do you have any comments or could
> > it be merged?
> 
> Wait for vinod pick phy binding part.

Done now

-- 
~Vinod
