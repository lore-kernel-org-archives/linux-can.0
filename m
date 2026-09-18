Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD11E9B37;
	Fri, 18 Sep 2026 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729324; cv=none; b=ZDbuUw4m/iHiVTLZLsj2W/gAOdciZ9h3HY1RI15cr/dxSuSEsVA3SOxmSarB73oVzaCvRCxo58elvVpVTFZWCzE7U3H3bY+mmziGwYlU2dqryRGRxqzWijKHmFC+kOXnQp6MFznCz2SI10rSR6xMyuc880pQVaUxAhmQwBVNJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729324; c=relaxed/simple;
	bh=fXTETNf9RH+TOwg6XwssJNK+GwR2YJRd0OS0XZ3stws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEAs55Ivurij1xfFXkymjp/CPYEwqC/BU2GlftIQclKTngET3HHcKAqgh8buJ0rCkUeFK3A9rJ6Jqm2Zwr3zeAmH0L+1DcTWA4/I0iqaLfHurFs3hWUjr0++Cp0U6gN2DmsKnP2EqzflAm6xRyIZUy+wrxhWe+PdULp4nDMufj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAzketc2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAzketc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420A11F0089A;
	Fri, 18 Sep 2026 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729320;
	bh=HP7UjX+DtpEUbmWbHviNN3/DeHT2bG/mTGPvkZbqFx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UAzketc2xQ5aypvUHuxBFcw3BN5vF0aJJd5JnQjMNIMd4GzmIVkm6GHeyAHdqq/H2
	 sl0PNZHiUu0MR9QYkq3nf5EO18txsXgTNR9CzM9NVgiy9y+QKY87SSByHbHM975dqg
	 rwhdSKQ3IOu829Av9Bc2Q7FUdiUk3SzL3CoT6d/XwJJD6smcz5hCYvWQhBR9RmRpEj
	 qWEP1nw0bQEAl6thZiHg3OYV+goAbLTj31/aVVq+r38zEHt2v8GPluad2YFhJA9l1/
	 QSCk9ZYxK0WJKXIEsfKMGk8IcXT8e6BYEuiRYRRDLMzw8vsA/KydSi3K8np8JhRBYu
	 r8G10EPQ6Mc8Q==
Date: Fri, 18 Sep 2026 13:01:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-arm-kernel@lists.infradead.org, 
	Aswath Govindraju <a-govindraju@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: fsl: Document Data Modul i.MX95
 eDM SBC
Message-ID: <20260918-hidden-phoenix-of-speed-daa5a7@quoll>
References: <20260917062543.534416-1-marex@nabladev.com>
 <20260917062543.534416-2-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917062543.534416-2-marex@nabladev.com>

On Thu, Sep 17, 2026 at 08:25:27AM +0200, Marek Vasut wrote:
> Document Data Modul i.MX95 eDM SBC board. This is an evaluation
> board for various custom display units. Currently supported are
> serial console, ethernet, eMMC, SD, SPI NOR, USB host and PCIe.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

