Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874814;
	b=F+JX76KHlrDaqvdbUT+526Iw2tyipG3eYiiKrJtdLx9wSON+OiKJGpy/uwpLJNHAeCeQ
	 TS24cpZSwmYOK+df49kqWGdQsMEPmP4j3p5AbwwPxTozacVTwBOFp6829OVA4huEDjYQO
	 6QoD/To4alneOefubagqBlm19QORS/wOHfRatOiKSVgeChueWomAExGUvNTvKt1E/J9Fh
	 4sUNMhuk3xrDAZLTgP/1h/tCeWQCi+UYniAr6u7qDiqlOOcDM4CyPKaY4/K09YLbU/N0i
	 6YWZ8O+62JzVDG1xP3KNaf68v7wRPM4kTq9B7qNFJ/6kxwsRfmvICEn6Ht0KRShHKPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=c1Qw+fK1zKwsCLLrGTQVQVYyJN7HmcawuWunxu5oAJI=;
	b=1IwzPZx/Kv/awIk6Q4baWSZMfwIb9ITMJsE/ckSgZCS7X8vKZzrshhiIVzqtaGFh4ZE5
	 uSvcr72BmKOh3s3lqobWzIJxwb+YJ0SGKtaZSoytDc1cKdHpdkTB13kRl58sugDIJwbQn
	 +3UYPfOLV4nNvp5o76W76J8l0wHEcBhv/E/k4JDR4AAC90G6x1uNfXAk1+oBxnNGNQ/2O
	 DZl2zfoAIQ+lI2sfjf823HS2I70UDHoMVAAhykvET00wumUZh1MuvbmpEUPfoi0Qka8gf
	 6g6gnxvlOJpOc98sLHokLnPNpSV49GD1/VK1RR8bdKXc6XZ4qfwOMNJcoAa834lR5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j04otoJK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE52606A333;
	Tue, 17 Nov 2026 00:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j04otoJK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4373E1F000C5;
	Tue, 17 Nov 2026 00:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874814;
	bh=c1Qw+fK1zKwsCLLrGTQVQVYyJN7HmcawuWunxu5oAJI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=j04otoJKWSllEwsXwDk8UNEJc2jK71Y3oxhdjUzcoZZNeIGMGALsxexQyDWjwxvzY
	 qzeHvMOsekfOGJ/ZWAr/JkXnDtbS0/kftD4XGW5mWktwFcth7Q0SvYvOl/eY64yoXH
	 S35N95bLrVyh8I3biZl+jSmZ54XuJazjskK4uPrVwZzCcJF6qYimFbipNqbmQyJtS3
	 WC18h+dwZx55HjbSoqeFMInbpNXXG/hGMubYyijgb/5i0Lqoz8cbppLDsoSdkpSjUr
	 KC3zG5wUeCPlpZcJ7YoZOBpol1ZT4f9JAie2HFVNf16Ue7HTHF9kRh057bAi/qBU/l
	 06cHo5wVB68Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A352391AFE7;
	Tue, 17 Nov 2026 00:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: can: ifi,canfd-1.0:
 Convert to
 DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487481277.257811.5528472784391485936.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 00:20:12 +0000
References: <20261113071325.4092169-2-mkl@pengutronix.de>
In-Reply-To: <20261113071325.4092169-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, quchaosheng000406@163.com,
 robh@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Fri, 13 Nov 2026 08:08:49 +0100 you wrote:
> From: Quchaosheng <quchaosheng000406@163.com>
> 
> Convert the IFI CAN-FD controller binding from free-form text to DT
> schema.
> 
> Reference can-controller.yaml. interrupts is required: the driver obtains
> it with platform_get_irq().
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] dt-bindings: net: can: ifi,canfd-1.0: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/0efc358417de
  - [net-next,2/7] dt-bindings: net: can: bosch,cc770: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/489a164909b2
  - [net-next,3/7] dt-bindings: net: can: holt,hi311x: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/f0d13562fbdb
  - [net-next,4/7] net: can: cc770: update the binding file reference in the driver comment
    https://git.kernel.org/netdev/net-next/c/8c4de4078890
  - [net-next,5/7] dt-bindings: net: can: fsl,mpc5xxx-mscan: Convert to DT schema
    https://git.kernel.org/netdev/net-next/c/1911b1c42960
  - [net-next,6/7] dt-bindings: net: can: convert grcan to DT schema
    https://git.kernel.org/netdev/net-next/c/ea1907f738d0
  - [net-next,7/7] net: can: grcan: update the binding file reference in the driver comment
    https://git.kernel.org/netdev/net-next/c/194bf22b60a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


