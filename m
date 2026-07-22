Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CA296BCD;
	Wed, 22 Jul 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740333; cv=none; b=PEvu/4Awih4QLAZK9ATWZapTvGVoPJKVO2qx75lxGez8tphp/lzHmDBvgEBrCypG6Q6PFWah0c1cjVMHET3T3lV5vFVzMsTyHGU8etm64dgSzOuvzkxymHvSWinBJwHprpexnuzhPFSBaak1xvYue4ygLIQXC8dDT9+uQN/sl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740333; c=relaxed/simple;
	bh=pOw0Sd4aBstlJHr1VKDj8Bt76erT2FtxOFbS4NCugME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tos8t9AtjvLmsduj29VA0zGrHlvBbJ+MCSl2rwXZA+lXc9JrLT0UogJjCjOZpNu8s8W6fNvwk+BGM7Cnq0l76ThFZoNFS7omXMPUdqtmFmRBkVMgx0f73IPxUlNTcnhOH/VxZGdiQoFTN4504wwT9VU8gkfd/Hofo9f+fU+uzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZf1kXQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZf1kXQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E09B1F000E9;
	Wed, 22 Jul 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740326;
	bh=7mD+4FUWhob78Mb44V3gtlplEwc4ek5DfjC69DadIpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZf1kXQo4xHv80f0Pz5JipUico6acxDE74mN4GdiEczhr/dx65ciuaVg4r8bAEEcs
	 g8p3n8IX94S/0xWbA4zB89DDMhTKQTnkV2L/Z3NU/JS3ruAdusq+9L4HeuSfEStQcH
	 Y7DVFEogTtuW8IovLFTWOIYoBVbSG6mj923ABW1pZrGmQa6vxfSdKOhKADlVOdVYhn
	 WYIBqfh0w3VNaXxKQy1Fux3hXJ2kSLGBQPtlGX8G5YZmlkGeL9Qb20Z1soM/qQ5FLB
	 8kVpxX5d027Yr+2QZ7RI9pYf/OwQ7BcgCUQK2cQUvNhPuOKeGp66LjZg4d3bkfTHjE
	 NEmeE6vRcIPsQ==
Date: Wed, 22 Jul 2026 12:12:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: biju.das.jz@bp.renesas.com, linux-can@vger.kernel.org,
	mturquette@baylibre.com, claudiu.beznea@tuxon.dev,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	fabrizio.castro.jz@renesas.com, linux-kernel@vger.kernel.org,
	magnus.damm@gmail.com, bmasney@redhat.com, mailhol@kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	mkl@pengutronix.de, geert+renesas@glider.be, krzk+dt@kernel.org,
	sboyd@kernel.org
Subject: Re: [PATCH v3 2/8] dt-bindings: can: renesas,rcar-canfd: Document
 RZ/G3S SoC
Message-ID: <178474032283.1138528.11209003528871074463.robh@kernel.org>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
 <20260714173315.1981708-3-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714173315.1981708-3-claudiu.beznea+renesas@tuxon.dev>


On Tue, 14 Jul 2026 20:33:09 +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The CAN FD controller found on the Renesas RZ/G3S SoC is largely compatible
> with the variant present on the RZ/G3E SoC. The main differences are:
> - the RZ/G3S provides only two CAN FD channels
> - the RZ/G3S supports only CAN FD operation; the Channel n CAN FD
>   Configuration Register does not implement the bits used to select
>   classical CAN-only mode (bit 30) or CAN FD-only mode (bit 28);
>   consequently, bit 31 (CAN FD Frame Distinction Enable) of the same
>   register is also not implemented
> - some bits in several registers (mainly reserved or status bits) are
>   read-write on the RZ/G3S but read-only on the RZ/G3E; their behavior is
>   otherwise identical: the bits read back as 0 on both SoCs and software
>   is allowed to write only 0 to them on the RZ/G3S
> - the RZ/G3S provides 256 acceptance filters, compared to 768 on the
>   RZ/G3E
> - the RZ/G3S can use PCLK clock as the CAN FD clock source through an
>   internal clock divider, while also supporting an external CAN FD clock
>   source
> 
> Since:
> - the SoC clock generator provides to the CAN IP only the peripheral and
>   the RAM clocks
> - when sourced from the peripheral clock, the CAN-FD clock is obtained
>   inside the IP itself by dividing the peripheral clock
> - the assigned-clocks and assigned-clock-rates properties are specific to
>   the CAN-FD clock
> the assigned-clocks and assigned-clock-rates properties were dropped from
> the required properties list of the Renesas RZ/G3S SoC.
> 
> Add documentation for the Renesas RZ/G3S SoC.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:
> - updated the patch description to reflect RZ/G3S has 256 acceptance
>   filters and RZ/G3E has 768 acceptance filters
> - kept compatibles alphanumerically sorted
> 
> Changes in v2:
> - forbid renesas,no-can-fd and renesas,fd-only since the IP supports
>   only CAN-FD; for this didn't collect Biju's tag
> 
>  .../bindings/net/can/renesas,rcar-canfd.yaml  | 20 +++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

