Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792624721;
	b=ibV3BdJV9eHH9K6KJ2Ih67XdrzUSlrxOcbkijRzHFH7iAuv9Ok2U3+zJ7asjYHSJAxPH
	 0f5UzlPRDmZV6oPvzsQFNrBGwcHrIU/m5Y+afFxFe8oiGLOUigqGkGMufXQOyIVViX/fV
	 XQIcHmZrIcOQ2t7pHoz5ktvLqWnVKQ07cnWwigk9D8O/qSZI+2yEu6LapmX/0LoN+WC+P
	 GXwqbus+8NlcjRimfPCL/8kWFq3l77Zu8qFn9scts4Eb00X3dFX7LnqQlJcQ5rgNtl0Pq
	 9W7lEuTY0jjTt+A97MxDpNjwNSxA5ZdgjWyklt7xRUlAqb7gY7P7UX1yoKnHVUmKp9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624721;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=fY92CqXZw8Nt5QKc4xNpNaj4UCy55xIZC/ENe4BpUH3jvsn+z2rTJsNzMJoH76qskAuu
	 cEKUuafsqctlB+ebJ4B7M5BY5qgFI0xsS6M8CX32QgYyg19SeLHPcuaKnOiJ8lZl9h2Jh
	 24zywHjOAgIkPuU1M19a+ZEjbNBUSd/XqqnAfgBj7b1CLQ16C0TWHVG5UsizlQpVWBGhI
	 0X7F2BGo0eqGHB1SsvH23U7JVdlyivxdoYlPojM1nIFK6PGB7ad1HFmwceUcQBNSIoBEe
	 Jg+d2WEYtOKSzaIEJ5MisSE4w20a+8kAVuGcf3kR8HAqo2gFBkEnxxa4j1UMP3+Ycrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnIwoIky;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25006606A319;
	Wed, 21 Oct 2026 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnIwoIky
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357E11F000C1;
	Wed, 21 Oct 2026 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792624720;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnIwoIkyAUNkHmH964JwViH/axGom6FbDz/mh0cgbsKg02Kdk9RGNccOwq6XEhm+H
	 VHcScGTdYhOuklca9kKxRPUIjzTQb5Mcj7XF49AOpUnM9S6L0GJtJnOSfhimulL2zP
	 +kLyqsRwcmMnaQcwcBGTRQYA/FspaFTWrFvLeWOxuaP61xnSIVzVG+KrSPUwvQwT4J
	 vsedzosxCoudnJgzv6/4AvX62q/F1uwTCi1A07wS4V14YrnIW1yqkQauY1JsE2k+dP
	 Quehbj5nFzbbBP8ApZ503cz7MKfTqtkfoq937WDxiwExJR04j9N3K/D7V+U8SpSfTi
	 u5vagoO6gftTg==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net-next 01/11] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
Date: Wed, 21 Oct 2026 23:18:39 +0000
Message-ID: <179262471968.3290.2971997478619589981@kernel.org>
In-Reply-To: <20261021231130.2085690-2-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
 <20261021231130.2085690-2-mkl@pengutronix.de>
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
