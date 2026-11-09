Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.232.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244933;
	b=fgzuQmzOR6NjXtNzdWf6zzSo/SeATD3yl6LRtBnBiPOAtPh8SQdYzOljxbedXEWfhqR3
	 m8xEfOxH77eyLn9dEsj78NBYq+3TDhG6LfR74KJChkqzPlEfAT/oPWGJzUprP3KyKs6pj
	 r9cU1sx4lKZ+1gMBvC+acKkdBft1fy44q/nDO2Vtd3mS0xhK9Mxa3iFaFKOZyk3V76hZ2
	 BqYHth0OCTOEipt5IseQYr56Q524K0wECth3O09yevOVLJFB7JARqD3/uNDCwTMdamB0Z
	 9b10F+Jp2Ex1FkGJlNhcBJ8pcnyYybcsOCLX6X6s0wGtg1laF+ZNZ1CIF2HIgU3vE7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244933;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=3EWOE7fT+whQhBFHgodgp1m4XB9MbxSWBAhpv4yJlYw=;
	b=q4o5X/3kr3ie1rGbJxw2EhDzqdY3JXlaqDW/K43vWNaBYDJKoYqbHOkjddnjTuHFAtBQ
	 JWm16CRnzQfT16TYSiu9O5TMGwKSXeKDDNpQlf+xdklalurrtVjuvPtDSzSZJlQzJo47s
	 HYz6PhTsk2Hn3vDhI9R415WbMBMYFFSpZYyrJu0qlgnwQd6/u2fvTjXJxmaJyGyC2Tmqo
	 A8jj9zBXnRkmE+L+YzGEmMc9nRXck+yYN/IgApRhxuoQNkiKZK/ye+4oiUK+f3m5BsUMZ
	 xxl27X96PViIVmwxla74a6FeBOtmcdfCSzBqCwxdsjcdNfMBdXDwC31TgcE9OVvqT9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=enpas.org;
	spf=pass smtp.mailfrom=enpas.org;
	dkim=pass header.d=enpas.org header.i=@enpas.org header.a=rsa-sha256 header.s=mail header.b=FTpAEu9H;
	arc=none smtp.remote-ip=46.38.232.102
Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E7606A321
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 17:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 478E7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=enpas.org header.i=@enpas.org header.a=rsa-sha256 header.s=mail header.b=FTpAEu9H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enpas.org; s=mail;
	t=1794244923; bh=3EWOE7fT+whQhBFHgodgp1m4XB9MbxSWBAhpv4yJlYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FTpAEu9HGxL8m2hW9cvmi8JFzzrnOhDULsDPIlihDD5O4huxAqUCogYKhHl1FE4Dy
	 7U4VkHfxBcbrlYSUMbEB78ljkZpGhLfk60GDCue/pDAQ3ZRRyfYq8Ix9qiiEt0baAw
	 vsc4aFnVJQSVoyp986jZLVcsKgTEXXJbISZvlj13/9A/Ulp6AHwqhQ0LUkW+kwforw
	 8WhdUvgpkLRcImmY6xAJpmbu7qMVcyQ6nB+3Z5J1dq3Hsfv84waAEVVLx/bC8dMl2o
	 /Whi0FVnkN+s4fCvq4i0kuSiDIR6+luIM9MWGyd1NfE9pd1jmTO/exWo0sP242b9Ct
	 hNNXAXUAdZ0bg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 69618105205;
	Mon, 09 Nov 2026 17:22:01 +0000 (UTC)
Message-ID: <c9e14a02-c360-414f-9808-8801ba18544d@enpas.org>
Date: Tue, 10 Nov 2026 02:21:57 +0900
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] can: can327: publish tty->disc_data only
 after register_candev()
Content-Language: en-US
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com>
 <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
 <sashiko-outbox-175333@kernel.org>
 <179289472575.8393.17187271051946169028@gmail.com>
From: Max Staudt <max@enpas.org>
In-Reply-To: <179289472575.8393.17187271051946169028@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chaosheng,

Please excuse my late reply, and thank you very much for your patience.


As for your patch, thank you for suggesting the improvement. I think 
it's a good idea to leave tty->disc_data in a sane, or saner, state upon 
failure.

However, I have to NAK your current patches:

By moving the line that sets tty->disc_data after register_candev(), you 
create a race against .ndo_open() and friends. Right now the implicit 
contract within the code is that the ldisc is set up first, then the 
netdev. This is not interleaved. But your patch interleaves these, thus 
requiring a review of SMT safety between the ldisc part and the netdev 
part, and potentially introducing new locking within the drivers.

That's a bit much for a cosmetic issue when debugging.

To make my point a bit clearer, quoting from your 0/2 top message:

 > The series removes a trap for the next modification of these 
functions rather than fixing a bug that can be hit now.

Racing against .ndo_*() may not be a problem today (I haven't checked 
though), but it'd be counterintuitive for the next one to touch this 
code. We'd be trading a "trap" for another one, like you say.


By the way, with such a patch that crosses a SMT boundary, I'd be 
helpful for the patch message to include a discussion of why this is 
okay to do. It makes review easier, and shows that you've thought it 
through :)


I've been scratching my head over this patch for a while. It's a small, 
well meant patch, where I see the good intention of not adding more 
code, only moving it. And yet, it actually complicates the code in a way 
I haven't seen a patch do before. Something felt off, and I couldn't 
quite put my finger on it.

Then it dawned on me, and I'd appreciate if you answered purely for my 
own curiosity:
Is this patch something that an LLM suggested?

After all, LLMs are trained to sound convincing, and maybe it led you, 
and then me, down a very neat looking rabbit hole :)


Okay, so here is an alternative suggestion, which I think can make us 
both happy. Instead of deferring the "disc_data = ..." line, how about 
simply setting disc_data = NULL upon failure? That keeps the SMT 
separation as-is, you get your nice NULL value, and everyone was happy 
ever after?


Max

