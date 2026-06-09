Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F13559F8;
	Tue,  9 Jun 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033916; cv=none; b=DxKPTVey1kbhkiPBtgJJDtZ4rSMR7wANJlkNxARm9bOb1YZR2Q54qrlt+ln2eVcGlghseAXAzofCyrp9QHmn997jY/MvrpH32eIKHadCCT4lH7qC0VLvBvg8YcsCzfaf393EvfpSAFBbHtUYQp0F8aMDbgHTXANO8yqQ6zUbqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033916; c=relaxed/simple;
	bh=+dQuMW5qRZhhFJiy7NYGx1VhL7gm8SG75s524dWhT7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mviFDnUgcOaGrVEHrNV88wJ8b/7U+S19BEuZYECv1CntrOLmyvUVrKU/7sF5jPDZMlAgVkT/8nF5T/CcDLPKnhL6BfnsFU5ynGIAcGnWRybfy//DtYYsAf2NUMR3rLbRkov3ZOrzdXQ8oCwHweJex8WoIMFEkP1gStsuoTZPZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5uKct6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5uKct6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874851F00893;
	Tue,  9 Jun 2026 19:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033915;
	bh=wByOLPXiT9PdoFohP3YN91tzflVyNxga+TQMPZo8YjU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C5uKct6CFAHyGKr9yH2F+BXO0ZvXZkFWO2bwyrudbe8jR6lk1OWKa+UVYxWSi0uGz
	 v+AztB8A0GWr6dJ6+dXIiFxRZxV3NE6Py7KkBmSHV97VY6H7Gzyx5DdUdAV8Z1NRL/
	 fCTok+s2RuuHN+x6SunvO5H6rPR6QyOR5sNQ1oelgmBGq+h5EZ0xX1bNBkMB12rfNd
	 FgZqBI00D6ir4LqU19QOkrNsaAubu7WsfnSUaLR50xLYGIU06aluLWLM9xK52+0bUn
	 WCKTywi2pcRz05n5NkX+r9XJsbDbH/+XHa769ExIks1XVRz5mnEef65JxunQAQQ6pY
	 rjO8kwSI91qNQ==
Message-ID: <094d85c9-145a-4d7e-a55d-35da920592d1@kernel.org>
Date: Tue, 9 Jun 2026 21:38:30 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
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
 <20260609142954.1807421-3-ciprianmarian.costea@oss.nxp.com>
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
In-Reply-To: <20260609142954.1807421-3-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2026 at 16:29, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> flexcan_chip_interrupts_enable() disables only the primary IRQ line while
> writing to the IMASK and CTRL registers.
> 
> On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
> err, secondary-mb) remain active so their handlers can fire while
> registers are inconsistent.
> 
> Disable all registered IRQ lines around the IMASK/CTRL writes. This
> also fixes the resume path, which calls this function.
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> Reviewed-and-tested-by: Haibo Chen <haibo.chen@nxp.com>
> Tested-by: Enric Balletbo i Serra <eballetb@redhat.com>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol

