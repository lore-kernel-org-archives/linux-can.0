Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794773417;
	b=qhTWvvSvFzdKQmQaDkPqo/PIsPQ+J3V/QKvLO3UIZLE9KB7P0u34YA4DWwIr9tOru4eA
	 scWKfdPk/b88avHwHB9CfCd9Pcx8u43TegNz0+TNw9nIsfSZKiik+ruWpCFsNvcNQmtMh
	 ijtSbWA/vAHS+KBtXK/Jth/fWf2Z3NPqrzSEG2J5xuUMb4rg0cH0Ta1Hfn6ShaGdJsu2U
	 u/Whz4GVHIM16EIjquIyLQTEtx+RR6a49i7jSZl8YAB1tU2GZcMtx+3qfGd/SbFcFOg9D
	 yPMcgfFKpM7p3NvcFW0uPznhE3ChaihBwhGLgoTKkCeEjVar1CbnN1PeTI7kycwbuSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=k89j0klejlJ5i4ghMD80b6dEKgWpMrJ9ACnXV9pOd6nwXPMP7/KNs1C+yuz/WNBE91kB
	 UQsGPgyT9cWqpsuLM0dS1QJOWeh11DvrpdRginqbrGAW3CRnsevFGoOqE+gc/KyXNhGsu
	 wsZ120SWh6EUOkTJMgz0gSwJ3AB2dhRAIMIw4el75EaFJaZSYxANIH09Ra6IDtE7iSCBR
	 XBgE5lvsHsLW26cRAep/Qn6X63PoaX5QydMmKZMoN/VI5nbrqorWhhJ+Lj4Vw4QvelFBB
	 YPk97WlIaGUbuzAhJf3cLgciGziqfMTtg5h84t99ZsPB4xncD81XJfDq04LAVeWav2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfkS4o1z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F734606A329;
	Sun, 15 Nov 2026 20:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfkS4o1z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837041F000C4;
	Sun, 15 Nov 2026 20:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794773416;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GfkS4o1zA7kzAzGRDoJ2Kebro3zhCSX896tJOf3Yh9hqrSPeG5e6SqL3V2NmsCyQX
	 VCE/9bxmB0xdMXX0ltl1bfYabcQi22N1qfLX1elEDMO9YVyAn8Oa9LV06TKhY35S3C
	 n1qZcajVUNDuSstKghetDdZPQ0j4JbQ+ufykH48gv9kluXHO9Bh5fuAUWv4AFpskJ3
	 /AE/L3cQiVQx9kTkVnlNjYW9QbQNRxuK1FNdUzu4BgKc31GPgWpDwpQjYpgDnxu6vO
	 Y5YHQdQq79gxCukrtSt/rjfJomz6v2vU2BKsHD7clprRFx5qWwIDJnRlUKvqkKVjvc
	 AfwbejU5zqHRA==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net 0/9] pull-request: can 2026-11-15
Date: Sun, 15 Nov 2026 20:10:16 +0000
Message-ID: <179477341607.3291.10763139949238980953@kernel.org>
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
