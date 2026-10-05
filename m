Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11F303C97;
	Mon,  5 Oct 2026 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221990; cv=none; b=GJ09AbOgSD8Zj2hqMiCXN0jiUjkc0AanZbRWJIWMhOT3mc3ud2ndHDjBS2G8jYy65rA4vNE29pH2XV6SnvxITJAL/IXJtpsiLq0ritc6pZHKTbFx2oeF8h4SNAm/QidwSIuE6jdafuQY89d0/uyULBAtvKRjynnodQML4DhjJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221990; c=relaxed/simple;
	bh=tVogYNVk/7RXiDaB46futlBqlXvruV/vsJHK5dC0+p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7tPOe1RHgv86j3+748GTBlH79c1sV5VRWLfOl7XQOVGFHexnC3jZ/gnN8IdTcxGyf9Payog2axFRzQ9CAZbw9VOBY1c3YO+wFKkg7qTdbQxC0PJwzdnqp4veTnHQUWI12Wh/k5XoXO6GoW6b2LEmd4vCzXmDm8M/RLIzfZDTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvTQ046L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvTQ046L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6B71F000FF;
	Mon,  5 Oct 2026 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221989;
	bh=Ctg/3slngj6Ax0VMHPrJemELmc/4CrkDcseM1aL//0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bvTQ046LixC0uLGHadKW38Yl1kgSpEg4V9I858WYwuiNdFpOo1jUXFeWeIJTRdAr5
	 QN1rKQuVcBJ7ldJogcwyQWEo8ceBnFBfA8WmMpcTYjCDC+Jv6QzcoPTIkU5bcoIKkr
	 P7EYGkEpVA9rVUnFr/RvGrqlDk/zeQWqJTEtsezdkT1Lm5ztw+yWMV1tlrrNfCTEeT
	 BQrZ+JgDsYHSwB6WLrPJWUiCGulMQdC98P8razyZSME08znIeUh/aRlaQVoyHoOCu+
	 RnsTLbcuQyXfPXyA5aoZvv7jRqo3aeele4NBloc0hNt1n2kbq82O8aWziPtZlsEfE+
	 b5thB5K70nALA==
Date: Mon, 5 Oct 2026 12:39:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: can: renesas,rcar-canfd: Restrict resets in
 top-level
Message-ID: <179122198795.1261273.168277489725207765.robh@kernel.org>
References: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001060825.53335-2-krzysztof.kozlowski@oss.qualcomm.com>


On Thu, 01 Oct 2026 08:08:26 +0200, Krzysztof Kozlowski wrote:
> Properties varying per variant of the device should still have the
> broadest constraints set in the top level, so add such for the "resets".
> Since top-level part says "reset-names" cannot accept one item, disallow
> it for the two variants which do not use it in practice.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml   | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

