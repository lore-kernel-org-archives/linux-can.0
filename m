Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299C3ACEEA;
	Mon, 14 Sep 2026 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370643; cv=none; b=MwNIde3RPi5TPCPsqDmwjGD1JLLNFAEAKjgSQ/xErYgyyyRVYX7BdrNlxdM9OOxG/lCgErs2vpLy9FLnykcEy9pmY/ljFJu4cqEISvI7kbNRuJg1LRI4LXXKrIgrEDNQtjV1mILfWTRjimQKDcnm52TABgMQz0PaunqBosbq3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370643; c=relaxed/simple;
	bh=g+38FgOC9ZNKh6fCvn7Jb2t1Ja9Frdbw3eNYbL4oaoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nm1gBHgBXzDJA+07XHVsVsrhYbwTIGekSwTb2RWO+0Zsiyo17AMMnbDXaoi8npfATgtD3Xr/u0U+qxXogzHHxTggpWObImPdDpBs4xlqiER3Kz/F6mj4xy1v7bdBT9zt46kRPQdLHu77CUWnMs3u1w69d+xFfSFqzZJykNUT+1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3gysuNk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3gysuNk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AD01F000FF;
	Mon, 14 Sep 2026 07:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789370641;
	bh=pZcpAcr+/zzbC+AJSoK5adn1YRsesqqRQr6hReF8Wug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H3gysuNk8zdh7URFf7FLGlilz9hCA4zjYeK5IzjcfURn2IrXKQtKPpJz4Fhky0yXd
	 WpoSEdb0Exip+c22bwx7Usf6yratEwco1cclfU5O39eBSRyUVsaYDFOQWz0h6HDJJX
	 K/gwyEkYWguB/zyrv8OPVZo/PQ1nlpfAN7hd/LGW6B1lj1zoqi3WtRRFR25+HS2sSQ
	 n+SsCP1KOltDH+jnJjW9hweUPa9xfKWt4U3zk9rpqMFKuUVYzxC1mVPWErYkF+CiJF
	 72w+yuoxtmArigyL0mz1Jrqq2Th6eBwyvM4kadoLRRIt5lnPaXbMFMm9uue0nZznfe
	 sLgL5kaqQPFtw==
Message-ID: <63126241-b217-46c6-8ec3-071283e86d69@kernel.org>
Date: Mon, 14 Sep 2026 09:23:55 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: can: holt,hi3110: Convert to DT
 schema
To: Quchaosheng <quchaosheng000406@163.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org
References: <20260914055608.495084-1-quchaosheng000406@163.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260914055608.495084-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/09/2026 07:56, Quchaosheng wrote:
> Convert the Holt HI-311X stand-alone CAN controller binding from
> free-form text to DT schema, and reference the common can-controller.yaml
> schema.
> 

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830


> The controller is connected over SPI, so reference
> spi-peripheral-props.yaml as well, otherwise the standard SPI properties
> such as spi-max-frequency would be rejected by unevaluatedProperties.

Redundant, drop.

> 
> The old text listed clocks as required, but the driver obtains the clock
> with devm_clk_get_optional() and falls back to the "clock-frequency"

No, read the git log history. It's only for ACPI. You cannot add ABI
post factum on the basis of "but someone added it to the driver code".

> property when no clock is provided, so either one of the two must be
> present and neither is required on its own. This is expressed with an
> anyOf block, and clock-frequency is documented, as it was previously
> undocumented. The maximum supported clock frequency of 40000000 is
> enforced, as that is the limit the driver applies.
> 
> unevaluatedProperties is used rather than additionalProperties so that
> properties provided by can-controller.yaml remain usable.

All this is redundant. You just paste here LLM explanations, so let me
stop you right here - do not ever paste us LLM text. It's pointless.

Explain the changes done to the binding ONLY.

> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v2:
>  - Reference spi-peripheral-props.yaml. Without it, unevaluatedProperties
>    rejected the standard SPI properties, spi-max-frequency among them.
>    Reported by Sashiko.
> 
>  - Add a maximum of 40000000 to clock-frequency. The description stated
>    the limit but did not enforce it. Reported by Sashiko.
> ---
>  .../bindings/net/can/holt,hi311x.yaml         | 81 +++++++++++++++++++
>  .../bindings/net/can/holt_hi311x.txt          | 23 ------
>  2 files changed, 81 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
> new file mode 100644
> index 000000000..36497b114
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/holt,hi311x.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/holt,hi311x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Holt HI-311X stand-alone CAN controller
> +
> +maintainers:
> +  - Marc Kleine-Budde <mkl@pengutronix.de>
> +
> +description:
> +  The Holt HI-3110 is a stand-alone CAN controller with an SPI interface.
> +
> +allOf:
> +  - $ref: can-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: holt,hi3110
> +
> +  reg:
> +    description: SPI chip select.
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      The clock feeding the CAN controller. If this property is not present
> +      clock-frequency must be specified instead.
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description:
> +      Frequency of the clock feeding the CAN controller, in Hz. Used when
> +      no clocks property is provided.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 40000000

No

> +
> +  interrupts:
> +    description: IRQ line for the CAN controller.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that powers the CAN controller.
> +
> +  xceiver-supply:
> +    description: Regulator that powers the CAN transceiver.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +anyOf:
> +  - required:
> +      - clocks
> +  - required:
> +      - clock-frequency

No


Best regards,
Krzysztof
