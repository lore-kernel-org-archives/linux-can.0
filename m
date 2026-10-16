Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD72369D47;
	Fri, 16 Oct 2026 14:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161059; cv=none; b=JJ4lD+o1K6DlsjF1h8NedLFxA/QXysjji3Ox1z3J8aI/LMZUyHqRAj75PEyyzdIAwHoerOuDeQAG6JOUoCtCK3DXhVwlxFVSeQHItv7KEOddtmrHnf876BANEJAaAMql64WgAXMEqCDb02WqVbax2UzV/BF4LsMr+ovlVC1pAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161059; c=relaxed/simple;
	bh=JFPTy9V3/Al+yGNezlNHX5Lcqefw9/okxFnrMJCgA3U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lueR+LbpHULbNS00VOkWWNfB7pQGdULqU6sYffdmpjheLnlhUMvnz4L2Tt9U7hxPmmGgvdKItZ0l9+Q/7NN1OrtF6OO+1bcjnnG/WSsU0f/4nRypGtdJgQSgSeqo7V+KrpgVOmHscH91oljsonoWg/XjhlC4nsNIxgYXsJjE3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; dkim=pass (2048-bit key) header.d=enpas.org header.i=@enpas.org header.b=X7ZZwbt9; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enpas.org header.i=@enpas.org header.b="X7ZZwbt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=enpas.org; s=mail;
	t=1792160659; bh=JFPTy9V3/Al+yGNezlNHX5Lcqefw9/okxFnrMJCgA3U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=X7ZZwbt9lqb+o+vkiSo2kANwRnTmdq0ocdkYRpPKYBkPa7QFS0+iXixZ1VeFS8dCB
	 GzA5Bjt7oReQSZMN6NQ5tr/t3Mh6IMba6oFIQPrApmTdnvYMc/fTdaXpmgPX1r7Hqt
	 +UVskA2p+RVSDMOhT0DMRHM4Qzhg0z8he8xkWsWMvfrNitltWXpnBUNnwy21Sa/mZZ
	 y21ImwNAtwqS60VVXSZTktEtZNImzhBxnR2sr+H1qsicHkq7WlHmaz269lyj14kTmC
	 neYNJnfoH1LHRKUjEfDfGUNWwkjRqNhOSg7Fx4pKODC/rr39MIRK0QloXHLmNvuXl8
	 L12Flh44pESCg==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id B83B5104DD3;
	Fri, 16 Oct 2026 14:24:18 +0000 (UTC)
Date: Fri, 16 Oct 2026 14:10:00 +0000
From: Max <max@enpas.org>
To: Chaosheng Qu <chaosheng.qu.linux@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>
CC: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_2/2=5D_can=3A_can327=3A_publis?=
 =?US-ASCII?Q?h_tty-=3Edisc=5Fdata_only_after_register=5Fcandev=28=29?=
In-Reply-To: <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
References: <cover.1792118038.git.chaosheng.qu.linux@gmail.com> <e02d5a1d31bb8dbc6397e3469cd0578b85d78970.1792118038.git.chaosheng.qu.linux@gmail.com>
Message-ID: <7F7B6C68-4055-4899-89E1-5E5BB5A68099@enpas.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Chaosheng,

Thank you for your patch=2E

I won't have time to review this properly until the end of the month=2E

If someone else feels comfortable reviewing this, please go ahead!


Thanks,

Max
