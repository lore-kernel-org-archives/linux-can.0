Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2B3749FC;
	Tue,  9 Jun 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033724; cv=none; b=Z6h7/m2RLiS7VtCQBiBkkQ86CEDhnIOiZCScmHjxR71g5JO9q2PPVjoHvDKcZfs5Lkszi/l2WwBWYtqa7R9VQmnrLpJ6YC9j5PVkEs7qyR6E/reDa5NwmbucGg5z1QNxZKyicasxN5wxmjfS7BArM2l24UeZTErywuprh/15HEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033724; c=relaxed/simple;
	bh=nRFmzcUaiHWslIfHZ8lZBNxlTfe/5tE9TQXUEp8ZrBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/jMwaDhDifH2pvFZmDNqAKK7cq87EnGz8M0/TV9BRcclWRiBfkjpDvgvfxTN3mbPT82jG3ErGW/vLT+mYo3gnxPBLLOoMBgYwJ89iWxf2lOCM6c4KkwRTdW72Qk27VDPK0JgS7NdVbAyHnPckoDF/3UIxYcGm8sdVH4vdhrzP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd9LpgA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd9LpgA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43171F00893;
	Tue,  9 Jun 2026 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033722;
	bh=zlJ1izUT3b9sB+0io6mLoy0ZthPU0QciI8/lQC0mX9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Gd9LpgA160cfB/pEN+PDzhkZ7LFCleunnU1M3IKf0IBlUIXaY9QDopSebbZwf7Qag
	 zmI6cLLBqG85XVBYEbj7bjBLOMVvrqsLXzqWMj61mrO1T1VsR8piS+6wF0FnWWPVhF
	 TDx/+A6liba/InHQbSj4owgez1kYEOio+3iYbeOnFQfQz4uyp30QI0I2IJf7txJ1OD
	 oDe61jjzYrLbpC7JlmU+jsvoS0KqTN32C7spSsDS7CDiYjnnHO8FpYuvheF3CHDeG4
	 CE5LRVhcsNTfVnjbCmIaGxlomAlGWu/7bN1PtYx30agk21czw/andOX84PRjlDvvUI
	 Mtd64NkMtPrfA==
Message-ID: <e2dc8425-fdcd-4a3d-9d00-1416395aea82@kernel.org>
Date: Tue, 9 Jun 2026 21:35:17 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] can: flexcan: use dedicated IRQ handlers for
 multi-IRQ platforms
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-2-ciprianmarian.costea@oss.nxp.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260609142954.1807421-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> On platforms with multiple IRQ lines (S32G2, MCF5441X), all lines are
> registered to the same flexcan_irq() handler. Since these are distinct IRQ
> numbers, they can be dispatched concurrently on different CPUs. Both
> instances then read the same iflag and ESR registers unconditionally,
> leading to duplicate frame processing.
> 
> Fix this by splitting the monolithic handler into focused parts:
> - flexcan_do_mb(): processes mailbox events
> - flexcan_do_state(): processes device state change events
> - flexcan_do_berr(): processes bus error events
> 
> Introduce dedicated IRQ handlers for multi-IRQ platforms:
> - flexcan_irq_mb(): mailbox-only, used for mb-0, mb-1 IRQ lines
> - flexcan_irq_boff(): state-change-only, used for boff/state IRQ line
> - flexcan_irq_berr(): bus-error-only, used for berr IRQ line
> 
> The combined flexcan_irq() handler is preserved for single-IRQ
> platforms with no functional change.
> 
> Fixes: d9cead75b1c6 ("can: flexcan: add mcf5441x support")
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

