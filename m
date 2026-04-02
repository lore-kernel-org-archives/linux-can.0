Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA72153D8;
	Thu,  2 Apr 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097047; cv=none; b=LcdNA0Zabd0BrfcbCOCbg41mH9j4x+FeeCinx06SMuNzVd7uIkaOhay/XG3lK41wmd1AMz6QCVr752RKj4GyuOHlfbZLs880X0uSFmSWIVotiQamtPd1aRxrEIyz+4YNp7oT8gOWx100g3oXuY6oo18pSAJ3ay0Vl63QL8XyH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097047; c=relaxed/simple;
	bh=u9jO/d+tjE5HUITuq2k3nNBzifTjF/tHg52G6x5MFWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=imZva2wIohKpMBU+0RN5Hq+7Ur7Mgyjwn8OmOkZ/7DF2IN3pBjYdAp1rLDJLXy4ZsnQWeplO+tk/ijbC2CKP0rLX5xxLuDxphGhdnB7SnwC5lU8Y/mfZrQfuxdN8xi2eUGUufOm2ho+Hcmh1WzVArjWfied56E6qLKuaeHeTq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8/4gOBg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8/4gOBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1219BC19421;
	Thu,  2 Apr 2026 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775097047;
	bh=u9jO/d+tjE5HUITuq2k3nNBzifTjF/tHg52G6x5MFWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K8/4gOBgKqBcOnF+bhU7i6LW8h/8GQsheGC1TaWrvpHASnyiNQR/w/zuSS2nfAdM5
	 XqO70TIxEuzkYyEQplIHDmn25BPRVOWfbu5cUzcuN8+149nDav+fWA/f40yNO91Vtx
	 bZ+I2aDXJGPJ9M0pUtQHyj0/o5tcIpG9rLttc6FqqXFkEQoCtEUKCleLGT+VD3XJfm
	 5LcZbFtxUfbo3wLgOVM24rAgvW0ZaB6yuRBd7D179/6fT6wMrXonXXmKwse5zputFM
	 FP/8NdQsoepVtR4faluK2im5hEH7JHpdLyporkeVlF1KUB2BAR7lCY4kni4nJiTnQG
	 BNLBu3bhWkfZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E5A3808203;
	Thu,  2 Apr 2026 02:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/6] dt-bindings: can: mcp251xfd: add
 microchip,xstbyen property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509702978.3957493.8041660566894873320.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 02:30:29 +0000
References: <20260401073338.5592-2-mkl@pengutronix.de>
In-Reply-To: <20260401073338.5592-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 viken.dadhaniya@oss.qualcomm.com, conor.dooley@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Wed,  1 Apr 2026 09:30:09 +0200 you wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Add the boolean property 'microchip,xstbyen' to enable the dedicated
> transceiver standby control function on the INT0/GPIO0/XSTBY pin of
> the MCP251xFD family.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://patch.msgid.link/20260321135031.3107408-2-viken.dadhaniya@oss.qualcomm.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] dt-bindings: can: mcp251xfd: add microchip,xstbyen property
    https://git.kernel.org/netdev/net-next/c/2f41d7867800
  - [net-next,2/6] net: can: ctucanfd: remove useless copy of PCI_DEVICE_DATA macro
    https://git.kernel.org/netdev/net-next/c/1e41cbbe68e6
  - [net-next,3/6] can: kvaser_usb: leaf: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/495fac90b8ec
  - [net-next,4/6] can: mcp251xfd: add support for XSTBYEN transceiver standby control
    https://git.kernel.org/netdev/net-next/c/ae20301b6119
  - [net-next,5/6] can: rcar_can: Convert to FIELD_MODIFY()
    https://git.kernel.org/netdev/net-next/c/11d94d3516c0
  - [net-next,6/6] can: ucan: refactor endpoint lookup
    https://git.kernel.org/netdev/net-next/c/581281cb5a1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


