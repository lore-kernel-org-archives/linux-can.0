Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501215;
	b=bu+gWUi7vZzcii3+nrCmfDDRHxGb5UjQGSBEs5mr40nJ2Rmh8+Fkpbsylpfgv5n/xj45
	 tcOCmWB+qxuknutzKUXB48KxHF4C54ZjDsoHs+bUmXV7rEDDaUjvHn/xZ7uHaFkbgezST
	 oMcAM7dP8Y3skUyH7pSFau944m22RsNRI3fRceR3a0FEBGQmR7qQPLhHB8uhI9Mp6zwCN
	 b4R81R/ouMx2UcIWHPcJZccSFZuquoYANRyG1PA8udt4L+xjlC7lBp4cM7Omm/0diN3H0
	 Q5MQKuT6MIf2y+fc+/xkUZY/ZYg7t8szN6LWkIKHvT+GheIQAv71R+1LXKpODiDxaZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501215;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2T/QcvQ2Yphv/huMc6rBh8hKk0f1eB+rNviqWaA88NY=;
	b=Y734mgGcTV6kHl+l7WGaMOrAyQv5suCXPYfQM73DLdIAIQ9ns7K+YdTtpB6pTeHwxr60
	 VbjS5woUX2QnKnOp3C3PBM1eep1G702RnxpzOGSELXI61jx3PuQBRDHMXSE4LfZ2k4Uuf
	 PggoqZVDDfdcy7+XaQAZUPVdF3UKehLaTNZJKjPcWrBpx1kzDVm6lc5AxmmZccfVLxJfh
	 1tgnr5LvDPjs628g/YNz7XirTTxzEcH9io7ZP3Fq8BIYKfGj3o3cK1yff+no7BFWmv4kt
	 1FRsW0e+7GW4cZORdFIn3Pk+sF4S5MoheAezt6qi7zk4rnMlHw1WnU2b9PwzZj38zTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4pAzdKF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C3D606A88D;
	Thu, 12 Nov 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4pAzdKF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF52B1F000C4;
	Thu, 12 Nov 2026 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501215;
	bh=2T/QcvQ2Yphv/huMc6rBh8hKk0f1eB+rNviqWaA88NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S4pAzdKFnKVDyxqeD82aiS1QwGVgCR01falNqvoUebLF0aMPqNOmABLpTrygnPmCj
	 boD58R7DuJaLCioWbLVsvmlqYdHx5J/yHrfmmh1wnS5qNdYkZyMPXeQOxSmJ8blPZO
	 AC88g4RlfBLDEViaMDnRSQVSP2QpWbIMlGOf9w1IP1QrjbjmsDZx37rEmh90d0nJcr
	 ISRFghBtE2pH4i98RjNo9j/qfgLl3b6cdfj02jxrWdvkuoVfCehUKaO4HajI1spCD5
	 QL0DVOWnqv61ya7IYLU7XLYpdujQcjdkEVGcSUlArGopZorJpf1MmVH4GkLUXvqJth
	 /6IzYxdt10hPw==
Date: Thu, 12 Nov 2026 22:03:31 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: ti,tcan104x-can: Document
 Microchip ATA6563
Message-ID: <avXqWxBQBK2lKPMv@parshuram>
References: <20260930214729.809649-1-marex@nabladev.com>
 <d8c3ca76-3d93-4abc-8a78-d23e0f018975@nabladev.com>
 <auGdT2kdxwfbB_ol@parshuram>
 <0865fe86-3ea1-4ebd-8ded-642eff159b97@nabladev.com>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0865fe86-3ea1-4ebd-8ded-642eff159b97@nabladev.com>

On 10-11-26, 14:59, Marek Vasut wrote:
> On 10/28/26 7:59 AM, Vinod Koul wrote:

> > > +CC Vinod, is this patch OK with you ?
> > 
> > Looks good to me, I will pick this after rc1 (monday)
> I would like to do a brief reminder here, so this won't get lost, since rc1
> is now out and I don't see this in dmaengine.git.

I have picked it up in phy tree...

-- 
~Vinod
