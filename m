Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209823AE87
	for <linux-can@vger.kernel.org>; Fri, 21 Aug 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311020; cv=none; b=J1DHrGsqVuF2Eoe+CkObcyZNbKfkk2nTMO53l+FpY+aU8n2NxIaiDpuQFZXDJjAj54Pmx4iLOrJmpxI1YWBiioEoo6dXvjmlfn25Z5cXQNEbhFijUBHaFBIxZn+yNZI5bagGc/RDIh2gTVaB1mGm7sN20pk0s3/Iu2E4l7/rw98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311020; c=relaxed/simple;
	bh=Z3H9fLbAPne5B2Pq0yO3so/Ji8jAUMnmA+pauLz1FfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cETFqP3+xJyc8opPo1Dnz4rbUuiUgkwa+3qxmio03oiQEKF8Xv4TXvdrKJln2YcUbbsualSfe9qqs6WTCCKLhCzeNzxZJGVKaiW8RUOMnBPRRI7j7Oo/7oxKdFCv9r2tOx/LOJ7yI6wdyHiJ4a4uxClLTrV6hJ07+yP0yqzsSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67LBGU4c083540;
	Fri, 21 Aug 2026 20:16:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67LBGUre083537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 21 Aug 2026 20:16:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <df552dd8-105f-40fc-8c71-3065198d71f0@I-love.SAKURA.ne.jp>
Date: Fri, 21 Aug 2026 20:16:29 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
To: sashiko-reviews@lists.linux.dev
Cc: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
 <20260820164024.DA7891F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260820164024.DA7891F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp

Hello, sashiko.

On 2026/08/21 1:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Netdevice refcount leak due to a race condition where the unregister notifier misses a socket during bind or re-bind list manipulations.
> --

Thanks for the comment. However, I consider this is a false positive and won't cause a permanent
hang. If j1939_netdev_stop() is temporarily skipped because a socket is missing from the list
during a re-bind window, priv->rx_kref remains non-zero. This prevents __j1939_rx_release() from
clearing the netdev mapping (j1939_priv_set(priv->ndev, NULL)). Since the netdev core repeatedly
retries NETDEV_UNREGISTER notifications as long as references exist, the next retry window will
successfully capture the returned socket on the list and execute j1939_netdev_stop() properly.

