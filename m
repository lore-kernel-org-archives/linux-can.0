Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33936403B;
	Fri,  8 May 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278359; cv=none; b=bph2/98lEkH7MTis7bViJwCtsd+MT4ZeRz4gdlkncUx7qO2TGB6uq82KllavY6baxY/ZR5uXYNzEOFGpNWKqTVGm5/rPpC5ADgm0Zy5vlYUc1/4FNq7ElJmQnkzIsegQNRJkgYm/1VFvmeAtRdMZWomr/S/6Le+D7UKSR2MSweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278359; c=relaxed/simple;
	bh=EXFu3dbPq+W4HjNloEeAKnwcJiIEWBNLUBj9vuURyfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1ziW0CNrSN+x7vhoDQN0jlq9D30AMlX4NblMjzH6v18jDJ+vTIWfXkRk8HHGtWYaXQCXxksdk0b0ySH6u7omppHzl/MvklnIWiJBSaMo2ooF39ENoLFMtJN5iPA8wY2xTUDhnlagWyv+GUtFCshpBKG9NKxKOBs5DErhqCcXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnlO75o9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnlO75o9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903C1C2BCB0;
	Fri,  8 May 2026 22:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278358;
	bh=EXFu3dbPq+W4HjNloEeAKnwcJiIEWBNLUBj9vuURyfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CnlO75o9EKo2lfd0L5d5WAEyAgYxUb+JcqBT2DLKUZslcrBS1Z2chmutOVtCGiXBE
	 g6Bk/wLinZBJt1VI3jn3p76vT5/MQxoVUCUaY0wqP5vbPSBcXPQvGUd8rm1AwpNg33
	 W+Kbk+HOhz81vkQZsFt1U5QVBZ5qfnS8l7gsWB9Z4ot1fkFFPQzyKRvwTfSGDd+hAu
	 XKWXjO+pu9JDmrhdEsHmygwe3GliwZGXhxFNU++0U/P1rcllnRQmKXxT/tCAAmhc5Q
	 M8a/OhbEZOgmRp0nWL72ydShelw3XzeGx+ifhlkgXkbRJf1BMwhSguCZiO70/A93af
	 b/9XEgob0eYrw==
Date: Fri, 8 May 2026 15:12:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Lee Jones <lee@kernel.org>, Oliver Hartkopp
 <socketcan@hartkopp.net>
Subject: Re: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260508151237.7d0a9105@kernel.org>
In-Reply-To: <20260507112321.439968-3-mkl@pengutronix.de>
References: <20260507112321.439968-1-mkl@pengutronix.de>
	<20260507112321.439968-3-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 10:22:24 +0200 Marc Kleine-Budde wrote:
> Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> synchronize_rcu()") removed the synchronize_rcu() call from
> bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> timers from being rearmed during deletion.  However, it only applied
> this check to op->timer via bcm_rx_starttimer().

All AIs point out this is insufficient:

    reader (bcm_rx_handler, RCU) | writer (bcm_delete_rx_op)
    -----------------------------+-------------------------------
    test op->flags (no AUTOTIMER)|
                                 | op->flags |= RX_NO_AUTOTIMER
                                 | bcm_remove_op()
                                 |   hrtimer_cancel(&op->thrtimer)
                                 |     /* not armed: no-op */
                                 | call_rcu(bcm_free_op_rcu)
    hrtimer_start(&op->thrtimer) |
    return from RCU section      |
                                 | grace period elapses
                                 | bcm_free_op_rcu() -> kfree(op)
    thrtimer fires               |
      bcm_rx_thr_handler(op)     | <-- UAF
