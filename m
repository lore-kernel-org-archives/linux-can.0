Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30A3B0581;
	Fri, 16 Oct 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131317; cv=none; b=YRQ3DlZfhfiizDYV9WW7G8RiE96T8d8xXHJe8kOwH/yGP4gSqcLIBfIXoDp7nE2vLG4HbWlijTuo7LmOpsl4SYzqTKTs/2MmagORlnz/43F+6aS1qpG+TrfrPchj24DzmMDTw4pXaDxI2dzFPH9GEEKXrUydTOxmBHi1033NYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131317; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L4x/1I9+/hA3xH/QD5h8jzs1VNExsK6w+1nqxgDptkI+G/iah8OYUSd4qZ3NLOaLmiHcnwJXAVpDj9QmpwiT40yfDC/KB3slEfVUxGk14TDrThlpBVjEHUiW8XtwLwBowGYQ6S6us5vC9QlXgdtjYsCmG8X36W6oYx5rfijSCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfAzhktt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfAzhktt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5A71F000C4;
	Fri, 16 Oct 2026 06:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792131316;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OfAzhktt5MRCSrpc3e75DPg3TXV9kQkIpB0THBRYAkkLpXY602JDk1OhBqhVSA3cd
	 DJLAestRbql6GMjU6+njlzaW6jWVLNJ60OBYmnSwYc8EBszN4ENThmWS9uHJyz/8DL
	 xJQI87j9BQPqFof1RZxN9/UzR7TtrStTtN6N4DwiislFlEtM5hc3Fd16Orm7+txGsB
	 9pw8uJkEoHSN3DWduIv3wXqiOP68GJ/7YpvSBUAAln+nTuufmodgVMdCopzOtLkUaX
	 NZMmWbFi0/5y7im0cwajCSvIvrWqECmMB39hioTZ345KZpq6AIkCTeEGVsgYm5gxhw
	 rzNj9GTiK/wug==
From: netdev-bot+sinfo@kernel.org
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] can: don't discard the platform_get_irq()
 error in probe
Date: Fri, 16 Oct 2026 06:15:15 +0000
Message-ID: <179213131512.408196.11368789495251891862@kernel.org>
In-Reply-To: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118040.git.chaosheng.qu.linux@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
