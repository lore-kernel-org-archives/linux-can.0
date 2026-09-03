Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AF44AF9E1;
	Thu,  3 Sep 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443158; cv=none; b=rP7y1ADiP4AxlxLEGfAP+rjO6cyDDyFEvtdNnaMCaeGMppJRap6Sn5HLHUmgJyxRA/rYhazbtdowtkHk/ZGtQjviGlCgHoCWOIc5kmLyhvQk/vL3HP/yDHI6GKYiWeVre0Y19RPx+qP4F5xB8pQ2hP052VQC0FRVCq0kQY3vxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443158; c=relaxed/simple;
	bh=xA7Wy3cYmyCLSI7uts2FMPHnc8jUdXEwX/JKLpnIsSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQLKesgLFiyM8va0vRJ26n/HnR/m0jBvqzu4NBpu2F+yhCN4Pa2rFF4H/wLoCUWV1c4+cjplJrsc/enfT4YzdroqeK0UcqS6dynPoxzzTPlZaFDBfDtqGa/xWG2KxtMfq4AOJKNmmaeTmK91Y1gFWGQ+1O8wgW0+7JEapJxLHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDXnSKhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDXnSKhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829A11F00A3F;
	Thu,  3 Sep 2026 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788443142;
	bh=hKklMbCIHs8enMPW2Fak9SuLxH/SOGAV+MHSV5r3BGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDXnSKhBrCB1JLSBcvXjLBOrqEyA7vkb7ji+vPenLvn9HRFQdO9iiJrdkR1jfASu+
	 VB5NWw9v4vdDJx4kq3xqF+4S8gaWvS+Nooui+AdjMRSmmWJTC7PF1+3yG/oP6prEpL
	 z2eGZ7Hkj9pc3ug3qKOeNUYYwo/W3gK9LIH/zjcLacoMfoKv/N3XDHfNmunKDXoFI2
	 zI5+XhGtjz10rDgHGSEcPeaD1LDCWI6JMCwoQIveoD3NN2sSxho82qK9705BWig4rk
	 1lHIXN/SFcfxkTNj5r4j3ffbqEBAzv/c+3xSBWu21NBSUAISii8AuYIwBmdEP9PmTT
	 cup5ruqLHKRFg==
Date: Thu, 3 Sep 2026 15:45:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com, 
	linux-can@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: can: m_can: add ti,am62-m_can
 compatible
Message-ID: <20260903-swinging-carmine-oriole-75b35a@quoll>
References: <20260902-temp-v4-0-3896f7d16ce8@ti.com>
 <20260902-temp-v4-1-3896f7d16ce8@ti.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902-temp-v4-1-3896f7d16ce8@ti.com>

On Wed, Sep 02, 2026 at 04:03:27PM -0500, Kendall Willis wrote:
> Add "ti,am62-m_can" to the list of compatible strings for the M_CAN

Compatibles do not have underscores. Poor existing examples are not the
example to follow.

Also, no need to repeat the diff - we see that from the diff. Just say
"Add foo bar, a baz-baz device, fully compatible or not compatible with
Bosch because of this and that".


> controller binding. This compatible identifies TI AM62 SoCs which
> support out-of-band wakeup capability.
> 

Best regards,
Krzysztof

