Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.181.97.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591891;
	b=FXWANRdznbFSnVMZJ2EjzBiI4eN3pNWXR4xS0wh8S0M/8ORdx9D25xU0BvfnKLqlL262
	 EaEz+PizzqKPWwN00Op+z+yc/Lj4fzcWBgXqRThtotSXsp7vd8u5OO+MS9rin+qavNzxP
	 BCil36e3ZXz4GrNEoDZizGFiCm7xQl4zMd7Buox8qLXd7dLg27HFGIALvSPEGUW64mWRI
	 Rgd9oNz+gXQ8pJXPxI/kDabMH/O6qr4NtZ4b2HR+EA3dJl+diOIeEv9BebcZntjOko+Cj
	 BBEP+iiRxN4E0ZUGSJWnbZZoauEFZ8F1QclulDHWmAcMkX3Kd1RvP0VbuP81hIIqelQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591891;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Virus-Status:
	 X-Anti-Virus-Server;
	bh=vyI1Vo2SKOKK1ghD7aKKWXrxuqjXjdk16MnUtPMNK9o=;
	b=Wc+AoUARj35ff5c9yqpn95yVpS+qFoS3prC1PQ08MSAFG1cnrbN0hqhBZVzFODz8xecP
	 t5GX5eSZRtcf6T/3PibfR8fi2tQrxdE6hlyi1+GI1jtPrsV/j/fEvPcSqI+ufF8Q415fA
	 atovVwgL4mPnU5HIQBNBUmNo8vWOqyKyt0SOdpNUO33HMTnCfSqqC4QtMlJXXrwPcQuEI
	 71ZIxwCxqqOQJEcl8fwD1uQeATDhqNwxcCXUZJNp0HF/iwlZisMECTCQpPKyyfUuugEo7
	 FxepzqvH9c4YIuIgjS9ecCksEyqHsNx1XFRzDNd8HhV2sqjJNw6GPoieuzKj/sHElYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=I-love.SAKURA.ne.jp;
	spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp;
	arc=none smtp.remote-ip=202.181.97.72
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3E1606BD2E
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 17:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3E1606BD2E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6ADHiWpf093287;
	Sat, 14 Nov 2026 02:44:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6ADHiWDt093284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 02:44:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3dec8321-5a96-42c0-91d3-d1776e974d73@I-love.SAKURA.ne.jp>
Date: Sat, 14 Nov 2026 02:44:31 +0900
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
Subject: Re: [PATCH v12 1/3] can: j1939: fix possibility of UAF in
 __j1939_ecu_release()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>
References: <8de287d7-b4e1-4062-b40e-b193f5ec68ca@I-love.SAKURA.ne.jp>
 <20261113-raspberry-wyvern-of-greatness-248341-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20261113-raspberry-wyvern-of-greatness-248341-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav414.rs.sakura.ne.jp

On 2026/11/14 2:21, Marc Kleine-Budde wrote:
> On 14.11.2026 02:13:05, Tetsuo Handa wrote:
>> Since j1939_ac_recv() and j1939_ac_fixup() are calling j1939_ecu_put()
>> without priv->lock held for write, list corruption and/or UAF might happen
>> if the last user called j1939_ecu_put() without priv->lock held for write.
> 
> Your series should include a cover letter. It should provide a brief,
> informative overview of the series. In addition, a brief, concise change
> log in the form of a bulleted list should be included in the cover
> letter.
> 
> All patches should be a reply to the cover letter.
> 
> Consider using "b4" [1] to send the patches, there is even a web-hook to
> avoid local smtp servers.
> 
> [1] https://b4.docs.kernel.org/en/latest/
> 
> Marc
> 

The reason this series is growing is that AI reviewers are not happy
unless we fix the deadlock in j1939_ecu_timer_cancel() at the same time.

Can you take patches incrementally? At least, I consider that
"can: j1939: fix possibility of UAF in __j1939_ecu_release()" is
ready to apply.

By the way, I don't plan to use b4, for my spam mail filter drops
mails sent from me.

