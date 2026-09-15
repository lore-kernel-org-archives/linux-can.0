Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2B340281;
	Tue, 15 Sep 2026 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469843; cv=none; b=WcPSUomL4zveqCJR6QPzqOoW8qvSdtBvpqqpvyChruv9uaHN8OhCzVL38UKWOu5DRtKt7mNEp684dlys3ttUhuvck7hiBQqMu5l6rROwAnKaFfLh2RZX3+R4GB60iWB5ejINr4uQrNUMMp56vqdB2r4Un5WdkzpFl3Oga2qJo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469843; c=relaxed/simple;
	bh=jjcCtZSr49eBUEwrc8c4xNidZjdjTUez9DXiXPHISFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leaQg5JBGn6PNcWhxeJ98TpLq7ESH6nhI32LlxRG3P/1YSn6Lzy3s6b+aWLZ0ry0sKSfj1g3q/FFnkexSI6e04z/KlxM/SCjWr26v7ITwSv3hm2FPqhPW5ZQQNbNovrCpgtF64az6PpIe8uX+3AiJREFYPlzSG4L6nkbweUVLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNPi10ut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNPi10ut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64271F000FF;
	Tue, 15 Sep 2026 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789469842;
	bh=yLtYDPRPCgy/hdfO4t1Hv6piT3zNknalnjJ6vmaE9bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RNPi10ut1xVgiT/EBxMlQdfOK+jpX7FuX9G/j/gk2DEZVC8uRhJAFEnBEA3hetWMb
	 JoBDxwfq7NYlJOjd5pNGCcY+G2DTRNMBCZkyg/yI8mKkadCx9azST1lFOya+L3ND89
	 FXr46ewBilAYEQTCVx/U+dv/UvJxcxXwXog/Fp/F40OCBm6V20fxM7BZ5nPxu9BK5y
	 awXTyJhKoR+8VqGpLcHNWB4V41PcWqgflXvoudYdL/EAkQwYenZoaseMzbSLvZ+w39
	 3HFdRZYYyoxeHSBZpumnyxSMpAtQ5Bx1SB7aQWPUx3GRDWdCgFFLR6bk1VEvEtUG09
	 qxUQrEuZquPRg==
Date: Tue, 15 Sep 2026 12:57:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: net: can: holt,hi311x: Convert to DT
 schema
Message-ID: <20260915-powerful-jackrabbit-of-courtesy-cf5ddc@quoll>
References: <20260914090440.552884-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914090440.552884-1-quchaosheng000406@163.com>

On Mon, Sep 14, 2026 at 05:04:39PM +0800, Quchaosheng wrote:
> Convert the Holt HI-311X binding from free-form text to DT schema.
> 
> Keep the example and the properties as the original text describes them,
> including clocks as a required property.
> 
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> ---
> v2:
>  - Keep clocks required and drop the clock-frequency property. The
>    original text lists clocks as required, and clock-frequency is an
>    ACPI-only property of the driver, not part of the DT binding.
> 
>  - Drop the variant-specific handling that v2 introduced. It documented
>    properties the binding never had.
> 
> v3:
>  - Rewrite the commit message in imperative mood.
> ---
> ---
>  .../bindings/net/can/holt,hi311x.yaml         | 67 +++++++++++++++++++
>  .../bindings/net/can/holt_hi311x.txt          | 23 -------
>  2 files changed, 67 insertions(+), 23 deletions(-)

Isn't this like third version of the same thing in Patchwork?

Best regards,
Krzysztof

