Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058129BD87;
	Mon, 10 Aug 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366824; cv=none; b=TEXsxovsim7os3SzgxwPK3m2s8YPPK1HMTTCfLvDAynTvj60D1MQ63ExCEehFn4LBxsL8ViKBY7ypc4+92MBTImGdGv5UhALbS/Bakk1/Na+ZV0ulivnO4giwHPQ8BPm3G4OXdvzC6V1OS/ixaG4eCmoP6K5pxHrHtcS4HMxnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366824; c=relaxed/simple;
	bh=x//XS10FMdowHAXy0kEpWaHwABu39r1GjsD2vECfawI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o33Y7UG6k93h23SLp5/TzYRsASkfqkWqUIzNtMHAMuinnGf1PQFAM/12IEt9h2pzFdBjs+6xdxgvP8+qHmhLRRkLq0TwKs/DXUnCqJYBh6SXlozpbD2sCvsDc7IBH2JvfrCRaOLwbGb6LhRh9IS3bs5p2eG6b+/Y9HmOfGwQg8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED2C1F00A3A;
	Mon, 10 Aug 2026 13:00:18 +0000 (UTC)
Message-ID: <7533fcaa-c676-48f4-924e-bba9195d4871@tuxon.dev>
Date: Mon, 10 Aug 2026 16:00:16 +0300
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, mkl@pengutronix.de,
 mailhol@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, bmasney@redhat.com,
 biju.das.jz@bp.renesas.com, fabrizio.castro.jz@renesas.com
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260714173315.1981708-1-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Gentle ping on this series.

Thank you,
Claudiu

On 7/14/26 20:33, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
> fix patch was added on the CAN driver.
> 
> Thank you,
> Claudiu
> 
> Changes in v3:
> - addressed sashiko review comments
> 
> Changes in v2:
> - collected tags
> - addressed sashiko review comments
> 
> Claudiu Beznea (8):
>    clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
>    dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
>    can: rcar_canfd: Fix typos in macro names
>    can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
>    can: rcar_canfd: Do not set registers selecting the CAN mode
>    can: rcar_canfd: Add support for Renesas RZ/G3S
>    arm64: dts: renesas: r9a08g045: Add CAN-FD node
>    arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD
> 
>   .../bindings/net/can/renesas,rcar-canfd.yaml  | 20 +++++-
>   arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 39 +++++++++++
>   .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 ++++
>   arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++
>   drivers/clk/renesas/r9a08g045-cpg.c           |  9 +++
>   drivers/net/can/rcar/rcar_canfd.c             | 65 +++++++++++++++----
>   6 files changed, 178 insertions(+), 13 deletions(-)
> 

