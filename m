Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1C43712D
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541111; cv=pass; b=ArH2vGNlloGiyU/+af56qKGi79jkRAkfgm7a/FtqcWhyxORGaoQWlsWR+Hj68tQYkNR0FI3ROYQwxAR0HsNe+eQ+y2Ghq48CRa3BgnCHJxy5IZTv6UD9diE+8K+he3JKob+U0j7EwHaEplkhHIwSdqYuT1iLFPeiQebpNw49eWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541111; c=relaxed/simple;
	bh=lydgbnjAt5H5bGeGXUKImcvvbWgf/oYt6BrCC/2ceZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=vEH5mgZ9avrPVv3d/dYxsKi6/11Y7Qo90dqhDqdqo/huw2MPWTJSV/bX1EzkHGwzhIESpNQwms32buvMcgYHF+NZ5wSKuq6WqBKg+rle26y30vED7jxFthK/QlehdUN75jS2Dhi3m0XNBtFayXNW9RsOFWaEAlDrirVwAxqvIo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=b5o0bt4M; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=+ndIQzVx; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="b5o0bt4M";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="+ndIQzVx"
ARC-Seal: i=1; a=rsa-sha256; t=1791539305; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WYn0VW7IFa1ZThL4FrKj2BPJuctUYcyZNgPrWBMvPnMNgfTBhA2J2QqRrV3UxBEfbr
    FbpbyQQ06CONYoVqWyQL7ZmooaglEm3fOnVX1K5UfUHpw5FasfemN4P4vrahW1pimvb0
    4tgefRCrT+Yv+xCn6ogDDlr6gqjdEZSg833ew0VGf5+4RGaHk/fgnadIk0ypN6TXt9y/
    UAFEkLj3xanDeajZli7MwJFbpuEH0enSk7kq6nID/RgRzLMn4kay9Nas74n6yjUh+dSF
    qIcIsgftBC2qkBK1bscZgWBgKteWVvOaNlQhctgvx2fcLhYp7ZYFz/kUyKY19Da4XLpc
    8VZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791539305;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KcWqvHp3bHDAccrOLsi9vZRh2sQO99iMykq5gg1p0mA=;
    b=hXwA6SVGCNsIEgdpCDl0McNhl4dPlpnwLQ8pnVSFtuH3nTTZ98ytkFYCTLASGsRo5e
    1s2VgX/qYdNHCd0vitPJFA3/7G/jicZa6avd5kmRBE6VNe+ZsEdlhvObZ3CfmQG7QkVY
    MjyOM/LgGkoWP4pCkMAFoooPniGQ4aVATvhWfaamlMqfnwZcCaGPd0kiBebpiagmI5Ly
    J3kWbehRFyvGfVZWr02B7JLje9iu1l2XOE9QiCHTl50LvZcyTmDnf33zzuxlz6iJjeZu
    7u7KlRYhdkEhuZBmDpJO/adWwgNM7JMOAi+FNJrT4qBvhtkyeTaNsp3U9SraSny8Zryh
    FfXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791539305;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KcWqvHp3bHDAccrOLsi9vZRh2sQO99iMykq5gg1p0mA=;
    b=b5o0bt4MaUMgrVMtd9WwoWpZ5KDdwDbw19ffI8mdJFIvm7iIZxe/KFSG2ZJoQxhnSg
    9nnnz3fl5Zyc5SKP0kLYvkefNSIRjE177SO0Y9bQ8Psn+Xo7c4Yr2pEdvcJZKd3Z66yH
    Zbj5E8ZilKtcrvQgxa10b581M3EKK+FGdXcYQsDEGjRJOxE6fEXQw33rkt0dQmNmBMnZ
    x2YDXa68LSZzk0W1wu62IYaOvSbozDfBgQjDx+rR2V6ZQxNVgYMPLiud64zhx1n1GX7W
    t0vJu5gTfsGMISRvXgVicvCeTsP54MmMy8VcIcXxPinEF2RnNiu53KPpWaYnT/0cO5YV
    Oxtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791539305;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:Cc:References:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KcWqvHp3bHDAccrOLsi9vZRh2sQO99iMykq5gg1p0mA=;
    b=+ndIQzVxXxkMvhezZM1wn2OZs++NvmVsmLfNY1jsre/k+qkdm5d+bPpvt9r830CrCd
    S1Xuk51lddAFpZfe86Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K04b9a2999mOSXU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Oct 2026 11:48:24 +0200 (CEST)
Message-ID: <a5860c87-b034-4cb2-9995-763c6b2cf58b@hartkopp.net>
Date: Fri, 9 Oct 2026 11:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: can-next - Re: [GIT PULL] Networking for v7.3-rc7
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20261008192253.574195-1-kuba@kernel.org>
 <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
Content-Language: en-US
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179152126269.566079.1895099510348236501.pr-tracker-bot@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

now that the latest real CAN fixes are in Linus' tree and I can re-spin 
e.g. the patch to use ml_priv instead of ARPHRD_CAN:

What is the status if your can-next tree? Which patches have been 
already applied (e.g. my Softing PCMCIA driver removal)?

Against which tree do you want can-next patches to be sent? can-next or 
net-next?

Best regards,
Oliver


On 09.10.26 06:47, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Thu,  8 Oct 2026 12:22:53 -0700:
> 
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-7.3-rc7
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/af32da41b0327b9c6a37856ba82b6760d6c8d10e
> 
> Thank you!
> 

