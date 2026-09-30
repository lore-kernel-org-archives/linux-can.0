Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDE51CF44;
	Wed, 30 Sep 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790263; cv=none; b=knDrsLNtPgJibLGG4kPy64tFjDn89v+JrVE2mf+2oWRxxs4CqQoyxY1gUnjPTxYiWfe0LMyp8bD2YXM5PbnWoCbZtTpHHQa9C0ucqSKEUR5mDaiBNOaV0T1cpi4fgyCgB/PAA+p+EGA9sNmijx24I4ctGytM/STeDh8ev9A4CGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790263; c=relaxed/simple;
	bh=r8g0Pz6kDEx7WyKSjnUFRLi3Uv58ds8+cyhR3KPsX34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jI4ZTIM1of7eFk1zcwbPmXoiU+/v9oFeLjMtfmO/fV++vtUuxEn1AVs7e93XsADs/Fx4J53Kz9ABRxt1gphrzqfVJTPeboBRa4kO79wHLMFKWWO2J1GL3aLd29i9asgceGyEuVeSNcluKiqSjei5+kU5tf+fq65cJjO5wLdxd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=veOft339; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="veOft339"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 09C511FC00;
	Wed, 30 Sep 2026 19:44:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790790257;
	bh=qfsxJ44J91j2emyBCQAKF4tdn9hHzn0C18LtsrXKcnA=; h=From:To:Subject;
	b=veOft339+be/R8+BPCsciswCSo6rkAYQ3nN0LW3Cs9JFkEs571BIjraUhyd27WeXF
	 ZycFfsQcSronG7eSNBBmQE0rRLAvLGMBMJqxf54bxn5y8JW5A3FSzppAaiv7LwTODG
	 xc2/UonI0PXBTShNRVjagAjc24GEuep0fhhDFKx7w6U7uRMXB9SqvtXE/fM4h98G++
	 H+iJ0zI+onkDMKiiTH4qpSppSp5ULmEhZrO4B2DehzOw3sGjHLyR5ZefFCIrscuHzi
	 NTykvpHeNtiDzZ+6H1GbMY0tWnbMmjvbr2zC1DDJHOUYRKgUkbiBD0m3kf73iagsta
	 LC3pU0NtSx7nw==
Date: Wed, 30 Sep 2026 19:44:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@nabladev.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, linux-arm-kernel@lists.infradead.org,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: imx95: Add support for Data Modul
 i.MX95 eDM SBC
Message-ID: <20260930174413.GA2463938@francesco-nb>
References: <20260928204741.175754-1-marex@nabladev.com>
 <20260928204741.175754-3-marex@nabladev.com>
 <arvPDq8sjjv7na01@SMW015318>
 <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49303872-5622-4e1d-8e1a-01394ec29367@nabladev.com>

On Tue, Sep 29, 2026 at 05:20:27PM +0200, Marek Vasut wrote:
> On 9/29/26 4:45 PM, Frank Li wrote:
> 
> Hello Frank,
> 
> > > +	backlight_lvds: backlight-lvds {
> > > +		compatible = "pwm-backlight";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_panel_backlight_lvds>;
> > > +		brightness-levels = <0 1 10 20 30 40 50 60 70 75 80 90 100>;
> > > +		default-brightness-level = <7>;
> > > +		enable-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
> > > +		pwms = <&tpm3 3 5000000 0>;
> > > +		/* Disabled by default, unless display board plugged in. */
> > > +		status = "disabled";
> > > +	};
> > 
> > The both backlight is not used in this dts, can you remove it and
> > add these when it real use.
> It's the same thing we do on the other boards, so I would prefer to keep
> this consistent:

I agree with Marek, and I would not use the criteria about being used or
not.

Francesco

