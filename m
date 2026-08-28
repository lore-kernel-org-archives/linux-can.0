Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A23F1048;
	Fri, 28 Aug 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908054; cv=none; b=KHcpww6+OPvy3M+Eo66RyR+QZ5wT+JhuESoI8ImwTzhDQExLJwLpNfGC5UlokrKfiObeGDVrNuWrK0/hDwdb/6X0TA8TKwRdyRZgVRSdp59VGYJKUVhceS0oBES1sucroOSIfWWWizGGTeeHNUa4hk9d5Ri0QpbTP6xq3G+mTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908054; c=relaxed/simple;
	bh=86sz1V3bKxZpfGEL5e4mwUOaBK+GG5lZdCd22DPwfCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewRifEZgrOF+oSqGVv36rSGHt7l71M+U6opfEOka9s8pmVvyTjqVtQ22S0LX5JdQCPIo9zF6Cg00AmjZvgu2gs+BSJRqTDuWLNv9LqKvaqkBouVY4VJ5GgE/dMZBzro9uRK4dmYZjAUIcq6eKg9czqliFYBTKP+gN55DtBDOSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU5n6Ryd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU5n6Ryd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12291F000E9;
	Fri, 28 Aug 2026 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908053;
	bh=lkvdRT0VDXFsl27OQ7S/vcWtfXEbK5/fJY0aWx/dxYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lU5n6RydZGeD1grRZs2xyKOafmZv5KHQ7yvW6fssIyqb81HSrpoa5Jwn1h3nsJRqE
	 ii+1yaGLNykyvawIyLVykFvAbkX13tAPHLcUMn8rOQ+Gl5eguhb5q36a7auDtOw8g9
	 d3yxe9Rq8Q0OEIohHuiulzwvT220uLmaVYMQN/XJuAIIvqHuaR5FvO5GKxoN3NwBTz
	 2cWTC9DNLjktC4Jm12rD4GONL3OQQoyH58m1CEPBcQfspyvvPJhbAxegdSefEGjryp
	 Gu7IUW/OfyY7K9wf3KDlybPsETrBkXNypUSP6QXODSdcMkX+E18AsJEqmHdUVH4PdD
	 WLVnoHh/GA8aA==
Date: Fri, 28 Aug 2026 11:07:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kendall Willis <k-willis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, 
	vishalm@ti.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: can: m_can: add out-band-wakeup
 property
Message-ID: <20260828-antique-lumpy-donkey-51ff42@quoll>
References: <20260821-temp-v3-0-9ac1f8806929@ti.com>
 <20260821-temp-v3-1-9ac1f8806929@ti.com>
 <20260821-regulate-recharger-2e984e9591ef@spud>
 <20260821190511.jwdgox4uocbf4brd@uda0506412>
 <20260824-public-mashing-252473f928c3@spud>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824-public-mashing-252473f928c3@spud>

On Mon, Aug 24, 2026 at 05:50:20PM +0100, Conor Dooley wrote:
> On Fri, Aug 21, 2026 at 02:05:11PM -0500, Kendall Willis wrote:
> > On 17:45-20260821, Conor Dooley wrote:
> > > On Fri, Aug 21, 2026 at 11:07:00AM -0500, Kendall Willis wrote:
> > > > Add the out-band-wakeup property as a possible property. The property
> > > > indicates that the device can wakeup the system even when its power
> > > > domain is off.
> > > > 
> > > > Signed-off-by: Kendall Willis <k-willis@ti.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > index 2c9d37975bedd652b3060ab11ba75c37565edaad..0663beaa532bcc4a71cd6ad01520a4dfea294d0c 100644
> > > > --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> > > > @@ -150,6 +150,8 @@ properties:
> > > >      description:
> > > >        List of phandles to system idle states in which mcan can wakeup the system.
> > > >  
> > > > +  out-band-wakeup: true
> > > 
> > > Where is "-wakeup" defined genericly, or out-band-wakeup defined that
> > > you're getting the property definition from?
> > 
> > I sent a PR to define out-band-wakeup in the wakeup-source.yaml binding
> > in dt-schema repo. I figured it made more sense to be defined in the
> > wakeup-source.yaml binding to allow other drivers the option to use it.
> > 
> > dt-schema PR:
> > https://github.com/devicetree-org/dt-schema/pull/205
> 
> This sounds like something you should be able to determine from
> device specific compatibles for these platforms. Not sure why they are
> not used for this particular device, but this is an indication to me
> that that is a mistake.

Yeah, it looks a bit too much replicating Linux PM detail. I can imagine
that some devices on some board are capable of waking up the system even
when power domain is off, but this does not look like a capability of
the actual device, but power domain. Device does not have different
wakeups. (by device I mean this individual schema - Bosch CAN)

Happy to see some bigger picture through DTS or board layouts. Actually
DTS, showing same Bosch CAN devices which are different on a board -
some are wakeups and some out of band wakeups - would illustrate it
better.

Best regards,
Krzysztof

