Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D874EDCB8;
	Mon, 21 Sep 2026 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012405; cv=none; b=UyQcxPWKG43NZh8cuFn7IpefgbSlBgAQKYKlAeI5h0RNvgs5X8I97yPYqo9m82/LH3rMThOorz4LltTdHdMnaELMVLFmjhNC6JQpF7cOOVmB+obytC758pGjdNnrCK6DN8W4WHUZAqBfPhAiY8QmRygLClAHLsinXIu0gIAHjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012405; c=relaxed/simple;
	bh=wEdb2onoGd+0N3YRvy84piZxdofOc/X+2IBdDlNIHQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfeHMcbrlKnpfxBW7yCvD5cmXsh29hBX2a+VES+MwzMf1nhc9VX3oJPvsk/J+FZ/ukmKUv90mtQmMbN7LiebXJMq8YFJ1VIZUHMeYuDgDNuFn73ezXIPAent3jF0smYFDWLuw1jQwPRPZPUP57k9q08FM5ebdQLiaXZ2U9cSvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihE1IqtX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihE1IqtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976A31F000FF;
	Mon, 21 Sep 2026 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012403;
	bh=Gz8Aa5aaLqPaIk+EG6zeB6qbVwKWKtCmjjrWvq6RsMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ihE1IqtXFvFzHYoEISBQL26c3Xlq1k8cg2/jRjui10maX9lL++zNeY+tj9eawSbKb
	 YIzfVd1Jh1fzBA6N/jQLWiCRXjbsxv13G97uE3D7qshxORL8kvpL4Vv8FKj4BPZeT9
	 NBK2wr/sUBgPnQj15e06nBYwbi9PwyIhvS6S+zLwNiPDOuRa2wvyBEBVBlza0ueMsA
	 fdy9CHza/hCxZw28Q5jGrn40vr25lakyWjaYC3CJaSa5mdm6vAtdOTSfyj92AX2Ddf
	 3uwAtSmp3dDnAPc0tsJ/URQSvdQZ9MBP0uBfiaSXmJSbFOu+WPk3CFXWE1nUg0z2zE
	 LMhN/hgP2wKEw==
Date: Mon, 21 Sep 2026 12:40:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v6] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT
 schema
Message-ID: <179001240193.1044469.15908523529395448607.robh@kernel.org>
References: <20260914030116.437424-1-quchaosheng000406@163.com>
 <20260916015805.112354-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916015805.112354-1-quchaosheng000406@163.com>


On Wed, 16 Sep 2026 09:58:05 +0800, Quchaosheng wrote:
> Convert the IFI CAN-FD controller binding from free-form text to DT
> schema, and reference the common can-controller.yaml schema.
> 
> The driver matches on the "ifi,canfd-1.0" compatible and obtains its
> interrupt through platform_get_irq(), so interrupts is required.
> 
> The example uses the GIC and irq header defines instead of the raw
> numbers from the original text, which keeps the values unchanged
> (GIC_SPI is 0, IRQ_TYPE_NONE is 0 and 1 is IRQ_TYPE_EDGE_RISING). The
> node name is changed from "canfd" to "can" so that it matches the
> $nodename pattern required by can-controller.yaml.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v2:
>  - Correct the description: this is a soft IP block typically synthesised
>    into an FPGA or CPLD, not a controller found on Renesas SoCs.
>    Wording now follows the driver's Kconfig entry.
> 
> v3:
>  - Use unevaluatedProperties: false instead of additionalProperties: false.
>    As can-controller.yaml is referenced through allOf, additionalProperties
>    would have rejected properties defined by that common schema, such as
>    termination-gpios and termination-ohms.
> 
> v4:
>  - Use defines instead of raw numbers in the example, and rename the
>    example node from canfd to can. No functional change.
> 
> v5:
>  - Re-send the patch on its own. The v4 posting accidentally included
>    unrelated changes to the xilinx-xadc binding and did not remove
>    ifi_canfd.txt. Only the intended change is present now.
> 
> v6:
>  - No content change. Fix the patch format: the changelog was placed in the
>    commit message instead of after the '---' separator, which confused
>    Patchwork. Move it back where it belongs.
>  .../bindings/net/can/ifi,canfd.yaml           | 46 +++++++++++++++++++
>  .../devicetree/bindings/net/can/ifi_canfd.txt | 15 ------
>  2 files changed, 46 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/ifi,canfd.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/ifi_canfd.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

