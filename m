Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF123411F83;
	Mon,  5 Oct 2026 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791192973; cv=none; b=DbTAOTwxs1KR8/MWWu+IVVY3a7DOHXtGu9U7MIDtvrxwMdhQjzISiGjHJSzC1acJUmpqelafgKwtIroRodN3fAxOVUS5jgsvYFCSRfhlTQA0cMIj9agqVuPuF+XZQ2JT5qY5qSinvgrazk66B0ZMbieGMeSAXqIWQIrV4FzfWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791192973; c=relaxed/simple;
	bh=WwtwkI319utFrDtMTgBVWaxrm8/qwqTxwFJs3vTZvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/gPpxv94AtuVOXKkhXMECm9Y3H9iwS4NzBQqvToCxtv8KZtrvObbFVqnrocS+NjrDhFeHrbUn/Na14XdCoTPNqlEJysSysiHtijO/IMwHWSXHid29PxUIXU0K9mHKJ49qKuMq8qcgbbXv6q+4eKf4SuHnM6wQO7aP/208mF0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkAVn3g+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkAVn3g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D67F1F00898;
	Mon,  5 Oct 2026 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791192963;
	bh=0Ao/mLNTjmSkWmcOamQdcSXL9pFAvIeKIenqzfFwDYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MkAVn3g+inmSBSz5Fzu0VGiuBrdRC72Erc14Fo1fRXNMasfI6jc0ioFi29XAC4WUb
	 e0EMo8YHg0iO5T49/1QOyhu7gzVXYTKh1Ra03l2yI1N5pDAWyfWZGXnpgl/lkbc55/
	 /4VmY1qRBi0mp2CzzTYl2NnJxFED1hhZetH9teyAcddp5gm5QnYXPXWGJZV/4QHkia
	 XAzd7keTIL4Jh5vl2AFjtM5xzaF+4ZrTujk54/pMK4cdJIWOLzKKLGhX8DTxGdD4zq
	 Savyadu6JZABjEYih4G0DUtpL2Nxu0+8kPyqyfA9i5gEWMqPf/sl1/p+oNpRAfal6D
	 EaRDByI2FZxmQ==
Date: Mon, 5 Oct 2026 11:35:59 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: ti,tcan104x-can: Fixup unapplied
 constraint to ti,tcan1042 family
Message-ID: <asNvf1LZET8i7UoQ@parshuram>
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

On 18-09-26, 13:01, Krzysztof Kozlowski wrote:
> ti,tcan1042 is also used as fallback for a few devices, thus the check
> in "if:" conditional should use "contains" to properly validate these
> other devices.  The other compatibles used in the changed enum are used
> alone, so it does not affect them.

looks duplicate of c7f2322431cb ("dt-bindings: phy: ti,tcan104x-can: Fix
property constrains") ? if not please rebase on this and send

-- 
~Vinod
