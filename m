Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126736;
	b=dOw5mgkfIsUJYQmieUIuRqpsv58MT4SjvmPBaoCklWNYr99iUPgWQSZojS2WHfY9O6S5
	 Kq2O3YTWGLqnfDLDZh81Wr5o+Mxizin9Le2JGruaTzh+KUkkVIdS/oAd6FnyhafPJrOH+
	 265N+KmwTL+xpTywhM8r/3CtU7o9BTxswc6lanUj27MZrexOwo03HYpE1Qkn+jpk08cUH
	 OYDrbEpHsgthoWso8gcX1qOMV0nEoQf1mbkg7Tk0FBgMWbH/dT/W9MaVimXwxGgYGP5s9
	 hGpfImK+QRxqbopCPhx212fYWGuZw2RQBSaa8/TeO5rdbnhH0zxh2m5ncOQeHhKQW2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126736;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=m0CQlw7rltvrv4g+3EmEgZkv/xYP2Y1BYH0r8hnSFZsP5cl3RfwwV2X0OjPbecZixYTK
	 uJ22YKHRScHc4uEPQnPBSPhPUg2XgsdZipbCj1gr6xrPANEySJPXktyYb1r9+TdSNxe2l
	 4AscB3UUbtjyi6r2iniotZYqBB1Z7LXmka4+XIrvr0LmVXiv4XNtJoky8TmeaN7Ij+xEs
	 vTvXHJeLfVVy5TfFHG+6EuQ2WwZy1Biethdj2zBuiAOtFE5UxC/PCPKlqsbagLgCk/V0x
	 O0Mm08aPIRzmgLRWD4fwAa8XHV7CFGbh+RC444kNc2kDLJHTD51xvkEUZGZ2ApRTq3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcWh5VsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E82606A320;
	Thu, 19 Nov 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcWh5VsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62461F000C4;
	Thu, 19 Nov 2026 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795126736;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcWh5VsFuWAEbS4DeBJBV/8wYAEtnsiTm3sSaEScqNdTKm+WkU7Lhlx2G8QPT9hDf
	 8/9sV1AylPrQGmWgqzXauskmPm2ucyUsG4z4QazWu/AlCDctMmw/Ft/x10R7gUkPHI
	 G0Tui5iNANPgAsZrhClCFOAFDgPzg3IwTBbudJKgZ6PjY8kfMMsjlHVVoBEo7KzohP
	 9WZ0k3Bmpb8aoMeFkz/ZFUuEYN12fgezforH/qxW41b67p8R35nPALYxx18uGylTK4
	 MfDm5ibythDFUuUkWZPXtwi9SttEaUjm8WwON9eIgCMhfhkfO96pEkmWorTBR02xz8
	 UmlLmaIXyeqKQ==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 =?utf-8?q?St=C3=A9phane?= Grosjean <s.grosjean@peak-system.fr>
Subject: 
 Re: [PATCH net-next 01/13] MAINTAINERS: add entry for PEAK-System CAN drivers
Date: Thu, 19 Nov 2026 22:18:55 +0000
Message-ID: <179512673520.3291.7584679191508386933@kernel.org>
In-Reply-To: <20261119220936.155728-2-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
 <20261119220936.155728-2-mkl@pengutronix.de>
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
