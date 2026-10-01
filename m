Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4242845348A;
	Thu,  1 Oct 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868355; cv=none; b=CD4Ov4P1933p+nQeoUqKvddpi/TzmI+wBZAUr2DoJTszcgoPlCFrxmolnb9Cp/NpmRtpA5l5C1Ir08L2L26x57/S98hCGBlJBFiB0a7bEOx/3vM418YqBs+DGP0Ge5nxgKoKeVpSzuoJdgJpKcuOwxIf+GBrvtd3nVRvZVam9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868355; c=relaxed/simple;
	bh=jbYeAgRBLbmIH13YBNQfdJjogpQnN34oE/VzD7zD81k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0DC7XlLuXnTMP2U8tcYU6zIUFP5xS613s06FTXWLYlw6D2rWT2xk/GzkOzXvhbV7PXdqcsKLZDqLCHFGa67Tf+Fg4XH/gXnQHlvPPgCmtirxfo+vf+61RqZM1BAr88cVNZQPo6VA9+gufNGqoVEnk20A0FgNGZoaYjNXAbdtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRXPc/zL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRXPc/zL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CF91F000FF;
	Thu,  1 Oct 2026 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790868353;
	bh=o22oYhY13ayGEzd/g8uAIvjzkDgowkm1GB++w3LQcs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cRXPc/zLUyJw2dfrnxfscTPkJ1MqxmR+fAYE6O76cNV/kB2oJX+K7ywkYMotIkrKX
	 WqnDHoSeFu3dki8mOQT2Y0XGetuRtEdgpw8a6evfKuAaoEl9skGQLNd3s2ElcQLSeV
	 uRuX3gNEnNItbQgYg0QSP3UDOBdsdha0alDSH8PG6Xk/wKoVO04uO2AbOn7dSanf7U
	 foD5dIViebbS3HB5XzKcbzbo9lh2qQn2aSQd13ySw9gHSLPzmlG/xaiqpch9Y2PiM1
	 pVdsE8d3DGeAYSJrl/mrZZl/T8jajQN/OLxHVMqvxNUJIYYVCareaWqLs5dbOJjq5Y
	 /kEtEctZW010w==
Date: Thu, 1 Oct 2026 08:25:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, ore@pengutronix.de, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, davem@davemloft.net,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/16] pull-request: can 2026-09-29
Message-ID: <20261001082552.514c54fd@kernel.org>
In-Reply-To: <20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
	<9956662e-6001-413d-864d-d8d048a93819@redhat.com>
	<cb83d0dc-58a4-4262-99a0-1e4478630ba0@hartkopp.net>
	<19ab3d46-f326-4f08-a161-d31ae272a9d8@redhat.com>
	<e4a05f3a-7206-4fe4-b04f-bf2a9f1fb926@hartkopp.net>
	<20261001-fascinating-clam-of-plenty-5307a0-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 12:55:59 +0200 Marc Kleine-Budde wrote:
> On 01.10.2026 12:28:48, Oliver Hartkopp wrote:
> > Ok. The review on Linux-CAN ML was done with
> >
> > gemini/gemini-3.1-pro-preview
> >
> > https://sashiko.dev/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net
> >
> > While the PR netdev review was done by
> >
> > bedrock/us.anthropic.claude-opus-5-5
> >
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929210700.1183036-1-mkl%40pengutronix.de
> >
> > @Marc: Can we switch on Linux-CAN Patchwork to Claude Opus too?  
> 
> Don't know Oleksij has done the sashiko.dev integraton.

Let me try to plug you into netdev-ai one for now.
