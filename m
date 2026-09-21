Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482448FF7E;
	Mon, 21 Sep 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012315; cv=none; b=llnvB1DLgTETtudMrCa5gOPRyOM8CxfchJaW+Qw2sPhd+Z2Vq5rZ7dyLAqAv0DVFg9crYrdEVT3pigdVCUpCb46ICyc3wyatmA6d0LdSIhjDjj84E1JObURkc9EYaN7A5MlrDOfxMWxzMlbypOeWGwrgUvWffvS7ezrbL+G2Ybk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012315; c=relaxed/simple;
	bh=IySCv8FNBhdOq3rPgljaqt8nFCooylag2fFysI3+EGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qprwo1vxxrWu+28Y0YJPsD8egick1SllL+geRc7955UKnhHmrGRqHffIVg1W/PfhueB70AQuCpaeh0ZI8PS88V8A7QM3IakIuA87J50D+ctns0yh+z6YCY/tzHeYSWgIbq3buN27w7QaQmQRn4lScNVIoj+CMG17tp7dVI38eZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO4D666f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO4D666f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF73F1F000FF;
	Mon, 21 Sep 2026 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012313;
	bh=F28n3X+qca4JrDLiuVM73CGhNN8xIYPEeL/zCANYwSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aO4D666fxcMuO7Wf8OpLl/035aacnUTwyL2p2H6CEEoh3JzKbHi+RqXol1LikJ8ML
	 svRZaMjO2AWRQqK5MCsTeoD3vyURrIytvvXKbQgymw3p/KVK6Z2mhmYNqPxR7Y49zf
	 L38wUWbkQpmjxrJewU/Erfe3UPOx/u2uybJa9J94L72ObIpF8R8y+NY2b/RaF8AIjb
	 N77Wt0UKx8bzOkil9P2LSCJVd3vEP1OWi8qHiNnGMsV4449ZeYCRtXNcJuQw0X5+fF
	 nkEQD4jFUPmWczlXTjkAY4e1I0kxVMFMnIPcdtmY6NWLEJLq4uRhHOYZBY3TqI86be
	 GoMI0c4SVueAw==
Date: Mon, 21 Sep 2026 12:38:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6] dt-bindings: net: can: holt,hi311x: Convert to DT
 schema
Message-ID: <179001231152.1040111.15461000721283698523.robh@kernel.org>
References: <20260914090440.552884-1-quchaosheng000406@163.com>
 <20260916015801.112299-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916015801.112299-1-quchaosheng000406@163.com>


On Wed, 16 Sep 2026 09:58:01 +0800, Quchaosheng wrote:
> Convert the Holt HI-311X binding from free-form text to DT schema.
> 
> Keep the example and the properties as the original text describes them,
> including clocks as a required property.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v2:
>  - Keep clocks required and drop the clock-frequency property.
>  - Drop the variant-specific handling that v2 introduced. It documented
>    properties the binding never had.
> 
> v3:
>  - Rewrite the commit message in imperative mood.
> 
> v6:
>  - No content change. Fix the patch format: the changelog was placed in the
>    commit message instead of after the '---' separator, which confused
>    Patchwork. Move it back where it belongs.
> 
>  - Drop an incorrect statement from the v2 changelog: clock-frequency was
>    described there as an ACPI-only property of the driver. That is wrong,
>    the driver has no ACPI support at all (no acpi_device_id, no ACPI
>    headers); device_property_read_u32() reads it from device tree too.
>    The property is simply not part of this DT binding, which is why it is
>    not documented. Keeping clocks required matches the sibling
>    microchip,mcp2510.yaml, whose driver also uses devm_clk_get_optional().
>  .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
>  .../bindings/net/can/holt_hi311x.txt          | 23 -------
>  2 files changed, 67 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

