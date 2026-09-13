Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC533176EE;
	Sun, 13 Sep 2026 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789286081; cv=none; b=gfGyiRkh9M9YlYeAdWlTc7EfFOu8fQSqfzWUBlBTB1a4GAl3W+cQC3/yQn764FsyZ46gsMsi1sRST3jRU/gFGjo7olsqL/AC2Q5jsV/+0WUZPjBcpL/iiUZaUPjGYjc9LHDTJiR6mKWBY4EGxL0yg8BHanHd4e+9G8uCbMwvrAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789286081; c=relaxed/simple;
	bh=FvKWKtMXNN2ocZifIUXCkIe8hmUzO1nGxVB/Hc9xzaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP06iJiGZEOhU1XDlbmYpWyERhN8Y+BgiKW90x+B71em7hzacRGHC/GtwiwzUvZzt/djqXKRKEXjAj4XAcXhEoESjsyoZRuyustZvkNbiA/MAW9dJT5VTgSAjZZxKBqLao3GQWd4BMpUbgZ9Lzz7It45uaNJI3u/S/FgbaxT9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmI+7y3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmI+7y3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AE61F000FF;
	Sun, 13 Sep 2026 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789286069;
	bh=3gPYzscr6PY1tKGOo8MOmKv2rjqzGwQxJJrk9mxvNMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nmI+7y3xQ2zFNM/diqsyran6e4Ki8q1cl4tGFSIX+w4nSWyvXzMhZJKyo37BOS24K
	 zSk2OEGPwn9j3W4WzMlIS4yR16EJKeA/HKAGVMqlmcxqS6WVR7P8UhZEIwMqe959Pr
	 kLow/euUAi+0keusVP+LUAV89LgTof694TeWtyooiflFalBVBxr/D8WJL3If9vgDly
	 GcjgPIVAe9tiAXoHSX8Yh6tN5tA5d2PafUedjN0ualeP4kEz8+g/amkao0GMYxHbtD
	 RpguoPb3O3YMQXJ28sIGb4ZUE4uayznzOS11tX1nCbuQTY89EjusEg1/TqaQqXuh12
	 911CNewGDleAw==
Date: Sun, 13 Sep 2026 09:54:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: can: m_can: add ti,am62-mcan
 compatible
Message-ID: <20260913-impartial-mongrel-of-speed-662ea0@quoll>
References: <20260912-temp-v5-0-2e3201c02109@ti.com>
 <20260912-temp-v5-1-2e3201c02109@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912-temp-v5-1-2e3201c02109@ti.com>

On Sat, Sep 12, 2026 at 04:26:55PM -0500, Kendall Willis wrote:
> Add "ti,am62-mcan" device. Device is fully compatible with Bosch.
> The device supports out-of-band wakeup capability.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Fails checks.

Best regards,
Krzysztof

