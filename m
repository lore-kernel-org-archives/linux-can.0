Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09C3B1ECC;
	Fri, 17 Jul 2026 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279999; cv=none; b=Hu2vEyGk2i28xqaGsSCk/K/+jt9MsxEPa935OchAeaBk9+DLtqaHTSbFtGCVLiHLxGaKRxlBHUYJpG0ymvt9fRzEaiUv0mYMzPLTlLHLq0FpSI7uULjkxKYTfuoU27hCNtV4CL+Ds5QXlvGK1CBUrN9Xm8JcZyG0VmpBara8Q8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279999; c=relaxed/simple;
	bh=rt27sqet8exY8bpHRMb6kIRwNADORaCqn41delLCpCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STBt9Kriy6SxgwaR6gUZF8RuI7pBh+HLEMbcWpwjrHYsIDcMwuJTkK8Ucbk4IfoNLnh+bf/KRXFjP8oPz0D9cdLSb+LETbAOHZQJYvyQ3kCBnKuxOFGb3Lj2zQcIaqfavtFuwRpjSvuQf3BTo2zIS+mdigIbp5oEfSiKdtQCxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi5jrNct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi5jrNct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADFF1F000E9;
	Fri, 17 Jul 2026 09:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279998;
	bh=fH6R8hn0ak8zD7fv35y08My2tU9GV+iZZyKJ5q64h7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bi5jrNctuBSBcjGj6YGUX8fsIAEr+SfhD0fN/WvTQ/IGK5FM/5nDQ4lN/KoO4MLy2
	 Xz1zFFW/TEpu5/PBuJXPl9dng8eNTuN70mddIbcdzkqiCjMGz8QUmVnHkxx0+Q37bd
	 zMvS1ZSH9tkxNHjhso0qmC2rlWLWrD7na/OVEMwNQX/MT5b/enTDPBrSRO9zn6WjiY
	 H2RzMftbNwFOdCXuCdZJZrSu6H1bUgpzrhfZjn2Tx+kSIpfT5Lzd/vtzSG3edIVByk
	 ytCGhenAFUTnZqRD/ByAwuyz2FQ4JM2kFYeN+nnl0MjNwrFETMjCQW1fTiy1URfBJv
	 ylrbtYhavXKJQ==
Date: Fri, 17 Jul 2026 11:19:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harini T <harini.t@amd.com>
Cc: mkl@pengutronix.de, mailhol@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com, 
	appana.durga.kedareswara.rao@amd.com, linux-can@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Replace maintainer for Xilinx CAN driver
Message-ID: <20260717-subtle-perfect-scallop-1d18e7@quoll>
References: <20260717021415.2234865-1-harini.t@amd.com>
 <20260717021415.2234865-2-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717021415.2234865-2-harini.t@amd.com>

On Fri, Jul 17, 2026 at 07:44:14AM +0530, Harini T wrote:
> Replace Appana Durga Kedareswara rao with Harini T as the maintainer
> of the Xilinx CAN driver. Kedar is no longer maintaining it.
> 
> Signed-off-by: Harini T <harini.t@amd.com>
> ---
>  Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
>  MAINTAINERS                                               | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

