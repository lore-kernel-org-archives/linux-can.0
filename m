Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6F1D9A70;
	Thu, 15 Oct 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029449; cv=none; b=S522MnLXVtY5ujit+s16b1rqzxxzo71NmNInHHDRURReLs6dVFAVrPaON5KBGePJOA9w2KzIRewT3Bt+WM08is6zpaDgRqsWWmomxN03p7vOq3sFcv9oEUZaHP22EjB8wUUckcP7z7YB4j4gcpLw3sp8nUYNtVXHzvefqnGjMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029449; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=acJrmMnQvJgUdVCDoJz7mVra70GgskbI8QHvwJfeujTN+4GxWnOoKsQ6zCTDdRmWWK6K94TQEaXpWh9ONvez6ShDtoBym8GDugGlOvtUwqsG00Qrn2PwRygciiXaNE3DEEX79ifkNzS5wL7XqQCZEZRuZV6ZfzjC7T+uGCNw1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKDkZdg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKDkZdg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F11F000C4;
	Thu, 15 Oct 2026 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792029448;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKDkZdg0JY9W0icOtNJKon3VG20eGVhtZOL01nwXJ/pPTbRUkXLQT0LqUQKEaWf74
	 a8tBmt+YZlUCucO0OC2KVjGTBMKzTs99tyRowBzUTonmiJxdzMXpLlFWuecU8qPfUS
	 NJ5EmlwN/kREowgXrXC0O+eE8xDhrhLEiXfLPhZlkE9JsEoTq/MYAvhJf4NP7FqRXG
	 d0yKNbjrCppgGEzicTgPdn4POwoTJnQ9VENCd33uqlwi5GNFIJnkbsYjbuDXosNnJx
	 cSVFhWoc66kfQ9V2uLXPwSt3UwM0G8s0YmwGfSTaUn0ty9JRzzO1GJCURm6EfGaODi
	 2oy9w2OWwYRVg==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Vincent Mailhol <mailhol@kernel.org>, stable@kernel.org
Subject: Re: [PATCH net-next 01/37] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
Date: Thu, 15 Oct 2026 01:57:27 +0000
Message-ID: <179202944723.408196.14576860852925761610@kernel.org>
In-Reply-To: <20261015015336.816543-2-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-2-mkl@pengutronix.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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
