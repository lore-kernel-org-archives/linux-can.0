Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE035E1D4;
	Tue,  9 Jun 2026 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034752; cv=none; b=rQXScxc4wQjpFGSajTDukBR+qhdUBZhmwbp8OmoT3fp/e1E4sIt+dg5lgZ4AxVuJhRd2oY3w9gp9xz1ySc+cmCbZsU8rct1j1Ikx7mfKzWbcv75shYTRffXyzZ4MCOl/qppcbyZY4C4mihfEe6cRB0R/yqwZzC3+5KGmev6E5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034752; c=relaxed/simple;
	bh=uREdzpOWzDpXQUxPec4h617amZsKL0obmF7Iz3VZ6kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m78/x3oVBVv1tCcm//IjQGj2x+FIwauFu2qUy9qVzR2McvJwXqKe1vDNGjwvki9lg+q5H5HJI4FjMYfH77keuz5E6sEMpplqk/vi82e2hF5XfcTF5qnUDsENg9Q57waZVPbsUDocAivLALIaVf6m9NekGvvoDPDveuTN3YX2t3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfc1Cw15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfc1Cw15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F91F00893;
	Tue,  9 Jun 2026 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034750;
	bh=tinAgCKBJ6C9VdHB3KI0GOJJKJagJfvxcuSFCa59zjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jfc1Cw15UXaPGXMHbyqnLDGEdorsJvHXsyJznXPC7w3DNBh+AQITCTLLUQy+Fw2me
	 eL76llUHL5l9/unbPYvQvNguAbB89fSkmm3ps59bHzVkmPeUxQZ4i+hsoFX8zhPYFz
	 mqt+E+cwkB9QmdcwJLtEFDRSu1GCmuPf9KyUviGYE7vrUOZjTAMuSACXstLuflR45m
	 oKMlC86Z9/Dg0ilHf+sM0vhdplhzMarvvcLPqLK0661QjNXc2DPf4DL9aWZv1gkkqX
	 jivlWW+wp75ygEpTVDlmUjkgCcY4iiLNZArt7+s9PtPwOR0ykAKnSrNUvnudSdvyve
	 yzuxKtPofmq6w==
Message-ID: <280b67e5-4b01-449a-928d-06c3843ad01f@kernel.org>
Date: Tue, 9 Jun 2026 21:52:24 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] can: flexcan: add NXP S32N79 SoC support
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
 Andra-Teodora Ilie <andra.ilie@nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
References: <20260609142954.1807421-1-ciprianmarian.costea@oss.nxp.com>
 <20260609142954.1807421-7-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260609142954.1807421-7-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Add device data and compatible string for NXP S32N79 SoC.
> 
> FlexCAN IP integration on S32N79 SoC uses two interrupts:
> - one for mailboxes 0-127
> - one for signaling bus errors and device state changes
> 
> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

