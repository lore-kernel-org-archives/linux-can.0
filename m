Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19A2F8EAA;
	Fri,  8 May 2026 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278321; cv=none; b=Oy2mGyVR/sOD1s+lPmwPKtk8oO83FUVxe6bJgy0h732cBuj3tHEug6wW6W2wrXRCDWMMP5d4SfxRgPKbF0aXp7ufn9errGZnEL5eugX2QnZaa7lHqNksrZzV9z4rpt/r1MTj6ym3+odpbEP6IUANCdiQ/yXPLJNV5VpCWOIdB4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278321; c=relaxed/simple;
	bh=LkeV/ALn0czsawBXiy7GAAtm0EMvNk/rpiQrvEi75D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7uAyM0P2YtoqFqaLwOxVNUX0AgcfLfT8Zoh/dad6LKDWlo1yfWnjLI05wTCQYueaIR2JN4ZbbQZWh9CSuohIIfZf+7lxypc/BU30KpHoR9qK3nI1xjCwO8uCaYHHOEtQsNAWxTRYbuHBRKccuCjc9Q1xCzVPyE4UuUrAv94ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx84vVH1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx84vVH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F230C2BCB0;
	Fri,  8 May 2026 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278320;
	bh=LkeV/ALn0czsawBXiy7GAAtm0EMvNk/rpiQrvEi75D4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dx84vVH1FnHKECcH0UJeTZo/O7KIixErG/2sJodC4mdU1dvDtEcg8x8CjJYcaUVNy
	 UkNx2hLhgH90V/RsKDWHriPrG3mzHA4tjLp3mlkV5D9oIu3Qlfl+d0al45gChQx4l9
	 K9zKclZ6/RqLTx6JVjMSEhksWdiCpQZ0MiVeUutD0yH16dE9oXEago7GfIN4+mNvMf
	 mq0E0068ST86xgtLR/FX6fOdsuSuTtC2aFhjj0SGv/gWyNbjStlGQowPIss92Z10Ug
	 hA2OxGmbma/5DORT4hlxBzLvkBLPbdIVVczI5DVJc975l2t8s+JNUcKvKgZkzG5uXM
	 E+dV9ZGqSNy+A==
Date: Fri, 8 May 2026 15:11:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Ciprian Marian Costea
 <ciprianmarian.costea@oss.nxp.com>
Subject: Re: [PATCH net 6/6] can: flexcan: disable all IRQ lines in
 flexcan_chip_interrupts_enable()
Message-ID: <20260508151159.71fa563a@kernel.org>
In-Reply-To: <20260507112321.439968-7-mkl@pengutronix.de>
References: <20260507112321.439968-1-mkl@pengutronix.de>
	<20260507112321.439968-7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:22:28 +0200 Marc Kleine-Budde wrote:
> flexcan_chip_interrupts_enable() disables only the primary IRQ line while
> writing to the IMASK and CTRL registers.
> 
> On multi-IRQ platforms (S32G2, MCF5441X), the additional IRQ lines (boff,
> err, secondary-mb) remain active so their handlers can fire while
> registers are inconsistent.
> 
> Disable all registered IRQ lines around the IMASK/CTRL writes. This
> also fixes the resume path, which calls this function.

Sashiko points out that the driver is requesting those IRQs with
IRQF_SHARED, I think you should also clear that flag if the QUIRK
is necessary.

Marc, sorry for the delay LMK if you prefer follow up or respin
