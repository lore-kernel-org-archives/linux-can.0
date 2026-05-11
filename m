Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79A3242BE;
	Mon, 11 May 2026 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516266; cv=none; b=B7ortURl07BfiGEBqM1ZmawPKoPcjrmEYIPWKsoOpRCljOWCKy60PcV9LFlBy+07XgtO/8Uo0PrpUzHvyB+w599w9/EdHfge0cdneKp/+V5ZTxIlnloLK/Wr4TMkAC5kBEmt9gdDNOOa571O2aEkN+0nSF5fsv2kHeYc/w6yqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516266; c=relaxed/simple;
	bh=UFuvMK57CtfTjbHAGJyZ/VJ+24ftQifxmTKwtfW1Swg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taTD//GsfY4T9QNhINbCKBSpMQMDVIWR3AGddGsUiif5jXRGBOmo66v9pP/9i5p7Zj3aINoBaOyCMZjqqxSBzsl40GINHmpMzB/+uf5GArJ0pT3fUNVokepmf+aL+9oHhWIiwO6ypRESWkNJn1JH2wwzOipFPYMw/DCaXL84Jb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKjDP0ai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKjDP0ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEE9C2BCFA;
	Mon, 11 May 2026 16:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516266;
	bh=UFuvMK57CtfTjbHAGJyZ/VJ+24ftQifxmTKwtfW1Swg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKjDP0aim5w0VintAabsM53oFP2hCokMq2HPDSN5IbF2h59wV0XQ4WJ9SxwnJPGk5
	 ZvAnYmzl1jEq5OZz+aaMf9aTdp2xHf+uLJERGNYKraDhRZIF+HD+ShOa3Kf3nS9REP
	 G8NeyloTLCqXFbLFMMOfjRFetIz88Sv0UKempSjXdDcM2v6zUto0UsR+LZPwNQIjoE
	 NAKPlg1OukB7t7xAoWNJV4ndnFrTibZkDWwxI9x7MD5Sr3KNujp4Y7s57PtAXlRCjV
	 fKYO+7s78V3QYU8nl8v92FQQ5/AYd29nHs1KgL+nw9ZVr7yq5D7jHE37WiYJP9x7zD
	 70kTanvydI2Tg==
Date: Mon, 11 May 2026 21:47:42 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v3 0/4] phy: phy-can-transceiver: Ad-hoc cleanups and
 refactoring
Message-ID: <agIBJsOl4Trk4_KN@vaman>
References: <20260504070054.29508-1-andriy.shevchenko@linux.intel.com>
 <agBjOmnpKuZoDfWG@vaman>
 <agB_aj_2hzF3ON2h@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agB_aj_2hzF3ON2h@ashevche-desk.local>

On 10-05-26, 15:51, Andy Shevchenko wrote:
> On Sun, May 10, 2026 at 04:21:38PM +0530, Vinod Koul wrote:
> > On 04-05-26, 08:58, Andy Shevchenko wrote:
> > > The driver does two things that need to be addressed:
> > > - includes subject to remove gpio.h
> > > - checks for error code from device property APIs when it can be done in
> > >   a robust way
> > > 
> > > This series addresses the above and adds a couple of additional refactoring.
> > 
> > Sashiko flagged some issues, some of them not introduced by this, can
> > you please check this:
> > 
> > https://sashiko.dev/#/patchset/20260504070054.29508-1-andriy.shevchenko%40linux.intel.com
> 
> "Could this result in a null pointer dereference if device_get_match_data()
> returns null?"
> Yes, it sounds legit but not introduced here.
> 
> "In the original code, the warning was suppressed when the property was missing
> because err evaluated to -EINVAL. Now, if the property is absent, max_bitrate
> is explicitly set to 0 in the else block, which then unconditionally triggers
> this warning."
> True, but I don't know which is better here, I consider that it's
> good to inform user about default being used as a fallback. I can change
> this back to the original logic. What do you prefer?
> 
> The third one is the repetition of the first one (see above).
> 
> TL;DR: The only one legitimated question is about a (new old) warning.

Yeah would be great if we could fix these as well please

-- 
~Vinod
