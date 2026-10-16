Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485724A92D0;
	Fri, 16 Oct 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156195; cv=none; b=A8hSIxA4CN5ppKSW7Zyz/rIdgduCRuqBMFD2kKOwj0NsKEUNgwAIiAvJPUuko86asZgrdugS+EcM6ol9tpHEfEfFoFAoo6lrirKzDwMiypvKmTtfAtMdCWp34S9weD2oKuJ2LNiW3pLBw7otnL4agNArUwSKeML0yRGr/PMY/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156195; c=relaxed/simple;
	bh=JXL7Bs6q4E3tW/QjIVi42cXpS7D9h7gFUF/Tt1hCfuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHu3Q/QwLh1y6o4mEPITnCx3pFknDWk7/atXS98dvEjwcugBQ2QzEaM01rRhqATQoFV7F+hUCEfNSqHqbmpYycZd3x1BMzTqx09kE7x+VTtVX5TSwyE/Y/+nEsM9r9fV0GBJ1wRYaWX+zNDC8Ip3YUun6KxcPLig700V9irIMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMeVNG6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMeVNG6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F41F000C4;
	Fri, 16 Oct 2026 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156192;
	bh=oV7RE7gBy1YR8d4bae7LhBJpg2oaoF1LnwBKnDrZvWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IMeVNG6WEydmXm8gp1RyqVWE2bsVZbe5i2v1iqyKjwU1rYfDPbAMdK3fNrL/EoQjM
	 72tmAyztVJXlzqZ53v+vGAON064sCmZPQp6XHbpTzDlgZGwcb5lU6d0+tX/BDE574A
	 +P27HEemzmBOZ5uzz3nJRx+c61g7CC5+gCadlkgrrJhytnGEhileoJQPPbof4kFj5g
	 lpcg7GCvUVO7AKe8pzdc4I9P7Sp0nYWCeXOTx3T7j44Lm96u98erkhWJNMjfzMCC1R
	 89p2riK9j+WcY+mqP2wdSnYcO3Euko4E3uFmA2toLLRtDqv8kMgqSTDnREOYPm498j
	 L2NBeBHlSvWdA==
Date: Fri, 16 Oct 2026 08:09:50 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: net: can: holt,hi311x: Convert to DT
 schema
Message-ID: <20261016130950.GF5059-robh@kernel.org>
References: <179008111842.3145564.13410709686921168865.robh@kernel.org>
 <20260923013812.256689-1-quchaosheng000406@163.com>
 <179209645876.1181445.17999194781071685440.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179209645876.1181445.17999194781071685440.b4-reply@b4>

On Thu, Oct 15, 2026 at 10:34:18PM +0200, Marc Kleine-Budde wrote:
> Hello Rob,
> 
> Quchaosheng says the error that your bot finds comes from the latest
> dt-schema git.
> 
> On 2026-09-23 09:38:12+08:00, Quchaosheng wrote:
> > Reproduced. The errors come from a dt-schema change in git, not from the
> > patch.
> >
> > They are all in reserved-memory and the IPs that embed it:
> [...]
> > That commit is not in a release yet. Confirmed on the same tree with no
> > patches applied:
> >
> >   dt-schema 2026.6 (PyPI)  -> clean
> >   dt-schema 2026.9 (tag)   -> clean
> >   dt-schema git 840a01d    -> reproduces the errors above
> 
> Can you re-trigger the bot or should Quchaosheng re-spin
> the series?

You can ignore those errors. The main branch is now fixed.

Rob
