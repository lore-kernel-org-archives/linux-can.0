Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E80370AD7;
	Tue, 19 May 2026 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232282; cv=none; b=m42o3tUlaxmvsHIxReEgWU7isY/jnVZhKj/P9+5d48WSs1jgVj40mZnCuQzej0K0jm446mXnSSsuZ9zVVK2+hcUCHIFIOLsfqMvKVrR/G8blKrsfdM1P6XTOoaxTn7g1yE+/iFc+5vLvSKwRHQzmsf57DvvRuuXLzTVE+HrdRX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232282; c=relaxed/simple;
	bh=YD7hrNnZ+LoGGrZrA63xC/abtmDBd346/PMuRM1ctQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl1zEDB/cgsHLSZm40e2IWrAgJ3xcr0XhMMKcZ6Tx4M/SKkNFpSV2opWTVYd8TZCByRHoL3Fy8AuOx7HPx0yrxlR2pBhjBKAyMxledXahyv1X7gtFQzLA+AJ+iVD6QXqbdtRjQ/OkM3yyy9HoRQoaAbDN64FRpH3igZNcRTxIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orFloyPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orFloyPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C451F000E9;
	Tue, 19 May 2026 23:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779232281;
	bh=YD7hrNnZ+LoGGrZrA63xC/abtmDBd346/PMuRM1ctQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=orFloyPjpqgBfDnQPukJgkvQWTwMnrEMjLV7gbB9jrtlL5lNdbhxMkl49HO/HgSqv
	 8dXq5jyqx54H46usetvnp76vy7gvL7n5nSsmvEf1/Xs1d/RwLu7+TaerjnWljgDxwi
	 QklPWlOCRAaQPlCQHKsPLu3K5Oj+miE8dZPlkjVxDBnl4pFhu54qjouSAQk2QruL25
	 /99+rmBjRyClRH4NUBcx9bSQ8UqfvHoj19tLBLSCJ+E2ymr2JjEmUKSPXiKxPsxHDD
	 bqIdBi+kCyFiWYGFqw5T7IPlfUOauum6tt0/oaQPil1oCWK29uT+40yvvw3pwamOPn
	 KnspWq5go0Exw==
Date: Tue, 19 May 2026 16:11:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel
 <o.rempel@pengutronix.de>, kernel@pengutronix.de, Oliver Hartkopp
 <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>,
 linux-can@vger.kernel.org, Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
Message-ID: <20260519161120.1daad57a@kernel.org>
In-Reply-To: <7bdea3af-647f-4301-b9cb-3b8a75dc76a6@I-love.SAKURA.ne.jp>
References: <c109e9fc-3fb7-4a48-a0bd-a4d7663e7342@I-love.SAKURA.ne.jp>
	<ef62371e-ddd5-4074-b554-410c708ca1cd@I-love.SAKURA.ne.jp>
	<20260518190455.7fe355b4@kernel.org>
	<7bdea3af-647f-4301-b9cb-3b8a75dc76a6@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 11:22:44 +0900 Tetsuo Handa wrote:
> Do you mean that I should omit netdev@vger.kernel.org , and use "[PATCH v2]"
> so that automated process won't be involved before CAN maintainers send this
> patch to netdev@vger.kernel.org ?

Yessir
