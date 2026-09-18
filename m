Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41E4FDA68;
	Fri, 18 Sep 2026 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789767078; cv=none; b=J7I/vSWYPSWMJHHf2clW9X1XIcCzu7tG+2WP/sFkDJBiCGuW2cZBOV0w1KN1Fj3xzjt9kl7PoJMPv6IU2u0MlSZzA4vIQ7OEcCi8F5ctijLSQl4XQlSKVZPQS22cEtzyw16kLwjnHeQ4mHnVS5J0LQJhAf3svtOe6NAkSNrXLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789767078; c=relaxed/simple;
	bh=27vDI4HCdeEhF882pyuUVXFi5jDXbUrqx7zRuSwr10c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRcGjlCsnP6YRc3jsrxuQlXlxE9O4CDWiCYvbmYx6ppoD2Dnav47Mq78v0TaSZmHgrDYK0oA9RMNOsXgbGMNDv5WWPG6fux3UBrHoWa/Y60hAOsYYlz6C4mZ4Uheyg/gDJqMi14AyN+HfGqJXUDYaW3gV0AtlyBQhvIGfokdEc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw2S6CIR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw2S6CIR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961331F00899;
	Fri, 18 Sep 2026 21:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789767076;
	bh=Z+F1Jge/gf40GN3Yo+EVNabMdoX1NFaEc5oX4U7ou/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nw2S6CIR9Qn0VzHmdhz7BHlYs9e8iUx4nc2EKnbeOLQTHxgJe2B0BnRzmB8xdNUAI
	 8U5R7aMABBrOf+k5Iyq+78oGnxZ5j5i4eLS41bBMt42tebvCdBcvQpb/xF72rNbLGF
	 8e6gKLMlK1rBwzgaQ60BKvj3branqxw4s5EsG/fl0NWVDILvuQ23FNZJhXqn0hOmqO
	 Tu8FU7rHpjIxLHTpOTlME/n7lK2sXt15+cD48KFhhESucFtMVOS55I5vZWPRQ5HSU2
	 opGpB1TtaCoUhV5yodaLf6GRyBgZnu6n4fFGZ+cgDbWyVwmrABQsZyqqsLFopBKmBR
	 0aiGg3J3pn42Q==
Date: Fri, 18 Sep 2026 16:31:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-phy@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Vincent Mailhol <mailhol@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-can@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: ti,tcan104x-can: Fixup unapplied
 constraint to ti,tcan1042 family
Message-ID: <178976707447.2333712.12279602327236946063.robh@kernel.org>
References: <20260918110116.94024-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918110116.94024-2-krzysztof.kozlowski@oss.qualcomm.com>


On Fri, 18 Sep 2026 13:01:17 +0200, Krzysztof Kozlowski wrote:
> ti,tcan1042 is also used as fallback for a few devices, thus the check
> in "if:" conditional should use "contains" to properly validate these
> other devices.  The other compatibles used in the changed enum are used
> alone, so it does not affect them.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/phy/ti,tcan104x-can.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

