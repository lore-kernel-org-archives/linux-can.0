Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578838;
	b=L5+OTokdRPxBer4Ft1Q2onIAZp3bblBGGZTDo2o2WWdILdDxRvjg0lbKvVfWDkxweGfl
	 G+Q5TBE9DoGW+U0ZAfrc4DEYwAi66uOKuqrzLMCX4+IhOBjMWTvzF4PziBWNlYJIrJf4m
	 T76zfnL7+/bvrGZaY+oe2Y8IiBHUqlPsE/hjcg0HtK+cK5AQ1jElG4cO8N5JAWydvLrT1
	 0nPgyTJU5SUW0bdJGuulFB9qpWemtW2zx5CzCakRZBdOqKnwi1AqWIYIAZ+sp3w2P5ASS
	 riIgqZzDQg6soazSKCptU0BacciWBrfh/vmPqvRbvhvM6U5xJ/4/FZHiulkqX2BFEzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578838;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=VLCjGAsbLjZCaIJo9je+NLiQHN8b6glnq3nJHIIuFZss864wK5MHTOxEJSctaWPKr0aW
	 p0Xz7B6A6hv2RxrhTHcAPt0kmPtQFsDlPFreInXvBvYrzC2IdbEYQOqveY5LS90puWAyW
	 vSJ2NPTCRQHwMXKFfTr42DYAgnMgPFCYWO+HxYixjUzWLXXR/5TBsexLrm/Z59mLQz04w
	 noppjhfh7yRd6+CXOs1c27dxXbCafLDSRJECeyIsRbfB96Kvil2YEYSplbxXKRsjP0PRb
	 jDHSilAw0qllP3b11OUM3mBJn3oeG/g+EG/YZ4cku23ALZRATy85kZXLn3XO0D4i7lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Gr4Ub/lQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A8606A319;
	Wed, 21 Oct 2026 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr4Ub/lQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1241F000C9;
	Wed, 21 Oct 2026 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578837;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gr4Ub/lQVuhKjS/xXFXOIwIkPTzZ9wD8D2EfIP+NdoMjG7dbYzC9eop+wZTpPBtfO
	 ybXCx/EniZONzodXzWJKc1MCbXahorjO4DQFOaSF9CGbP7DHUaasgCUHXzUXH92Ua+
	 zelBCZULMgmJ8DDUUmffe34sCuse671p9/JIAOiJvCxMbbLdfrbd0g7g7/I2b6Tp+m
	 uDBzrsEFtsH/pjcC+frqv/df9Yd4xqhQA7hzcXsbZvyDWzHeR+xO00WHL+LwBHGKpg
	 IVtouVjDd7Hu8XKLbPUAAHx47tClCymfXmkrQnO+D9DHsuObgfwXnI8QbuWPKh6NPF
	 WXmCcklAGXQDQ==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net-next 01/11] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
Date: Wed, 21 Oct 2026 10:33:56 +0000
Message-ID: <179257883662.3290.13718519694562894239@kernel.org>
In-Reply-To: <20261021102756.1900679-2-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
 <20261021102756.1900679-2-mkl@pengutronix.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
